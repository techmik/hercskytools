# Should only be called from the other apply scripts!

################ Apply Patches Below ####################

repo start auto hardware/qcom/audio
cdv hardware/qcom/audio
echo "### audio/msm8660: add compatibility for the older voice api"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_hardware_qcom_audio refs/changes/46/20046/2 && git cherry-pick FETCH_HEAD
cdb

repo start auto frameworks/av
cdv frameworks/av
echo "### ACodec: Video bringup for NuPlayer and other fixes"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_frameworks_av refs/changes/11/19411/7 && git cherry-pick FETCH_HEAD
cdb

