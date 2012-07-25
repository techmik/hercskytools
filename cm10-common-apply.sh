# Should only be called from the other apply scripts!

################ Apply Patches Below ####################

repo start auto sdk
cdv sdk
echo "### Changed make files to allow compiling in OS X 10.8 - Mountain Lion"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_sdk refs/changes/87/19487/1 && git cherry-pick FETCH_HEAD
cdb

repo start auto external/qemu
cdv external/qemu
echo "### Changed make files to allow compiling in OS X 10.8 - Mountain Lion"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_external_qemu refs/changes/86/19486/2 && git cherry-pick FETCH_HEAD
cdb

repo start auto hardware/qcom/display
cdv hardware/qcom/display
echo "### overlay: Allow kernel-controlled rotator formats"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_hardware_qcom_display refs/changes/57/19557/1 && git cherry-pick FETCH_HEAD
cdb

repo start auto hardware/qcom/audio
cdv hardware/qcom/audio
echo "### audio/msm8660: add compatibility for the older voice api"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_hardware_qcom_audio refs/changes/46/20046/2 && git cherry-pick FETCH_HEAD
cdb

repo start auto packages/apps/Torch
cdv packages/apps/Torch
echo "### Torch: fix breakage from 19844"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_packages_apps_Torch refs/changes/65/20065/1 && git cherry-pick FETCH_HEAD
cdb

#repo start auto device/samsung/msm8660-common
#cdv device/samsung/msm8660-common
#echo "### Reverting: bln: new driver with kernel blink and rate support [1/2]"
#git revert -n b2ff6ec11e9a4c50517491347ed3685d53450e44
#git commit -m "reverting b2ff6ec11e9a4c50517491347ed3685d53450e44"
#cdb

#repo start auto kernel/samsung/msm8660-common
#cdv kernel/samsung/msm8660-common
#echo "### Reverting: bln: new driver with kernel blink and rate support [2/2]"
#git revert -n 7dadd406832acf292477881c4e779a3ba6eb0255
#git commit -m "reverting 7dadd406832acf292477881c4e779a3ba6eb0255"
#cdb

