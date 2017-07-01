"""

Simple Python class to check how to import own library

"""
import subprocess
import os

class Pinger (object):

    def __init__(self):
        self.host = ''

    def ping_host (self, host):
        self.host = host
        FNULL = open(os.devnull, 'w')
        response = subprocess.call(["ping", "-c1","-W2", host],stdout=FNULL)
        return True if response  == 0 else False
    
    def verify_response (self, response):
        if response is not True:
            raise AssertionError('Host "%s" is not responding to ping!' % (self.host))

