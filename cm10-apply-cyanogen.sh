#!/bin/bash

unset SUCCESS
on_exit() {
  if [ -z "$SUCCESS" ]; then
    echo "ERROR: $0 failed.  Please fix the above error."
    exit 1
  else
    echo "SUCCESS: $0 has completed."
    exit 0
  fi
}
trap on_exit EXIT

http_patch() {
  PATCHNAME=$(basename $1)
  curl -L -o $PATCHNAME -O -L $1
  cat $PATCHNAME |patch -p1
  rm $PATCHNAME
}

# Change directory verbose
cdv() {
  echo
  echo "*****************************"
  echo "Current Directory: $1"
  echo "*****************************"
  cd $BASEDIR/$1
}

# Change back to base directory
cdb() {
  cd $BASEDIR
}

# Sanity check
if [ -d ../.repo ]; then
  cd ..
fi
if [ ! -d .repo ]; then
  echo "ERROR: Must run this script from the base of the repo."
  SUCCESS=true
  exit 255
fi

# Save Base Directory
BASEDIR=$(pwd)

set -e

################ Apply the Normal Patches Below ####################

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
$DIR/cm10-apply.sh


################ Apply Common Patches Below ####################

repo start auto device/samsung/msm8660-common
cdv device/samsung/msm8660-common
echo "### CYANOGEN'S MSM8660 PATCHES"
git pull http://review.cyanogenmod.com/CyanogenMod/android_device_samsung_msm8660-common refs/changes/00/22800/4
cdb


################ Apply Hercules-Specific Patches Below ####################

if [ -e device/samsung/hercules ]; then
repo start auto device/samsung/hercules
cdv device/samsung/hercules
echo "### hercules: Consolidate system properties"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_device_samsung_hercules refs/changes/01/22801/1 && git cherry-pick FETCH_HEAD
cdb
fi

################ Apply Skyrocket-Specific Patches Below ####################

if [ -e device/samsung/skyrocket ]; then
repo start auto device/samsung/skyrocket
cdv device/samsung/skyrocket
echo "### skyrocket: Consolidate system properties"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_device_samsung_skyrocket refs/changes/04/22804/1 && git cherry-pick FETCH_HEAD
cdb
fi


##### SUCCESS ####
SUCCESS=true
exit 0

