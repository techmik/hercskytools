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

# Sanity check
if [ -d ../.repo ]; then
  cd ..
fi
if [ ! -d .repo ]; then
  echo "ERROR: Must run this script from the base of the repo."
  SUCCESS=true
  exit 255
fi

# Abandon auto topic branch
repo abandon auto
set -e

#
# List of changes to apply
#
# Format is DIRECTORY followed by a COLON followed by a COMMA
# SEPARATED LIST of gerrit numbers to cherry pick.
#
# Gerrit numbers should have a SLASH and the desired patch number.
#
CHANGES+=('device/samsung/msm8660-common:37948/1')
#CHANGES+=('device/samsung/celox-common:')
CHANGES+=('kernel/samsung/msm8660-common:42895/1')
CHANGES+=('kernel/samsung/msm8660-common:43367/3')

#
# Apply patches from the CHANGES array
#
for changes_index in "${!CHANGES[@]}"
do
    change_description=${CHANGES[$changes_index]}
    temp=(${change_description//:/ })
    project_path=${temp[0]}
    IN=${temp[1]}
    gerrits=(${IN//,/ })

    if [ ${#gerrits[@]} -gt 0 ]; then
        if [ -e $project_path ]; then
            echo
            echo "**********************************************************"
            echo "Current directory: $project_path"
            echo "**********************************************************"
            echo "Applying: ${gerrits[@]}"
            repo start auto $project_path
            repo download -c $project_path ${gerrits[@]}
        else
            echo
            echo "**********************************************************"
            echo "Skipping (since it doesn't exist): $project_path"
            echo "**********************************************************"
        fi
    fi
done

##### SUCCESS ####
SUCCESS=true
exit 0

