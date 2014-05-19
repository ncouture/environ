#!/usr/bin/python
#
# example:
# ./get_geo_location.py montreal, quebec, canada
# {'lat': 45.5086699, 'lng': -73.55399249999999}
#

import sys
import os
import urllib
import urllib2
import StringIO
import json


def decodeAddressToCoordinates(address):
    urlParams = {'address': address,
                 'sensor': 'false'}
    url = 'http://maps.google.com/maps/api/geocode/json?%s' % (
        urllib.urlencode(urlParams))
    response = urllib2.urlopen(url)
    responseBody = response.read()

    body = StringIO.StringIO(responseBody)
    result = json.load(body)
    if 'status' not in result or result['status'] != 'OK':
        return None
    else:
        return {'lat': result['results'][0]['geometry']['location']['lat'],
                'lng': result['results'][0]['geometry']['location']['lng']}

location = " ".join(sys.argv[1::])
if location:
    print decodeAddressToCoordinates(location)
else:
    print "Usage: %s <location>" % os.path.basename(sys.argv[0])
