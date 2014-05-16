#!/usr/bin/sh

# Wait for wget command to finish
sleep 0.1

echo "Setting up dotfiles directory"
mkdir -p ~/programming/ww.files
wget https://github.com/waynew/ww.files/archive/master.tar.gz
tar -xf master.tar.gz -C ~/programming/ww.files
mv ~/programming/ww.files/ww.files-master/* ~/programming/ww.files/
rm -rf ~/programming/ww.files/ww.files-master

ls -lah ~/programming/ww.files

sudo -n true > /dev/null 2>&1
has_root=$?
if [ $has_root -eq 0 ]; then 
    echo "HEy, root!"
else
    echo "nope, no root"
fi


# TODO: Actually exit here
#exit 0
echo "Removing ww.files"
rm -rf ~/programming/ww.files
