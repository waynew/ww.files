#!/usr/bin/env python
from __future__ import print_function

import os
import sys
import json
import subprocess
import config
import shutil
import hashlib


print("Setting up Wayne's World!")

def backup(fname, count=0):
    if fname[-1].isdigit():
        dst = fname.rsplit('.', 1)[0] + '.' + str(count)
    else:
        dst = fname+'.'+str(count)
    if os.path.isfile(fname):
        print("Backing up", fname, "to", dst)
        count += 1
        backup(dst, count)
        shutil.copy(fname, dst)


hashes = {}
for fname in config.DOTFILES:
    src = os.path.join(config.ROOT_DIR, 'dotfiles', fname)
    dst = os.path.expanduser('~/'+fname)
    if '--no-backup' not in sys.argv:
        backup(dst)
    shutil.copy(src, dst)

    sha = hashlib.sha1()
    with open(dst) as f:
        d = f.read()
        sha.update('blob %u\0' % len(d))
        sha.update(d)

    hashes[fname] = sha.hexdigest()
    
with open(config.HASHY_PATH, 'w') as f:
    json.dump(hashes, f)


print("All done!")

#ls -lah ~/programming/ww.files

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
