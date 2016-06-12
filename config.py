import os

class Config(object):
    SQLALCHEMY_DATABASE_URI = os.environ['DATABASE_URL']
    DEBUG = False
    TESTING = False
    CSRF_ENABLED = True
    SERVER_NAME = 'familyalbum.biz'
    SECRET_KEY = os.environ['FAMILYALBUM_SECRET_KEY']
    MEDIA_FOLDER = os.environ['MEDIA_FOLDER']
    MEDIA_THUMBNAIL_FOLDER = os.environ['MEDIA_THUMBNAIL_FOLDER']
    MEDIA_URL = ''
    MEDIA_THUMBNAIL_URL = '/cache/'
    SESSION_PROTECTION = 'basic'
    ALLOWED_EXTENSIONS = set(['png', 'jpg', 'jpeg', 'gif', 'tiff'])
    CACHE_DEFAULT_TIMEOUT = 100
    CACHE_MEMCACHED_SERVERS = ['localhost']
    FREE_USERS_FILE_LIMIT = 30
    GOLD_USERS_FILE_LIMIT = 100
    MAX_PHOTO_PIXELS = 1440
    MAIL_SERVER = 'smtp.googlemail.com'
    MAIL_PORT = 587
    MAIL_USE_TLS = True
    MAIL_USERNAME = os.environ['MAIL_USERNAME']
    MAIL_PASSWORD = os.environ['MAIL_PASSWORD']
    MAIL_SUBJECT_PREFIX = 'Familyalbum'
    MAIL_SENDER = "Familyalbum team <%s>" % MAIL_USERNAME

#     UPLOADED_FILES_DEST = os.environ['MEDIA_FOLDER']
#     UPLOADS_DEFAULT_DEST = os.environ['MEDIA_FOLDER']

class ProductionConfig(Config):
    DEBUG = False
    ONDELETE='RESTRICT'


class StagingConfig(Config):
    DEVELOPMENT = True
    DEBUG = True
    ONDELETE='RESTRICT'

class DevelopmentConfig(Config):
    DEVELOPMENT = True
    DEBUG = True
    ONDELETE='CASCADE'


class TestingConfig(Config):
    TESTING = True
    ONDELETE='CASCADE'
