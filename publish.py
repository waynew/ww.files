#!/usr/bin/env python
from __future__ import print_function

import os
import json
import base64
import shutil
import config
import urllib
import urllib2

for fname in config.DOTFILES:
    src = os.path.expanduser('~/'+fname)
    dst = os.path.join(config.ROOT_DIR, 'dotfiles', fname)
    print("Copying", fname, "to dotfiles")
    shutil.copy(src, dst)


with open('apikey') as f:
    apikey = f.read().strip()



#req = urllib2.Request("https://api.github.com/repos/waynew/api-fire", data={'path': 'README.md',
#                                                                            'message': "Commit - from )
req = urllib2.Request("https://api.github.com/repos/waynew/api-fire/contents/README.md")
#req = urllib2.Request("https://api.github.com/repos/waynew/ww.files/contents/")
#req = urllib2.Request("https://api.github.com/repos/waynew/api-fire/git/trees/?recursive=1")
auth = base64.b64encode('waynew:'+apikey)
req.add_header("Authorization", "Basic "+auth)
req.add_header("Content-Type", "application/json")
req.get_method = lambda: 'PUT'
try:
    result = urllib2.urlopen(req, json.dumps({'path': "README.md",
                             'message': "Commmitting with urllib2 -hardcore!",
                             'content': base64.b64encode('# With FIRE!!!!\n\nBut not really'),
                             }))
    import pprint
    data = json.load(result)
    pprint.pprint(data)
    #for d in data:
    #    print(d.get('type'))
    #    print(d.get('name'))
    #    print()
except urllib2.HTTPError as e:
    print(e.code)
    print(e.headers)

#sudo -n true > /dev/null 2>&1
#has_root=$?
#if [ $has_root -eq 0 ]; then 
#    echo "HEy, root!"
#else
#    echo "nope, no root"
#fi
#
## TODO: Actually exit here
##exit 0
