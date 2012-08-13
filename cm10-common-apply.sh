# Should only be called from the other apply scripts!

################ Apply Patches Below ####################

repo start auto device/samsung/msm8660-common
cdv device/samsung/msm8660-common
echo "### msm8660: msm8660: Update headers to match new kernelspace"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_device_samsung_msm8660-common refs/changes/60/21060/1 && git cherry-pick FETCH_HEAD
echo "### msm8660: Enable HW VSYNC"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_device_samsung_msm8660-common refs/changes/61/21061/1 && git cherry-pick FETCH_HEAD
echo "### msm8660: Update media_codecs.xml"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_device_samsung_msm8660-common refs/changes/88/21088/1 && git cherry-pick FETCH_HEAD
#echo "### msm8660: use toolchain 4.4.3 for kernel compile"
#git fetch http://review.cyanogenmod.com/CyanogenMod/android_device_samsung_msm8660-common refs/changes/50/21150/1 && git cherry-pick FETCH_HEAD
cdb

repo start auto hardware/qcom/audio
cdv hardware/qcom/audio
echo "### audio/msm8660: Derive AudioPolicyManager and add FM device"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_hardware_qcom_audio refs/changes/64/20964/1 && git cherry-pick FETCH_HEAD
echo "### audio/msm8660: Fix for crash during encoding"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_hardware_qcom_audio refs/changes/65/20965/1 && git cherry-pick FETCH_HEAD
echo "### audio/msm8660: ifdef fm for policy"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_hardware_qcom_audio refs/changes/66/20966/1 && git cherry-pick FETCH_HEAD
echo "### audio/msm8660: remove local msm_audio_config struct definition"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_hardware_qcom_audio refs/changes/55/21155/1 && git cherry-pick FETCH_HEAD
echo "### audio/msm8660: perform null checks audio preprocessing call"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_hardware_qcom_audio refs/changes/78/20878/1 && git cherry-pick FETCH_HEAD
cdb

repo start auto hardware/libhardware_legacy
cdv hardware/libhardware_legacy
echo "### audio policy: To enable FM add FM device and volume api"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_hardware_libhardware_legacy refs/changes/71/20971/1 && git cherry-pick FETCH_HEAD
cdb

repo start auto hardware/libhardware
cdv hardware/libhardware
echo "### hardware: To enable FM add set volume functions"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_hardware_libhardware refs/changes/70/20970/1 && git cherry-pick FETCH_HEAD
cdb

repo start auto system/core
cdv system/core
echo "### system/core: To enable FM add FM stream, device and driver"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_system_core refs/changes/68/20968/1 && git cherry-pick FETCH_HEAD
cdb

repo start auto frameworks/av
cdv frameworks/av
echo "### frameworks/av: Enable FM and add FMA2DPWriter."
git fetch http://review.cyanogenmod.com/CyanogenMod/android_frameworks_av refs/changes/67/20967/2 && git cherry-pick FETCH_HEAD
cdb
cdb

