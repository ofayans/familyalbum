import os

class Config(object):
    SQLALCHEMY_DATABASE_URI = os.environ['DATABASE_URL']
    DEBUG = False
    TESTING = False
    CSRF_ENABLED = True
    SECRET_KEY = os.environ['FAMILYALBUM_SECRET_KEY']
    MEDIA_FOLDER = os.environ['MEDIA_FOLDER']
    MEDIA_THUMBNAIL_FOLDER = os.environ['MEDIA_THUMBNAIL_FOLDER']
    MEDIA_URL = ''
    MEDIA_THUMBNAIL_URL = '/cache/'

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
