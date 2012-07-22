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
git fetch http://review.cyanogenmod.com/CyanogenMod/android_hardware_qcom_audio refs/changes/41/19641/2 && git cherry-pick FETCH_HEAD
echo "### audio/msm8660: Add support for sony camcorder mic"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_hardware_qcom_audio refs/changes/42/19642/1 && git cherry-pick FETCH_HEAD
cdb

repo start auto device/samsung/msm8660-common
cdv device/samsung/msm8660-common
echo "### bln: new driver with kernel blink and rate support [1/2]"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_device_samsung_msm8660-common refs/changes/18/19918/1 && git cherry-pick FETCH_HEAD
cdb

repo start auto kernel/samsung/msm8660-common
cdv kernel/samsung/msm8660-common
echo "### bln: new driver with kernel blink and rate support [2/2]"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_kernel_samsung_msm8660-common refs/changes/10/19810/2 && git cherry-pick FETCH_HEAD
cdb

