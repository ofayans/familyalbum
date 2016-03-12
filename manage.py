#!/usr/bin/env python3
from flask.ext.script import Manager
from flask.ext.migrate import Migrate, MigrateCommand
import os
from flask.ext.script import Shell
from app import create_app, country_choices
from app.models import Country
from app import db
import flask_countries


app = create_app(os.getenv('FLASK_CONFIG') or 'DevelopmentConfig')

migrate = Migrate(app, db)
manager = Manager(app)

manager.add_command('db', MigrateCommand)

@manager.command
def seed():
    import uuid
    country_names = [j for i, j in flask_countries.COUNTRIES_PLUS]
    for i in sorted(country_names):
        country = Country(
            id = uuid.uuid1().hex,
            name = i
        )
        db.session.add(country)
    db.session.commit()

# Shell integration

def make_shell_context():
    return dict(app=app, db=db)

manager.add_command("shell", Shell(make_context=make_shell_context))

if __name__ == '__main__':
    manager.run()
