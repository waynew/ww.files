#!/usr/bin/sh

sleep 0.1
echo "Cool, it works!"
touch cruft.txt
sudo -n true > /dev/null 2>&1
has_root=$?
if [ $has_root -eq 0 ]; then 
    echo "HEy, root!"
else
    echo "nope, no root"
fi

# TODO: Actually exit here
#exit 0
rm cruft.txt
