from holodeck.conf.defaults import *

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

PUBLIC = False
