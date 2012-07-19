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

# Abandon auto topic branch
repo abandon auto
set -e

################ Apply Patches Below ####################


repo start auto sdk
cdv sdk
echo "### Changed make files to allow compiling in OS X 10.8 - Mountain Lion"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_sdk refs/changes/87/19487/1 && git cherry-pick FETCH_HEAD
cdb

repo start auto external/qemu
cdv external/qemu
echo "### Changed make files to allow compiling in OS X 10.8 - Mountain Lion"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_external_qemu refs/changes/86/19486/1 && git cherry-pick FETCH_HEAD
cdb

repo start auto hardware/qcom/display
cdv hardware/qcom/display
echo "### overlay: Allow kernel-controlled rotator formats"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_hardware_qcom_display refs/changes/57/19557/1 && git cherry-pick FETCH_HEAD
cdb

repo start auto hardware/qcom/audio
cdv hardware/qcom/audio
echo "### audio:msm8660: Fix for NT mode encode in audio HAL"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_hardware_qcom_audio refs/changes/78/19378/1 && git cherry-pick FETCH_HEAD
echo "### audio/msm8660: add support for Samsung T989/I727"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_hardware_qcom_audio refs/changes/46/19346/3 && git cherry-pick FETCH_HEAD
echo "### msm8660: Add support for Samsung voice devices"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_hardware_qcom_audio refs/changes/10/19410/1 && git cherry-pick FETCH_HEAD
echo "### msm8660: Use VR channels on Samsung devices"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_hardware_qcom_audio refs/changes/37/19637/2 && git cherry-pick FETCH_HEAD
echo "### msm8660: Change fallback route to speaker"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_hardware_qcom_audio refs/changes/39/19639/1 && git cherry-pick FETCH_HEAD
echo "### msm8660: Add samsung dualmic support"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_hardware_qcom_audio refs/changes/40/19640/1 && git cherry-pick FETCH_HEAD
echo "### msm8660: Add support for camcorder mic"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_hardware_qcom_audio refs/changes/41/19641/1 && git cherry-pick FETCH_HEAD
echo "### audio/msm8660: Add support for sony camcorder mic"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_hardware_qcom_audio refs/changes/42/19642/1 && git cherry-pick FETCH_HEAD
cdb

##### SUCCESS ####
SUCCESS=true
exit 0
