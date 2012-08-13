import os.path


ROOT = os.path.dirname(__file__)

DATABASES = {
    'default': {
        # You can swap out the engine for MySQL easily by changing this value
        # to ``django.db.backends.mysql`` or to PostgreSQL with
        # ``django.db.backends.postgresql_psycopg2``
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': 'holodeck',
        'USER': 'holdeck',
        'PASSWORD': 'holodeck',
        'HOST': 'localhost',
        'PORT': '5432',
    }
}

# Set this to false to require authentication
PUBLIC = False
