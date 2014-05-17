#!/usr/bin/env python
from __future__ import print_function

import os
import shutil
import config

for fname in config.DOTFILES:
    src = os.path.expanduser('~/'+fname)
    dst = os.path.join(config.ROOT_DIR, 'dotfiles', fname)
    print("Copying", fname, "to dotfiles")
    shutil.copy(src, dst)
