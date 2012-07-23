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
git fetch http://review.cyanogenmod.com/CyanogenMod/android_external_qemu refs/changes/86/19486/1 && git cherry-pick FETCH_HEAD
cdb

repo start auto hardware/qcom/display
cdv hardware/qcom/display
echo "### overlay: Allow kernel-controlled rotator formats"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_hardware_qcom_display refs/changes/57/19557/1 && git cherry-pick FETCH_HEAD
cdb

repo start auto frameworks/av
cdv frameworks/av
echo "### camera: Add parameters for some Samsung cameras"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_frameworks_av refs/changes/21/19821/1 && git cherry-pick FETCH_HEAD
cdb

