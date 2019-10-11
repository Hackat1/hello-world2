#!/bin/bash
myvar=$(systemctl status $1 | grep Active | awk ‘{print $2}’)
myvar2=”inactive”
if [$myvar == $myvar2]; then
	echo “noooooo it is off”
fi
