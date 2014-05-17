import os
import base64

GIT_REPO = "https://api.github.com/repos/waynew/api-fire/contents/"
GITHUB_USERNAME = "waynew"
DOTFILES = ['.vimrc',
            ]

ROOT_DIR = os.path.dirname(os.path.abspath(__file__))
HASHY_PATH = os.path.join(ROOT_DIR, 'hashy.list')

with open('apikey') as f:
    APIKEY = f.read().strip()


AUTH = base64.b64encode(":".join([GITHUB_USERNAME, APIKEY]))
