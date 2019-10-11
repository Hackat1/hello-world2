#!/bin/bash
yum -y install wget
wget https://raw.githubusercontent.com/Hackat1/hello-world2/master/packages.txt
for packages in $(cat packages.txt); do
  yum -y install $packages 
done
