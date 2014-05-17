import os
import base64

try:
    input = raw_input
except NameError:
    pass

GIT_REPO = "https://api.github.com/repos/waynew/ww.files/contents/"
GITHUB_USERNAME = "waynew"
DOTFILES = ['.vimrc',
            '.zshrc',
            '.zshenv',
            ]

ROOT_DIR = os.path.dirname(os.path.abspath(__file__))
HASHY_PATH = os.path.join(ROOT_DIR, 'hashy.list')

if os.path.isfile:
    with open(os.path.join(ROOT_DIR, 'apikey')) as f:
        APIKEY = f.read().strip()
else:
    print("Go to https://github.com/settings/applications and generate a new api key")
    apikey = input("Key: ")
    with open(os.path.join(ROOT_DIR, 'apikey'), 'w') as f:
        f.write(apikey)
    APIKEY = apikey


AUTH = base64.b64encode(":".join([GITHUB_USERNAME, APIKEY]))
