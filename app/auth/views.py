from flask import render_template, redirect, request, url_for, flash, abort
from flask.ext.login import login_user, logout_user, login_required, \
    current_user
from . import auth
from .. import db
from ..models import User, Person
from ..email import send_email
from .forms import LoginForm, RegistrationForm, ChangePasswordForm,\
    PasswordResetRequestForm, PasswordResetForm, ChangeEmailForm
import uuid
from sqlalchemy import and_
from flask import g, _request_ctx_stack


def next_is_valid(url):
    # A placeholder for a function that will validate "next" parameter of the
    # request. see https://flask-login.readthedocs.org/en/latest/#login-example
    return True


@auth.before_app_request
def before_request():
    if current_user.is_authenticated:
        current_user.ping()
        if not current_user.confirmed \
                and request.endpoint[:5] != 'auth.' \
                and request.endpoint != 'static':
            return redirect(url_for('auth.unconfirmed'))


@auth.route('/unconfirmed')
def unconfirmed():
    if current_user.is_anonymous:
        return redirect(url_for('main.index'))
    elif current_user.confirmed:
        person = Person.query.get(current_user.person_id)
        return redirect(url_for('main.index', person=person))
    return render_template('auth/unconfirmed.html')


@auth.route('/login', methods=['GET', 'POST'])
def login():
    form = LoginForm()
    if form.validate_on_submit():
        user = User.query.filter_by(email=form.email.data).first()
        nextpage = request.args.get('next')
        if not next_is_valid(nextpage):
            return abort(400)
        if user is not None and user.verify_password(form.password.data):
            login_user(user, form.remember_me.data)
            if user.is_new or not user.person_id:
                supposed_persons = Person.query.filter(
                    and_(Person.name == user.name,
                         Person.surname == user.surname,
                         Person.b_date == user.b_date))
                if supposed_persons.count() > 0:
                    return redirect(url_for("main.youmightbe", user_id=user.id))
                else:
                    return redirect(url_for('main.newperson'))

            else:
                person = Person.query.get(current_user.person_id)
                return redirect(request.args.get('next') or url_for('main.index', person=person))
        flash('Invalid username or password.')
    return render_template('auth/login.html', form=form)


@auth.route('/logout')
@login_required
def logout():
    logout_user()
    flash('You have been logged out.')
    return redirect(url_for('main.index'))


@auth.route('/register', methods=['GET', 'POST'])
def register():
    form = RegistrationForm()
    if form.validate_on_submit():
        user = User(id=uuid.uuid1().hex,
                    email=form.email.data,
                    password=form.password.data,
                    name=form.name.data,
                    surname=form.surname.data,
                    b_date=form.b_date.data,
                    )
        db.session.add(user)
        db.session.commit()
        token = user.generate_confirmation_token()
        send_email(user.email, 'Confirm Your Account',
                   'auth/email/confirm', user=user, token=token)
        flash('A confirmation email has been sent to you by email.')
        return redirect(url_for('auth.login'))
    return render_template('auth/register.html', form=form)


@auth.route('/confirm/<token>')
def confirm(token):
    unconfirmed_users = User.query.filter_by(confirmed=False).all()
    for user in unconfirmed_users:
        if user.confirm(token):
            user.confirmed = True
            flash('You have confirmed your account. Thanks!')
            db.session.add(user)
            db.session.commit()
            return redirect(url_for('main.index'))
    else:
        flash('The confirmation link is invalid or has expired.')
    return redirect(url_for('main.index'))


@auth.route('/confirm')
@login_required
def resend_confirmation():
    token = current_user.generate_confirmation_token()
    send_email(current_user.email, 'Confirm Your Account',
               'auth/email/confirm', user=current_user, token=token)
    flash('A new confirmation email has been sent to you by email.')
    return redirect(url_for('main.index'))


@auth.route('/change-password', methods=['GET', 'POST'])
@login_required
def change_password():
    form = ChangePasswordForm()
    if form.validate_on_submit():
        if current_user.verify_password(form.old_password.data):
            current_user.password = form.password.data
            db.session.add(current_user)
            person = Person.query.get(current_user.person_id)
            flash('Your password has been updated.')
            return redirect(url_for('main.index'))
        else:
            flash('Invalid password.')
    return render_template("auth/change_password.html", form=form)


@auth.route('/reset', methods=['GET', 'POST'])
def password_reset_request():
    if not current_user.is_anonymous:
        person = Person.query.get(current_user.person_id)
        return redirect(url_for('main.index', person=person))
    form = PasswordResetRequestForm()
    if form.validate_on_submit():
        user = User.query.filter_by(email=form.email.data).first()
        if user:
            token = user.generate_reset_token()
            send_email(user.email, 'Reset Your Password',
                       'auth/email/reset_password',
                       user=user, token=token,
                       next=request.args.get('next'))
        flash('An email with instructions to reset your password has been '
              'sent to you.')
        return redirect(url_for('auth.login'))
    return render_template('auth/reset_password.html', form=form)


@auth.route('/reset/<token>', methods=['GET', 'POST'])
def password_reset(token):
    if current_user.person_id:
        person = Person.query.get(current_user.person_id)
    if not current_user.is_anonymous:
        return redirect(url_for('main.index', person=person))
    form = PasswordResetForm()
    if form.validate_on_submit():
        user = User.query.filter_by(email=form.email.data).first()
        if user is None:
            return redirect(url_for('main.index'))
        if user.reset_password(token, form.password.data):
            flash('Your password has been updated.')
            return redirect(url_for('auth.login'))
        else:
            return redirect(url_for('main.index', person=person))
    return render_template('auth/reset_password.html', form=form)


@auth.route('/change-email', methods=['GET', 'POST'])
@login_required
def change_email_request():
    form = ChangeEmailForm()
    if form.validate_on_submit():
        if current_user.verify_password(form.password.data):
            person = Person.query.get(current_user.person_id)
            new_email = form.email.data
            token = current_user.generate_email_change_token(new_email)
            send_email(new_email, 'Confirm your email address',
                       'auth/email/change_email',
                       user=current_user, token=token)
            flash('An email with instructions to confirm your new email '
                  'address has been sent to you.')
            return redirect(url_for('main.index', person=person))
        else:
            flash('Invalid email or password.')
    return render_template("auth/change_email.html", form=form)


@auth.route('/change-email/<token>')
@login_required
def change_email(token):
    if current_user.change_email(token):
        person = Person.query.get(current_user.person_id)
        flash('Your email address has been updated.')
    else:
        flash('Invalid request.')
    return redirect(url_for('main.index', person=person))
