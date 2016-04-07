from flask import g
from flask import current_app
import os
import uuid
from ..models import Legend, Photo, Person, User, Family, Country
from .. import db
from flask import url_for


def make_person(form, user, request, person=None):
    ava = None
    countries = set()
    if form.data['avatar']:
        ava_id = uuid.uuid1().hex
        extention = "." + form.data['avatar'].filename.split('.')[-1]
        new_filename = ava_id + extention
        ava_path = os.path.join(current_app.base_path, new_filename)
        large_thumbnail_path = os.path.join(current_app.thumbnail_path,
                                            "%s_400x400_85%s" % (ava_id, extention))
        small_thumbnail_path = os.path.join(current_app.thumbnail_path,
                                            "%s_200x200_85%s" % (ava_id, extention))

        form.data['avatar'].save(ava_path)
        ava = Photo(id=new_filename,
                    path=ava_path,
                    large_thumbnail_path=large_thumbnail_path,
                    small_thumbnail_path=small_thumbnail_path)
        db.session.add(ava)
    if user.is_new:
        person = Person(
            id=uuid.uuid1().hex,
            surname=user.surname,
            name=user.name,
            second_name=user.second_name,
            sex=user.sex,
            b_date=user.b_date,
#            city = form.data['city'],
            )

    else:
        person = person or Person(
            id=uuid.uuid1().hex)
        person.surname = form.data['surname']
        if form.data['maiden_surname']:
            person.maiden_surname=form.data['maiden_surname']
        person.name=form.data['name']
        person.second_name=form.data['second_name']
        person.sex=dict(form.sex.choices)[form.data['sex']]
        person.b_date=form.data['b_date']
#            city=form.data['city']
        if form.data['mother']:
            person.mother_id = form.data['mother']
        if form.data['father']:
            person.father_id = form.data['father']
        person.families.append(g.families[0])
    for country_id in form.data['country']:
        country = Country.query.filter_by(id=country_id).first()
        countries.add(country)
    person.countries = list(countries)
    if 'alive' not in form.data.keys():
        person.alive = True
    else:
        person.alive = form.data['alive']
        person.d_date = form.data['d_date']
    if ava:
        person.ava_id = ava.id
        ava.people.append(person)
        db.session.add(ava)
    if 'children' in form.data.keys() and form.data['children']:
        for child_id in form.data['children']:
            child = Person.query.filter_by(id=child_id).first()
            if person.sex == 'male':
                child.father_id = person.id
            else:
                child.mother_id = person.id
            db.session.add(child)
    if 'spouse' in form.data.keys() and form.data['spouse']:
        spouse = Person.query.filter_by(id=form.data['spouse']).first()
        person.spouses.append(spouse)
        spouse.spouses.append(person)
        db.session.add(spouse)
    # Now let's save person
    db.session.add(person)
    db.session.commit()

    return person


def populate_relatives(person=None):
    relatives = []
    for dude in g.families[0].members:
        if person and dude.id == person.id:
            continue
        relatives.append((dude.id, dude.fullname()))
    return relatives


def populate_dropdowns(form, person=None):
    relatives = populate_relatives(person)
    mother_choices = [('', 'Please select his/her mother if we already have her')]
    father_choices = [('', 'Please select his/her father if we already have him')]
    spouse_choices = [('', 'Please select his/her spouse if we already have him')]
    children_choices = [('', 'Please select his/her children')]
    mother_choices += relatives
    father_choices += relatives
    children_choices += relatives
    spouse_choices += relatives
    form.mother.choices = mother_choices
    form.father.choices = father_choices
    form.spouse.choices = spouse_choices
    form.children.choices = children_choices
#     if person:
#          # Description
#          form.description.data = person.description
#          # Name
#          form.name.data = person.name
#          # Second_name
#          form.second_name.data = person.second_name
#          # Surname
#          form.surname.data = person.surname
#          # sex
#          for key, value in form.sex.choices:
#              if value == person.sex:
#                  form.sex.data = key
#          # Country
#          country_ids = []
#          for country in person.countries:
#              country_ids.append(country.id)
#          form.country.data = country_ids
#          # Mother
#          form.mother.data = person.mother_id
#          # Father
#          form.father.data = person.father_id
#          # Spouse
#          if person.spouses:
#              form.spouse.data = person.spouses[-1].id
#          # Children
#          children_ids = []
#          if person.sex == 'male':
#              children = person.fathers_children
#          else:
#              children = person.mothers_children
#          for child in children:
#              children_ids.append(child.id)
#          form.children.data = children_ids
#          # Birthday
#          form.b_date.data = person.b_date
#          form.process()
    return form

def new_family(person):
    family = Family(id=uuid.uuid1().hex)
    family.relatives.append(person)
    family.creator_id = person.user[0].id
    db.session.add(family)
    db.session.commit()

descendants_chart = {'container': "#basic-example",
                     'connectors': {'type': 'step'},
                     'node': {'HTMLclass': 'nodeExample1'}}

ancestors_chart = {
        'container': "#basic-example",
        'rootOrientation': "SOUTH",
        'connectors': {'type': 'step'},
        'node': {'HTMLclass': 'nodeExample1'}
        }


def _descendants_tree(person_id, ancestor=False):
    person = Person.query.filter_by(id=person_id).first()
    result = {}
    result["children"] = []
#    result["text"] = person.fullname()
    result["text"] = {"fullname" : person.fullname(),
                      "years_of_life": person.years_of_life()}
    result["link"] = url_for('main.mypage', person_id=person_id)
    result["stackChildren"] = True
    if person.ava_id:
        photo = Photo.query.filter_by(id=person.ava_id).first()
        filename = photo.small_thumbnail_path.split('/')[-1]
        thumbnail_url = url_for("main.show_thumbnail",
                                 photo_id=filename)
        result["image"] = thumbnail_url
    if ancestor:
        if person.father_id:
            result["children"].append(_descendants_tree(person.father_id,
                                                        ancestor=True))
        if person.mother_id:
            result["children"].append(_descendants_tree(person.mother_id,
                                                        ancestor=True))
    else:
        if person.sex == "female":
            children = person.mothers_children
        else:
            children = person.fathers_children
        for child in children:
            result["children"].append(_descendants_tree(child.id))
    return result

def descendants_tree(person_id):
    return {"chart": descendants_chart, "nodeStructure":
            _descendants_tree(person_id)}

def ancestor_tree(person_id):
    return {"chart": ancestors_chart, "nodeStructure":
            _descendants_tree(person_id, ancestor=True)}


def allowed_file(filename):
    return '.' in filename and \
        filename.rsplit('.', 1)[1] in app.config['ALLOWED_EXTENSIONS']
