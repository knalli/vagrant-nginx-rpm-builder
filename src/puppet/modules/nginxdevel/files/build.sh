#!/bin/sh
cd ~/project/src/build
./create-rpm-builder.sh
cd ~
./rpm-builder.sh
exit $?
