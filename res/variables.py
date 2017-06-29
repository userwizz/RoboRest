"""

A simple variable file just to check how to add Python stuff to variables

"""


import string
import random


def get_random_string (lenght=6):
    chars = string.ascii_uppercase + string.ascii_lowercase + string.digits
    random_string = ''.join(random.choice(chars) for i in range(lenght))
    return {"value" : random_string}



HOST = "https://api.github.com/users"
VERIFY_SSL = True
ALIAS = HOST 
VALID_USER = "userwizz"
INVALID_USER = get_random_string(10)
DATA_TYPE = "application/json"