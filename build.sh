#!/bin/sh

# ./build.sh            Starting VM and provisioning it, then build the RPM and finally halt the VM again.
# ./build.sh -f         Like without -f, but ensures VM will be destroyed before starting it.
# ./build.sh -d         Like without -f, but tries to resume and suspend the vm for faster rebuilds.

rm -rf target

if [ "$1" = "-f" ]; then
  vagrant destroy -f
fi

# Ensure vm is up
if [ "$1" = "-d" ]; then
  vagrant resume || vagrant up
else
  vagrant up
fi

if [ $? != 0 ]; then
  echo "Something went wrong! :("
  exit 1
fi

# Perform the generated build script
vagrant ssh -c "~/build.sh"

if [ $? != 0 ]; then
  echo "Something went wrong! :("
  exit 1
fi

if [ "$1" = "-d" ]; then
  vagrant suspend
else
  vagrant halt
fi

echo "Finished!"
