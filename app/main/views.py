from flask import render_template
from flask import redirect
from flask import url_for
from flask import abort
from flask import request
from flask import make_response
from flask import current_app
from flask import g
from flask import Flask
from flask import request
from flask import send_from_directory
from flask import flash
from flask.ext.login import login_required, current_user
from . import main
from .forms import PersonForm, AboutMeForm, LegendForm, PhotoForm
from .forms import PersonSearchForm, MyrelativeForm
from .misc import populate_dropdowns, make_person, new_family
from .misc import populate_relatives, ancestor_tree, descendants_tree
from .misc import allowed_file, populate_relations, relation_dict
from .misc import is_image_small
from .constants import NUM_UPLOADS_EXCEEDED
from .. import db, cache
from ..models import Legend, Photo, Person, User, Family, Country
from ..models import PossibleRelative
import uuid
from sqlalchemy import and_
import os
import json
import re
from werkzeug import secure_filename
from PIL import Image



@main.route('/person/delete/<person_id>')
@login_required
def person_delete(person_id):
    person = Person.query.filter_by(id=person_id).first()
    if person.user and person.alive:
        if person.sex == "male":
            him = "him"
        else:
            him = "her"
        return render_template("errors/user_deletion_prohibited.html",
                               him=him), 403
    person.countries.clear()
    person.families.clear()
    person.legends.clear()
    for photo in person.photos:
        try:
            os.remove(photo.path)
            os.remove(photo.large_thumbnail_path)
            os.remove(photo.small_thumbnail_path)
        except OSError:
            pass
    person.photos.clear()
    db.session.commit()
    db.session.delete(person)
    db.session.commit()
    return redirect(url_for('main.index', person=person))



@main.route('/person/display/<person_id>')
@login_required
def mypage(person_id):
    person = Person.query.filter_by(id=person_id).first()
    return render_template('person_show.html', person=person)


@main.route('/photos/<photo_id>')
@login_required
def show_photo(photo_id):
    photo = Photo.query.filter_by(id=photo_id).first()
    if not photo:
        return abort(404)
    if os.path.exists(photo.path):
        folder = '/'.join(photo.path.split('/')[0: -1])
        filename = photo.path.split('/')[-1]
        return send_from_directory(folder, filename)
    else:
        return abort(404)


@main.route('/photos/display/<photo_id>')
@cache.cached(timeout=50)
@login_required
def show_photo_details(photo_id):
    photo = Photo.query.filter_by(id=photo_id).first()
    return render_template('photo_display.html', photo=photo)


@main.route('/cache/photos/<photo_id>')
@login_required
def show_thumbnail(photo_id):

    folder = os.path.join(current_app.config['MEDIA_THUMBNAIL_FOLDER'], 'photos')
    path = os.path.join(folder, photo_id)
    if os.path.exists(path):
        return send_from_directory(folder, photo_id)
    else:
        return abort(404)


@main.route('/searchrelatives/<person_id>')
@login_required
def search_for_relatives(person_id):
    person = Person.query.filter_by(id=person_id).first()
    families = []
    supposed_relatives = Person.query.filter(
        and_(Person.surname == person.surname,
             Person.countries.any(id=person.countries[0].id),
             Person.id != person.id)).all()
#             Person.city == person.city)).all()
    for relative in supposed_relatives:
        relative_families = relative.families
        for family in relative_families:
            if family not in families:
                families.append(family)
    result = []
    for family in families:
        result.append({'family_id': family.id,
                       'family_members': family.members})
    if families:
        return render_template("possible_families.html", families=result)
    else:
        new_family(person)
        return redirect(url_for('main.index', person=person))


@main.route('/')
def index():
    if current_user.person_id:
        person = Person.query.get(current_user.person_id)
    hyperfamily = []
    if person:
    person = None
    if current_user.is_authenticated and current_user.person_id:
        person = Person.query.get(current_user.person_id)
        for family in person.families:
            hyperfamily.extend(family.members)
    return render_template('index.html', person=person, hyperfamily=set(hyperfamily))


@main.route('/ancestors/display/<person_id>')
@login_required
@cache.cached(timeout=300)
def ancestordisplay(person_id):
    return render_template('ancestor_show.html', person_id=person_id)


@main.route('/descendants/display/<person_id>')
@login_required
@cache.cached(timeout=300)
def descendantdisplay(person_id):
    return render_template('descendant_show.html', person_id=person_id)


@main.route('/ancestortree/<person_id>.js')
@login_required
@cache.cached(timeout=300)
def ancestortree(person_id):
    result = json.dumps(ancestor_tree(person_id), ensure_ascii=False)
    return "var chart_config = %s" % result

@main.route('/descendanttree/<person_id>.js')
@login_required
@cache.cached(timeout=300)
def descendanttree(person_id):
    result = json.dumps(descendants_tree(person_id), ensure_ascii=False)
    return "var chart_config = %s ;" % result

@main.route('/youmightbe/<user_id>')
@login_required
def youmightbe(user_id):
    user = User.query.filter_by(id=user_id).first()
    supposed_persons = Person.query.filter(
        and_(Person.name == user.name,
             Person.surname == user.surname,
             Person.b_date == user.b_date)).all()
    return render_template('youmightbe.html', persons=supposed_persons)

@main.route('/thatsmyfamily/<family_id>')
@login_required
def thatsmyfamily(family_id):
    user_id = current_user.get_id()
    user = User.query.filter_by(id=user_id).first()
    person = Person.query.filter_by(id=user.person_id).first()
    family = Family.query.filter_by(id=family_id).first()
    person.families.append(family)
    db.session.add(person)
    db.session.commit()
    return redirect(url_for('main.index', person=person))

@main.route('/thatsme/<person_id>')
@login_required
def thatsme(person_id):
    person = Person.query.filter_by(id=person_id).first()
    person.user_id = current_user.id
    current_user.person_id = person_id
    current_user.is_new = False
    db.session.add(current_user)
    db.session.add(person)
    db.session.commit()
    return redirect(url_for('main.index', person=person))


@main.route('/person/edit/<person_id>', methods=['GET', 'POST'])
# @cache.cached(timeout=50)
@login_required
def edit_person(person_id):
    person = Person.query.filter_by(id=person_id).first()
    myself = Person.query.get(current_user.person_id)
    photo = Photo.query.filter_by(id=person.ava_id).first()
    form = PersonForm(obj=person)
    form = populate_dropdowns(form, person)
    if person == myself:
        dude = "you"
    else:
        dude = person.fullname()
    header = "Please use the form below to update information about %s" % dude
    if form.validate_on_submit():
        tarif = current_user.tarif.upper()
        maxfiles = current_app.config["%s_USERS_FILE_LIMIT" % tarif]
        result = make_person(form, current_user, request, person)
        if result['ava_saved'] is False:
            return render_template("errors/upgrade_plan.html",
                                   reason=result['reason']), 403
        else:
            return redirect(url_for('main.index', person=person))
    return render_template('new_person.html', form=form,
                           photo=photo, header=header)


@main.route('/legend/new/<person_id>', methods=['GET', 'POST'])
@login_required
def add_legend(person_id):
    form = LegendForm()
    person_choices = [('', 'Please select all other people involved')]
    person_choices.extend(populate_relatives())
    form.people.choices = person_choices
    if form.validate_on_submit():
        person = Person.query.filter_by(id=person_id).first()
        participants = set([person])
        legend = Legend(
            id=uuid.uuid1().hex,
            title=form.data['title'],
            text=form.data['text']
            )
        for person_id in form.data['people']:
            dude = Person.query.filter_by(id=person_id).first()
            participants.add(dude)
        legend.participants = list(participants)
        db.session.add(legend)
        db.session.commit()
        return redirect(url_for('main.index', person=person))
    else:
        header = "Remembered a family legend? Write it down and \
    select all people that were a part of it!"
        return render_template('generic_template.html', form=form,
                               header=header)

@main.route('/legend/delete/<legend_id>')
@login_required
def delete_legend(legend_id):
    legend = Legend.query.filter_by(id=legend_id).first()
    legend.participants.clear()
    db.session.commit()
    db.session.delete(legend)
    db.session.commit()
    return redirect(url_for('main.index', person=person))
    

@main.route('/person/new', methods=['GET', 'POST'])
@login_required
def newperson():
    user = User.query.filter_by(id=current_user.get_id()).first()
    new_user = user.is_new
    if new_user:
        form = AboutMeForm()
    else:
        form = PersonForm()
        form = populate_dropdowns(form)
    if form.validate_on_submit():
        result = make_person(form, user, request)
        person = result['person']

        if new_user:
            user.person_id = person.id
#            user.city = form.data['city']
            user.is_new = False
        # We need to first commit a person and then add a user,
        # otherwise sqlalchemy will scream that a person with the given id
        # does not exist
        db.session.add(user)
        db.session.add(person)
        db.session.commit()
        if new_user:
            return redirect(url_for('main.search_for_relatives',
                                    person_id=person.id))
        else:
            return redirect(url_for('main.index', person=person))
    if new_user:
        header = "Tell us more about yourself, please!"
        return render_template('generic_template.html', form=form,
                               header=header)
    else:
        header = "A new relative? Or an old one, but suddenly raised \
  from oblivion? Save all you know about this person, so that not to forget!"
        return render_template('new_person.html', form=form, header=header)


@main.route('/person/find', methods=['GET', 'POST'])
@login_required
def find_person():
    form = PersonSearchForm()
    header = "Search for your relative in our database"
    if form.validate_on_submit():
        runme = "Person.query.filter(and_("
        if form.data['name']:
            runme += "Person.name == '%s', " % form.data['name']
        if form.data['surname']:
            runme += "Person.surname == '%s', " % form.data['surname']
        if form.data['second_name']:
            runme += "Person.second_name == '%s', " % form.data['second_name']
        if form.data['b_date']:
            runme += "Person.b_date == form.data['b_date']"
        runme += ")).all()"
        people = eval(runme)
        return render_template("found_people.html", people=people)
    return render_template("generic_template.html",
                           form=form,
                           header=header)



@main.route('/photos/upload/<person_id>', methods=['POST', 'GET'])
@login_required
def photo_upload(person_id):
    tarif = current_user.tarif.upper()
    maxfiles = current_app.config["%s_USERS_FILE_LIMIT" % tarif]
    if current_user.photos_uploaded == maxfiles:
        reason = NUM_UPLOADS_EXCEEDED % current_app.config["%s_USERS_FILE_LIMIT" % tarif]
        return render_template("errors/upgrade_plan.html", reason=reason), 403
    person = Person.query.filter_by(id=person_id).first()
    form = PhotoForm()
    relative_choices = [('', 'Select all who present on this photo')]
    relative_choices.extend(populate_relatives())
    form.people.choices = relative_choices
    if form.validate_on_submit():
        img = Image.open(form.data['photo'])
        image_saved, reason = is_image_small(img)
        if image_saved:
            photo_id = uuid.uuid1().hex
            extention = "." + form.data['photo'].filename.split('.')[-1]
            new_filename = photo_id + extention
            photo_path = os.path.join(current_app.base_path, new_filename)
            large_thumbnail_path = os.path.join(current_app.thumbnail_path,
                                                "%s_400x400_85%s" % (photo_id, extention))
            small_thumbnail_path = os.path.join(current_app.thumbnail_path,
                                                "%s_200x200_85%s" % (photo_id, extention))
            photo = Photo(id=new_filename,
                          path=photo_path,
                          large_thumbnail_path=large_thumbnail_path,
                          small_thumbnail_path=small_thumbnail_path,
                          description=form.data['description']
                          )
            photo.people = []
            for person_id in form.data['people']:
                relative = Person.query.filter_by(id=person_id).first()
                photo.people.append(relative)
            form.data['photo'].save(photo_path)
            current_user.photos_uploaded += 1
            db.session.add(photo)
            db.session.add(current_user)
            db.session.commit()
            return redirect(url_for('main.mypage', person_id=person.id))
        else:
            return render_template('errors/upgrade_plan.html', reason=reason), 403

    return render_template('photo_upload.html', form=form, person=person)


@main.route('/myrelative/<my_id>/<target_id>', methods=['POST', 'GET'])
@login_required
def possible_relative(my_id, target_id):
    target = Person.query.get(target_id)
    me = Person.query.get(my_id)
    form = MyrelativeForm()
    form.relation.choices = populate_relations(target)
    header = "Tell us, who is this person for you"
    if form.validate_on_submit():
        relation = relation_dict(form.data["relation"])
        possible = PossibleRelative(
            id=uuid.uuid1().hex,
            person_id=my_id,
            target_id=target_id,
            relation=relation
        )
        db.session.add(possible)

        for family in target.families:
            family.possible_members.append(possible)
            db.session.add(family)
        db.session.commit()
        if target.sex == "male":
            flash_message = "%s and his family will be notified that you \
            consider him your %s. They need to confirm it. Be patient :)" % \
            (target.name, relation)
        else:
            flash_message = "%s and her family will be notified that you \
            consider her your %s. They need to confirm it. Be patient :)" % \
            (target.name, relation)
        # TODO: implement a javascript-base notification of the user with the flash_message
        return redirect(url_for('main.index', person=me))
    return render_template('myrelative.html', header=header, form=form,
                           person=target)

@main.route('/myrelatives/<family_id>', methods=['GET'])
@login_required
def possible_relatives(family_id):
    family = Family.query.filter_by(id=family_id).first()
    possibles = []
    for possible_relative in family.possible_members:
        result = {
            "dude": Person.query.filter_by(id=possible_relative.person_id).first(),
            "target": Person.query.filter_by(id=possible_relative.target_id).first(),
            "relation": possible_relative.relation,
            "possible_relative_id": possible_relative.id
            }
        possibles.append(result)
    return render_template("possible_relatives.html", possibles=possibles)

@main.route('/myrelative/confirm/<family_id>/<possible_member_id>', methods=['GET'])
@login_required
def confirm_relation(family_id, possible_member_id):
    family = Family.query.filter_by(id=family_id).first()
    possible = PossibleRelative.query.filter_by(id=possible_member_id).first()
    person = Person.query.filter_by(id=possible.person_id).first()
    target = Person.query.filter_by(id=possible.target_id).first()
    family.members.append(person)
    target.families.append(person.families[0])
#    person.families[0].members.append(target)
    if possible.relation == "spouse":
        target.spouses.append(person)

    elif possible.relation == "father":
        person.father_id = target.id
    elif possible.relation == "mother":
        person.mother_id = target.id
    elif possible.relation in ['son', 'daughter']:
        if person.sex == 'male':
            target.father_id = person.id
        else:
            target.mother_id = person.id
    db.session.add(family)
    db.session.add(person)
    db.session.add(target)
    db.session.add(person.families[0])
    db.session.delete(possible)
    db.session.commit()
    return redirect(url_for('main.index', person=person))


@main.route('/myrelative/discard/<possible_relative_id>')
@login_required
def discard_possible_relative(possible_relative_id):
    possible = PossibleRelative.query.filter_by(id=possible_relative_id).first()
    person = Person.query.filter_by(id=possible.person_id).first()
    db.session.delete(possible)
    db.session.commit()
    return redirect(url_for('main.index', person=person))

@main.route('/legend/display/<legend_id>')
#@cache.cached(timeout=50)
@login_required
def legend_display(legend_id):
    legend = Legend.query.filter_by(id=legend_id).first()
    return render_template('legend_display.html', legend=legend)
