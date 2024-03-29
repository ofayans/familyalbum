from flask import Flask
from werkzeug.wrappers import Request


class HTTPMethodOverrideMiddleware(object):
    def __init__(self, app):
        self.app = app

    def __call__(self, environ, start_response):
        if environ['REQUEST_METHOD'] == 'POST' and 'edit' in environ['PATH_INFO']:
            environ['REQUEST_METHOD'] == 'PATCH'
        return self.app(environ, start_response)
