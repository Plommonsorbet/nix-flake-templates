from app import srv
from app import reply

@srv.route('/hello')
def hello():
    return reply.say_hello()
