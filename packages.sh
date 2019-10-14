#!/bin/bash
if [ -e /usr/bin/wget ]; then 
  exit 0; 
fi
yum install -y wget
wget https://raw.githubusercontent.com/Hackat1/hello-world2/master/packages.txt
for packages in $(cat packages.txt); do
  yum install -y $packages 
done
git clone https://github.com/Hackat1/hello-world2.git
cd hello-world2/
git config --global user.name "Hackat1"
git config --global user.email christopher.hackat1@seattlecolleges.ed
