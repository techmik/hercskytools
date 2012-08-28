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


################ Apply VoIP Common Patches Below ####################

repo start auto hardware/qcom/audio
cdv hardware/qcom/audio
echo "### audio/msm8660: fixes for QCOM_VOIP_ENABLED"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_hardware_qcom_audio refs/changes/39/20039/3 && git cherry-pick FETCH_HEAD
cdb

repo start auto device/samsung/msm8660-common
cdv device/samsung/msm8660-common
echo "### msm8660: set QCOM_VOIP_ENABLED"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_device_samsung_msm8660-common refs/changes/73/20073/2 && git cherry-pick FETCH_HEAD
cdb

repo start auto hardware/libhardware_legacy
cdv hardware/libhardware_legacy
echo "### audio: add DIRECTOUTPUT define"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_hardware_libhardware_legacy refs/changes/94/22294/1 && git cherry-pick FETCH_HEAD
cdb

repo start auto system/core
cdv system/core
echo "### audio: add DIRECTOUTPUT define"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_system_core refs/changes/95/22295/1 && git cherry-pick FETCH_HEAD
cdb


################ Apply Hercules-Specific VoIP Patches Below ####################

#if [ -e device/samsung/hercules ]; then
#fi

################ Apply Skyrocket-Specific VoIP Patches Below ####################

#if [ -e device/samsung/skyrocket ]; then
#fi


##### SUCCESS ####
SUCCESS=true
exit 0

