# Should only be called from the other apply scripts!

################ Apply Patches Below ####################

repo start auto device/samsung/msm8660-common
cdv device/samsung/msm8660-common
echo "### msm8660: enable mounting of both sdcards in recovery USB mass storage"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_device_samsung_msm8660-common refs/changes/30/21430/4 && git cherry-pick FETCH_HEAD
cdb

repo start auto kernel/samsung/msm8660-common
cdv kernel/samsung/msm8660-common
echo "### Merge in Samsung changes for SGH-T879"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_kernel_samsung_msm8660-common refs/changes/57/21457/1 && git cherry-pick FETCH_HEAD
cdb

