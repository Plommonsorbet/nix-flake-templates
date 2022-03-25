__version__ = '0.1.0'

from flask import Flask

srv = Flask(__name__)

from app import reply, routes

def main():
    srv.run()
