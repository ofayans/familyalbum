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
from flask.ext.login import login_required, current_user
from . import main
from .forms import PersonForm, AboutMeForm, LegendForm, PhotoForm
from .misc import populate_dropdowns, make_person, new_family
from .misc import populate_relatives, ancestor_tree, descendants_tree
from .misc import allowed_file
from .. import db
from ..models import Legend, Photo, Person, User, Family, Country
import uuid
from sqlalchemy import and_
import os
import json
import re
from werkzeug import secure_filename




@main.context_processor
def familize():
    def userfamilies(user):
        person = Person.query.filter_by(id=user.id).first()
        return person.families
    return dict(userfamilies=userfamilies)


@main.route('/person/delete/<person_id>')
@login_required
def person_delete(person_id):
    person = Person.query.filter_by(id=person_id).first()
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
    return redirect(url_for('main.index'))



@main.route('/person/display/<person_id>')
@login_required
def mypage(person_id):
    person = Person.query.filter_by(id=person_id).first()
    return render_template('person_show.html', person=person)


@main.route('/photos/<photo_id>')
@login_required
def show_photo(photo_id):
    photo = Photo.query.filter_by(id=photo_id).first()
    if os.path.exists(photo.path):
        folder = '/'.join(photo.path.split('/')[0: -1])
        filename = photo.path.split('/')[-1]
        return send_from_directory(folder, filename)
    else:
        return abort(404)


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
        return redirect(url_for('main.index'))


@main.route('/')
def index():
    return render_template('index.html')


@main.route('/ancestors/display/<person_id>')
@login_required
def ancestordisplay(person_id):
    return render_template('ancestor_show.html', person_id=person_id)


@main.route('/descendants/display/<person_id>')
@login_required
def descendantdisplay(person_id):
    return render_template('descendant_show.html', person_id=person_id)


@main.route('/treantexample')
def treantexample():
    return render_template('treant_example.html')


@main.route('/ancestortree/<person_id>.js')
@login_required
def ancestortree(person_id):
    result = json.dumps(ancestor_tree(person_id), ensure_ascii=False,
                        sort_keys=True)
    return "var chart_config = %s" % result




@main.route('/descendanttree/<person_id>.js')
@login_required
def descendanttree(person_id):
    result = json.dumps(descendants_tree(person_id), ensure_ascii=False,
                        indent=4, sort_keys=True)
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
    return redirect(url_for('main.index'))


@main.route('/thatsme/<person_id>')
@login_required
def thatsme(person_id):
    user_id = current_user.get_id()
    user = User.query.filter_by(id=user_id).first()
    person = Person.query.filter_by(id=person_id).first()
    person.user_id = user_id
    user.person_id = person_id
#    user.city = person.city
    user.is_new = False
    db.session.add(user)
    db.session.add(person)
    db.session.commit()
    return redirect(url_for('main.index'))


@main.route('/person/edit/<person_id>', methods=['GET', 'POST'])
@login_required
def edit_person(person_id):
    person = Person.query.filter_by(id=person_id).first()
    form = PersonForm(obj=person)
    form = populate_dropdowns(form, person)
    if form.validate_on_submit():
        make_person(form, current_user, request, person)
        return redirect(url_for('main.index'))
    return render_template('new_person.html', form=form)


@main.route('/legend/new', methods=['GET', 'POST'])
@login_required
def add_legend():
    form = LegendForm()
    person_choices = [('', 'Please select all people involved')]
    person_choices.extend(populate_relatives())
    form.people.choices = person_choices
    if form.validate_on_submit():
        legend = Legend(
            id=uuid.uuid1().hex,
            text=form.data['text']
            )
        for person_id in form.data['people']:
            person = Person.query.filter_by(id=person_id).first()
            legend.participants.append(person)
        db.session.add(legend)
        db.session.commit()
        return redirect(url_for('main.index'))
    else:
        return render_template('new_legend.html', form=form)


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
        person = make_person(form, user, request)

        if new_user:
            user.person_id = person.id
#            user.city = form.data['city']
            user.is_new = False
            user_country = Country.query.filter_by(id=user.country_id).first()
            person.countries = [user_country]
        # We need to first commit a person and then add a user,
        # otherwise sqlalchemy will scream that a person with the given id
        # does not exist
        db.session.add(user)
        db.session.commit()
        if new_user:
            return redirect(url_for('main.search_for_relatives',
                                    person_id=person.id))
        else:
            return redirect(url_for('main.index'))
    if new_user:
        return render_template('about_me.html', form=form, user=user)
    else:
        return render_template('new_person.html', form=form, user=user,
                               action=url_for('main.newperson'))

@main.route('/photos/upload/<person_id>', methods=['POST', 'GET'])
def photo_upload(person_id):
    person = Person.query.filter_by(id=person_id).first()
    form = PhotoForm()
    relative_choices = [('', 'Select all who present on this photo')]
    relative_choices.extend(populate_relatives())
    form.people.choices = relative_choices
    if form.validate_on_submit():
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
        db.session.add(photo)
        db.session.commit()
        form.data['photo'].save(photo_path)
        return redirect(url_for('main.mypage', person_id=person.id))

    return render_template('photo_upload.html', form=form, person=person)
