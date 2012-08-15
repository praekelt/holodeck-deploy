from holodeck.conf.defaults import *

DEBUG = False

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': 'holodeck',
        'USER': 'holodeck',
        'PASSWORD': 'holodeck',
        'HOST': 'localhost',
        'PORT': '5432',
    }
}

TIME_ZONE = 'Africa/Johannesburg'

SITE_URL = 'http://holodeck.praekelt.com'
