from __future__ import print_function

import os
import subprocess


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
print("Setting up Wayne's World!")
ROOT_DIR = os.path.dirname(os.path.abspath(__file__))
DOTFILES = ['.vimrc',
            ]


def revert():
    for fname in DOTFILES:
        os.unlink(os.path.expanduser('~/'+fname))


def linkup(src, dst):
    '''Create a symlink to src at dst. If dst already exists,
    back it up first.'''
    if os.path.isfile(dst):
        os.rename(dst, dst+'.bak')
    os.symlink(src, dst)


if os.name == 'posix':
    print("Looks like a unix!")
    for fname in DOTFILES:
        linkup(os.path.join(ROOT_DIR, 'dotfiles', fname),
               os.path.expandusr('~/'+fname))
