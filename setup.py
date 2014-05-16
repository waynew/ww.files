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
print("Dotfiles dir: {}".format(ROOT_DIR))
