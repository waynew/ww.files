#!/usr/bin/env python
from __future__ import print_function

import os
import subprocess
import config
import shutil


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


for fname in config.DOTFILES:
    src = os.path.join(config.ROOT_DIR, 'dotfiles', fname)
    dst = os.path.expanduser('~/'+fname)
    backup(dst)
    shutil.copy(src, dst)



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
