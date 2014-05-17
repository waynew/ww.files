#!/usr/bin/env python
from __future__ import print_function

import os
import json
import hashlib
import base64
import shutil
import config
import urllib
import urllib2

try:
    input = raw_input
except NameError:
    pass

with open(config.HASHY_PATH) as f:
    hashes = json.load(f)

for fname in config.DOTFILES:
    src = os.path.expanduser('~/'+fname)
    dst = os.path.join(config.ROOT_DIR, 'dotfiles', fname)
    print("Copying", fname, "to dotfiles")
    shutil.copy(src, dst)

    sha = hashlib.sha1()
    with open(dst) as f:
        d = f.read()
        sha.update('blob %d\0' % len(d))
        sha.update(d)
        if hashes.get(fname) != sha.hexdigest():
            old_hash = hashes.get(fname)
            hashes[fname] = sha.hexdigest()
            f.seek(0)
            content = base64.b64encode(f.read())

            req = urllib2.Request("https://api.github.com/repos/waynew/api-fire/contents/"+fname)
            reason = input("Reason for updating " + fname + ": ").strip()
            data = {'path': fname,
                    'message': reason or ("Updating " + fname),
                    'content': content,
                    }
            if old_hash is not None:
                print("Hash is not none - adding", old_hash)
                data['sha'] = old_hash

            req.add_header("Authorization", "Basic "+config.AUTH)
            req.add_header("Content-Type", "application/json")
            req.get_method = lambda: 'PUT'
            try:
                result = urllib2.urlopen(req, json.dumps(data))
                import pprint
                data = json.load(result)
                c = data.get('content')
                if c:
                    print(c.get('sha'))
                    print(sha.hexdigest())
                c = data.get("commit")
                print(c.get('sha'))
                print(c.get('tree')['sha'])
                print(c['parents'][0]['sha'])
                #for d in data:
                #    print(d.get('type'))
                #    print(d.get('name'))
                #    print()
            except urllib2.HTTPError as e:
                print("Unable to update", fname, "- FAIL")
                print("Restoring hash")
                hashes[fname] = old_hash
                print("Error code:", e.code)

with open(config.HASHY_PATH, 'w') as f:
    json.dump(hashes, f)

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
