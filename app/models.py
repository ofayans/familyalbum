from flask.ext.login import UserMixin
from . import db, login_manager
from flask import current_app
from werkzeug.security import generate_password_hash, check_password_hash
from itsdangerous import TimedJSONWebSignatureSerializer as Serializer
from datetime import datetime
import app


class Country(db.Model):
    __tablename__ = 'country'
    id = db.Column(db.Unicode, primary_key=True, index=True)
    name = db.Column(db.Unicode)


user_messages = db.Table(
    'usermessages', db.metadata,
    db.Column('user_id', db.Unicode, db.ForeignKey('users.id')),
    db.Column('message_id', db.Unicode, db.ForeignKey('message.id')),

    )

legend_participants = db.Table(
    'legendparticipant', db.metadata,
    db.Column('person_id', db.Unicode, db.ForeignKey('person.id')),
    db.Column('legend_id', db.Unicode, db.ForeignKey('legend.id'))
    )

photo_participants = db.Table(
    'photoparticipant', db.metadata,
    db.Column('person_id', db.Unicode, db.ForeignKey('person.id')),
    db.Column('photo_id', db.Unicode, db.ForeignKey('photo.id'))
    )

spouses = db.Table(
    "spouses", db.metadata,
    db.Column("leftspouse_id", db.Unicode, db.ForeignKey('person.id',
                                                         ondelete='CASCADE')),
    db.Column("rightspouse_id", db.Unicode, db.ForeignKey('person.id',
                                                          ondelete='CASCADE'))
    )

family_members = db.Table(
    "family_members", db.metadata,
    db.Column("family_id", db.Unicode, db.ForeignKey('family.id')),
    db.Column("person_id", db.Unicode, db.ForeignKey('person.id'))
    )

family_possible_members = db.Table(
    "family_possible_members", db.metadata,
    db.Column("family_id", db.Unicode, db.ForeignKey('family.id')),
    db.Column("possible_member_id", db.Unicode, 
              db.ForeignKey('possiblerelative.id'))
    )

country_dvellers = db.Table(
    "country_dvellers", db.metadata,
    db.Column("country_id", db.Unicode,
              db.ForeignKey('country.id')),
    db.Column("person_id", db.Unicode, db.ForeignKey('person.id'))
    )

class PossibleRelative(db.Model):
    __tablename__ = 'possiblerelative'
    id = db.Column(db.Unicode, primary_key=True, index=True)
    person_id = db.Column(db.Unicode, db.ForeignKey('person.id'), nullable=False)
    target_id = db.Column(db.Unicode, db.ForeignKey('person.id'), nullable=False)
    relation = db.Column(db.Unicode)


# city_dvellers = db.Table(
#     "city_dvellers", db.metadata,
#     db.Column("city_id", db.Unicode, db.ForeignKey('city.id')),
#     db.Column("person_id", db.Unicode, db.ForeignKey('person.id'))
#     )


# class City(db.Model):
#     __tablename__ = 'city'
#     id = db.Column(db.Unicode, primary_key = True, index = True)
#     name = db.Column(db.Unicode)
#

class Person(db.Model):
    __tablename__ = 'person'
    id = db.Column(db.Unicode, primary_key=True, index=True)
    name = db.Column(db.Unicode)
    second_name = db.Column(db.Unicode)
    surname = db.Column(db.Unicode)
    maiden_surname = db.Column(db.Unicode)
    sex = db.Column(db.Unicode)
    description = db.Column(db.Unicode)
    alive = db.Column(db.Boolean)
    b_date = db.Column(db.Date)
    d_date = db.Column(db.Date, nullable=True)
    user = db.relationship('User', backref='user_person')
    ava_id = db.Column(db.Unicode, db.ForeignKey('photo.id'),
                       nullable=True,)
    father_id = db.Column(db.Unicode, db.ForeignKey('person.id'), nullable=True)
    mother_id = db.Column(db.Unicode, db.ForeignKey('person.id'), nullable=True)
    father = db.relationship('Person', remote_side=id, lazy='joined',
                             join_depth=3, foreign_keys=[father_id],
                             backref='fathers_children')
    mother = db.relationship('Person', remote_side=id, lazy='joined',
                             join_depth=3, foreign_keys=[mother_id],
                             backref='mothers_children')
    countries = db.relationship(
        "Country",
        secondary=country_dvellers,
        backref="country_inhabitants",
        cascade="all"
    )
#     cities = db.relationship(
#         "City",
#         secondary = city_dvellers,
#         backref = "city_inhabitants"
#     )
    legends = db.relationship(
        "Legend",
        secondary=legend_participants,
        backref="legend_participants",
        cascade="all"
    )
    photos = db.relationship(
        "Photo",
        secondary=photo_participants,
        backref="photo_participants",
        cascade="all"
    )

    families = db.relationship(
        "Family",
        secondary=family_members,
        backref="relatives",
        cascade="all"
    )
    spouses = db.relationship(
        "Person",
        secondary=spouses,
        foreign_keys=[
            spouses.c.leftspouse_id,
            spouses.c.rightspouse_id
            ],
        primaryjoin=spouses.c.leftspouse_id == id,
        secondaryjoin=spouses.c.rightspouse_id == id
    )

    def fullname(self):
        result = [self.name]
        if self.second_name:
            result.append(self.second_name)
        if self.maiden_surname:
            lastname = "%s(%s)" % (self.surname, self.maiden_surname)
        else:
            lastname = self.surname
        result.append(lastname)
        return " ".join(result)

    def children(self):
        if self.fathers_children:
            return self.fathers_children
        elif self.mothers_children:
            return self.mothers_children
        else:
            return []

    def years_of_life(self):
        if self.alive:
            return "%s-%s-%s" % (str(self.b_date.year),
                                 str(self.b_date.month),
                                 str(self.b_date.day))
        else:
            return "%s-%s-%s - %s-%s-%s" % (str(self.b_date.year),
                                            str(self.b_date.month),
                                            str(self.b_date.day),
                                            str(self.d_date.year),
                                            str(self.d_date.month),
                                            str(self.d_date.day))


class Message(db.Model):
    __tablename__ = 'message'
    id = db.Column(db.Unicode, primary_key=True, index=True)
    subject = db.Column(db.Unicode, nullable=True)
    text = db.Column(db.UnicodeText)
    acknowledged = db.Column(db.Boolean, default=False)
    sender = db.ForeignKey('users.id')
    recipients = db.relationship("User",
                                 secondary=user_messages,
                                 backref="message_recievers")


class Legend(db.Model):
    __tablename__ = 'legend'
    id = db.Column(db.Unicode, primary_key=True, index=True)
    text = db.Column(db.UnicodeText)
    participants = db.relationship("Person",
                                   secondary=legend_participants,
                                   backref="person_legends",
                                   cascade="all")


class Photo(db.Model):
    __tablename__ = 'photo'
    id = db.Column(db.Unicode, primary_key=True, index=True)
    description = db.Column(db.UnicodeText)
    people = db.relationship(
        "Person",
        secondary=photo_participants,
        backref="people_on_photo",
        cascade="all"
        )
    path = db.Column(db.Unicode)
    large_thumbnail_path = db.Column(db.Unicode)
    small_thumbnail_path = db.Column(db.Unicode)


class User(UserMixin, db.Model):
    __tablename__ = 'users'
    id = db.Column(db.Unicode, primary_key=True, index=True)
    email = db.Column(db.Unicode, index=True)
    password_hash = db.Column(db.String(128))
    name = db.Column(db.Unicode)
    second_name = db.Column(db.Unicode)
    surname = db.Column(db.Unicode)
    sex = db.Column(db.Unicode)
    country_id = db.Column(db.Unicode, db.ForeignKey('country.id'))
#    city_id = db.Column(db.Unicode, db.ForeignKey('city.id'))
    b_date = db.Column(db.Date)
    person_id = db.Column(db.Unicode, db.ForeignKey('person.id'))
    is_new = db.Column(db.Boolean, default=True)
    confirmed = db.Column(db.Boolean, default=False)

    @property
    def password(self):
        raise AttributeError('password is not a readable attribute')

    @password.setter
    def password(self, password):
        self.password_hash = generate_password_hash(password)

    def verify_password(self, password):
        return check_password_hash(self.password_hash, password)

    def generate_confirmation_token(self, expiration=3600):
        s = Serializer(current_app.config['SECRET_KEY'], expiration)
        return s.dumps({'confirm': self.id})

    def confirm(self, token):
        s = Serializer(current_app.config['SECRET_KEY'])
        try:
            data = s.loads(token)
        except:
            return False
        if data.get('confirm') != self.id:
            return False
        self.confirmed = True
        db.session.add(self)
        return True

    def generate_reset_token(self, expiration=3600):
        s = Serializer(current_app.config['SECRET_KEY'], expiration)
        return s.dumps({'reset': self.id})

    def reset_password(self, token, new_password):
        s = Serializer(current_app.config['SECRET_KEY'])
        try:
            data = s.loads(token)
        except:
            return False
        if data.get('reset') != self.id:
            return False
        self.password = new_password
        db.session.add(self)
        return True

    def generate_email_change_token(self, new_email, expiration=3600):
        s = Serializer(current_app.config['SECRET_KEY'], expiration)
        return s.dumps({'change_email': self.id, 'new_email': new_email})

    def change_email(self, token):
        s = Serializer(current_app.config['SECRET_KEY'])
        try:
            data = s.loads(token)
        except:
            return False
        if data.get('change_email') != self.id:
            return False
        new_email = data.get('new_email')
        if new_email is None:
            return False
        if self.query.filter_by(email=new_email).first() is not None:
            return False
        self.email = new_email
        self.avatar_hash = hashlib.md5(
            self.email.encode('utf-8')).hexdigest()
        db.session.add(self)
        return True

    def generate_auth_token(self, expiration):
        s = Serializer(current_app.config['SECRET_KEY'],
                       expires_in=expiration)
        return s.dumps({'id': self.id}).decode('ascii')

    @staticmethod
    def verify_auth_token(token):
        s = Serializer(current_app.config['SECRET_KEY'])
        try:
            data = s.loads(token)
        except:
            return None
        return User.query.get(data['id'])

    def ping(self):
        self.last_seen = datetime.utcnow()
        db.session.add(self)

    def __repr__(self):
        return '<User %s %s>' % (self.name, self.surname)


class Family(db.Model):
    __tablename__ = 'family'
    id = db.Column(db.Unicode, primary_key=True, index=True)
    creator_id = db.Column(db.Unicode, db.ForeignKey('users.id'), index=True)
# #    name = db.Column(db.Unicode, index = True)
    members = db.relationship(
        "Person",
        secondary=family_members,
        backref='clans'
    )
    possible_members = db.relationship(
        "PossibleRelative",
        secondary=family_possible_members,
        backref='possible_clans'
    )


@login_manager.user_loader
def load_user(user_id):
    return User.query.get(user_id)
