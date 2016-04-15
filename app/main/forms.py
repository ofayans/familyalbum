from flask.ext.wtf import Form
import wtforms
from wtforms.fields.html5 import DateField
from wtforms.validators import Required, Optional
from flask import current_app
from .. import country_choices, sex_choices

country_choices.pop(0)

class CKTextAreaWidget(wtforms.widgets.TextArea):
    def __call__(self, field, **kwargs):
#        kwargs.pop('class_', '')
#        kwargs['class'] = 'ckeditor'
        return super(CKTextAreaWidget, self).__call__(field, **kwargs)

class CKTextAreaField(wtforms.TextAreaField):
    widget = CKTextAreaWidget()

class GenericPersonForm(Form):
    avatar = wtforms.FileField('Avatar')
    city = wtforms.StringField('City', validators=[Optional()])
    description = wtforms.TextAreaField('Description')


class PersonForm(GenericPersonForm):
    name = wtforms.StringField('Name?', validators=[Required()])
    second_name = wtforms.StringField('Second name?')
    surname = wtforms.StringField('Surname?', validators=[Required()])
    maiden_surname = wtforms.StringField('Maiden surname (if applicable)',
                                         validators=[Optional()])

    sex = wtforms.SelectField('Sex',
                              choices=sex_choices,
                              validators=[Required()])
    country = wtforms.SelectMultipleField("Countries he/she lived in",
                                          choices=country_choices,
                                          validators=[Required()])
    mother = wtforms.SelectField('Mother',
                                 validators=[Optional()])
    father = wtforms.SelectField('Father',
                                 validators=[Optional()])
    spouse = wtforms.SelectField('Spouse',
                                 validators=[Optional()])
    children = wtforms.SelectMultipleField('Children',
                                           validators=[Optional()])
    b_date = DateField('Date of birth', validators=[Required()])
    alive = wtforms.BooleanField('Alive?', default='checked')
    d_date = DateField('Date of death', validators=[Optional()])
    submit = wtforms.SubmitField('Save')


class AboutMeForm(GenericPersonForm):
    country = wtforms.SelectMultipleField("Countries you lived in",
                                          choices=country_choices,
                                          validators=[Optional()])
    submit = wtforms.SubmitField('Save')


class LegendForm(Form):
    title = wtforms.StringField('Legend title', validators=[Required()])
    text = CKTextAreaField('Legend text', validators=[Required()])
    people = wtforms.SelectMultipleField('People involved',
                                         validators=[Required()])
    submit = wtforms.SubmitField('Save')

class PhotoForm(Form):
    photo = wtforms.FileField('Photo')
    description = wtforms.TextAreaField('Photo description',
                                        validators=[Optional()])
    people = wtforms.SelectMultipleField('Select people who present on this photo')
    submit = wtforms.SubmitField('Save')

class PersonSearchForm(Form):
    name = wtforms.StringField('First name', validators=[Optional()])
    second_name = wtforms.StringField('Second name',
                                      validators=[Optional()])
    surname = wtforms.StringField('Surname',
                                  validators=[Optional()])
    maiden_surname = wtforms.StringField('Maiden surname',
                                         validators=[Optional()])
    b_date = DateField('Date of birth', validators=[Optional()])
    submit = wtforms.SubmitField('Find')


class MyrelativeForm(Form):
    relation = wtforms.SelectField("Relation", validators=[Required()])
    submit = wtforms.SubmitField('Confirm')
