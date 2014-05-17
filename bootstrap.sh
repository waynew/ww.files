#!/usr/bin/sh

cleanup () {
    echo "\nRemoving ww.files"
    rm -rf ~/programming/ww.files

    echo "See ~/ww.files.log for more info"
}

# Wait for wget command to finish
sleep 0.1

echo "Setting up dotfiles directory"
if [ -d ~/programming/ww.files ]; then
    echo "~/programming/ww.files already exists, nothing to do"
    exit 0
fi
mkdir -p ~/programming/ww.files
wget https://github.com/waynew/ww.files/archive/master.tar.gz
tar -xf master.tar.gz -C ~/programming/ww.files >> ~/ww.files.log 2>&1
rm master.tar.gz
mv ~/programming/ww.files/ww.files-master/* ~/programming/ww.files/
rm -rf ~/programming/ww.files/ww.files-master
chmod +x ~/programming/ww.files/setup.py
chmod +x ~/programming/ww.files/publish.py

echo "Ensuring ~/.bin exists"
mkdir -p ~/.bin

echo "Installing vim pathogen"
mkdir -p ~/.vim/autoload ~/.vim/bundle; \
curl -LSso ~/.vim/autoload/pathogen.vim \
    https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim

echo "\nChecking for Python"
python --version > /dev/null 2>&1
has_python=$?

if [ $has_python -eq 0 ]; then 
    echo "\nWe gots Python!"
    echo "Run cd ~/programming/ww.files/setup.py"
else
    echo "\nNope - no python :( Can't automagically setup."
fi

#cleanup
