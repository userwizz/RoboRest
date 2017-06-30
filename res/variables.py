"""

A simple variable file just to check how to add Python stuff to variables

"""


import string
import random

def get_random_string (lenght=6):
    chars = string.ascii_uppercase + string.ascii_lowercase + string.digits
    random_string = ''.join(random.choice(chars) for i in range(lenght))
    return {"value" : random_string}


## for github
BASE_URL_GITHUB = "https://api.github.com/users"
ALIAS = BASE_URL_GITHUB
VERIFY_SSL = True
VALID_USER = "userwizz"
INVALID_USER = get_random_string(10)
DATA_TYPE = "application/json"

## for openweather
BASE_URL_OPENWEATHER = "http://api.openweathermap.org/data/2.5/weather"
APPID = "add_your_own_id_here"

