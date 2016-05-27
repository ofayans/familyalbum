from flask import g
from flask import current_app
import os
import uuid
from ..models import Legend, Photo, Person, User, Family, Country
from .. import db
from flask import url_for
from PIL import Image
from .constants import IMAGE_TOO_BIG, NUM_UPLOADS_EXCEEDED

def is_image_small(img):
    if max(img.size) > current_app.config['MAX_PHOTO_PIXELS']:
        ava_saved = False
        reason = IMAGE_TOO_BIG % current_app.config['MAX_PHOTO_PIXELS']
        return False, reason
    else:
        return True, ""


def make_person(form, user, request, person=None):
    ava = None
    ava_saved = None
    countries = set()
    tarif = g.user.tarif.upper()
    reason = ""
    maxfiles = current_app.config["%s_USERS_FILE_LIMIT" % tarif]
    if form.data['avatar']:
        if user.photos_uploaded < maxfiles:
            with Image.open(form.data['avatar']) as img:
                ava_saved, reason = is_image_small(img)
                if ava_saved:
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
        else:
            ava_saved = False
            reason = NUM_UPLOADS_EXCEEDED % current_app.config["%s_USERS_FILE_LIMIT" % tarif]
    if user.is_new:
        person = Person(
            id=uuid.uuid1().hex,
            surname=user.surname,
            name=user.name,
            b_date=user.b_date,
#            city = form.data['city'],
            sex = form.data['sex']
            )
        if form.data['second_name']:
            person.second_name = form.data['second_name']

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
    return {'person': person,
            'ava_saved': ava_saved,
            'reason': reason}


def populate_relatives(person=None, sex=None):
    relatives = []
    members = []
    for family in g.families:
        members.extend(family.members)
    for dude in set(members):
        if person and dude.id == person.id:
            continue
        if not sex:
            relatives.append((dude.id, dude.fullname()))
        else:
            if dude.sex == sex:
                relatives.append((dude.id, dude.fullname()))
    return relatives

def populate_relations(person=None):
    if person is None:
        raise TypeError("Person object was not provided")
    result = [("", "%s to you is a..." % person.name),
              ("0", "spouse"),
              ("5", "other relative")
             ]
    if person.sex == 'male':
        result.insert(2, ("1", "father"))
        result.insert(3, ("3", "son"))
    else:
        result.insert(2, ("2", "mother"))
        result.insert(3, ("4", "daughter"))
    return result

def relation_dict(number):
    dic = {"0": "spouse",
           "1": "father",
           "2": "mother",
           "3": "son",
           "4": "daughter",
           "5": "other relative"
          }
    return dic[number]

def populate_dropdowns(form, person=None):
    relatives = populate_relatives(person)
    girls = populate_relatives(person, sex='female')
    boys = populate_relatives(person, sex='male')
    mother_choices = [('', 'Please select his/her mother if we already have her')]
    father_choices = [('', 'Please select his/her father if we already have him')]
    spouse_choices = [('', 'Please select his/her spouse if we already have him')]
    children_choices = [('', 'Please select his/her children')]
    mother_choices += girls
    father_choices += boys
    children_choices += relatives
    spouse_choices += relatives
    form.mother.choices = mother_choices
    form.father.choices = father_choices
    form.spouse.choices = spouse_choices
    form.children.choices = children_choices
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
    result["text"] = {"name" : person.fullname(),
                      "contact": person.years_of_life()}
    result["link"] = {'href': url_for('main.mypage', person_id=person_id)}
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
        for child in person.children():
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
