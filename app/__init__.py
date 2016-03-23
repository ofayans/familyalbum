from flask import Flask, render_template, current_app, jsonify, request
from flask.ext.bootstrap import Bootstrap
from flask.ext.mail import Mail
from flask.ext.moment import Moment
from flask.ext.sqlalchemy import SQLAlchemy
from flask.ext.login import LoginManager
from flask.ext.pagedown import PageDown
from config import ProductionConfig, DevelopmentConfig
from config import StagingConfig, TestingConfig
from flask.ext.thumbnails import Thumbnail
from .middleware import HTTPMethodOverrideMiddleware
from flask.views import MethodView
from flask_wtf.csrf import CsrfProtect
# from flask_uploads import UploadSet, configure_uploads, patch_request_class

bootstrap = Bootstrap()
mail = Mail()
moment = Moment()
db = SQLAlchemy()
pagedown = PageDown()

login_manager = LoginManager()
login_manager.session_protection = 'strong'
login_manager.login_view = 'auth.login'

country_choices = [('', 'Please, select a country')]
sex_choices = [('', ''), ('1', 'male'), ('2', 'female')]


class MyView(MethodView):

    def get(self):
        return jsonify({'method': 'GET'})

    def post(self):
        method = request.form.get('_method', 'POST')
        if 'edit' in request.path:
            return jsonify({'method': 'PATCH'})
        elif method == 'POST':
            return jsonify({'method': method})
        else:
            if hasattr(self, method.lower()):
                return getattr(self, method.lower())()
            else:
                return jsonify({'method': 'UNKNOWN'})

    def put(self):
        return jsonify({'method': 'PUT'})

    def delete(self):
        return jsonify({'method': 'DELETE'})

    def create(self):
        # NOT A HTTP VERB
        return jsonify({'method': 'CREATE'})

def create_app(config_name):
    global country_choices
    app = Flask(__name__)
    app.config.from_object(eval(config_name))
    csrf = CsrfProtect()
    csrf.init_app(app)
#    app.wsgi_app = HTTPMethodOverrideMiddleware(app.wsgi_app)
    bootstrap.init_app(app)
    mail.init_app(app)
    moment.init_app(app)
    db.init_app(app)
    login_manager.init_app(app)
    login_manager.session_protection = 'basic'
    pagedown.init_app(app)
    thumb = Thumbnail(app)
#     photos = UploadSet()
#     media = UploadSet('media', default_dest=lambda app:
#                       app.config['MEDIA_FOLDER'])
#     configure_uploads(app, (photos, media))
#     # Limit the upload size. To change this refer to 
#     # https://pythonhosted.org/Flask-Uploads/
#     patch_request_class(app)

    if not app.debug and not app.testing and not app.config['SSL_DISABLE']:
        from flask.ext.sslify import SSLify
        sslify = SSLify(app)

    from .main import main as main_blueprint
    app.register_blueprint(main_blueprint)

    from .auth import auth as auth_blueprint
    app.register_blueprint(auth_blueprint, url_prefix='/auth')

    with app.app_context():
        from .models import Country
        all_countries = Country.query.all()
        for country in all_countries:
            country_choices.append((country.id, country.name))


#    from .api_1_0 import api as api_1_0_blueprint
#     app.register_blueprint(api_1_0_blueprint, url_prefix='/api/v1.0')
#     from .models import Country
    return app
