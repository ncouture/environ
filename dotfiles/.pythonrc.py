#!/usr/bin/python

import sys
import os
import atexit

try:
    import readline
except ImportError:
    print ("Module readline not available.")
else:
    import rlcompleter
    readline.parse_and_bind("tab: complete")

histfile = os.path.join(os.environ["HOME"], ".python_history")
try:
    readline.read_history_file(histfile)
except IOError:
    pass

try:
    from lxml.html.clean import Cleaner
    import lxml
    from lxml.html import document_fromstring
    import requests
    resp = requests.get('http://en.wikipedia.org/')
    tree = document_fromstring(resp.text)
    raw = resp.text
    # enable filters to remove Javascript and CSS from HTML document                                                                     
    cleaner = Cleaner()
    cleaner.javascript = True
    cleaner.style = True
    cleaner.html = True
    cleaner.page_structure = False
    cleaner.meta = False
    cleaner.safe_attrs_only = False
    cleaner.links = False

    html = cleaner.clean_html(tree)
    text_content = html.text_content()
except ImportError:
    pass

atexit.register(readline.write_history_file, histfile)
del os, histfile
