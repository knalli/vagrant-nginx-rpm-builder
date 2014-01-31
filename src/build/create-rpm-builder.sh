#!/bin/sh
cd ~/project/src/build/
ruby create-rpm-builder.rb > ~/rpm-builder.sh
chmod +x ~/rpm-builder.sh
exit $?
