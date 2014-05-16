#!/usr/bin/sh

cleanup () {
    echo "Removing ww.files"
    rm -rf ~/programming/ww.files
}

# Wait for wget command to finish
sleep 0.1

echo "Setting up dotfiles directory"
mkdir -p ~/programming/ww.files
wget https://github.com/waynew/ww.files/archive/master.tar.gz
tar -xf master.tar.gz -C ~/programming/ww.files
rm master.tar.gz
mv ~/programming/ww.files/ww.files-master/* ~/programming/ww.files/
rm -rf ~/programming/ww.files/ww.files-master

echo "Checking for Python"
python --version > /dev/null 2>&1
has_python=$?

if [ $has_python -eq 0 ]; then 
    echo "We gots Python!"
    python ~/programming/ww.files/setup.py
else
    echo "Nope - no python :( Can't automagically setup."
fi

cleanup
