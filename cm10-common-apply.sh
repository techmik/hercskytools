# Should only be called from the other apply scripts!

################ Apply Patches Below ####################

repo start auto device/samsung/msm8660-common
cdv device/samsung/msm8660-common
echo "### msm8660: msm8660: Update headers to match new kernelspace"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_device_samsung_msm8660-common refs/changes/60/21060/1 && git cherry-pick FETCH_HEAD
echo "### msm8660: Enable HW VSYNC"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_device_samsung_msm8660-common refs/changes/61/21061/3 && git cherry-pick FETCH_HEAD
echo "### msm8660: Update media_codecs.xml"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_device_samsung_msm8660-common refs/changes/88/21088/3 && git cherry-pick FETCH_HEAD
echo "### msm8660: use toolchain 4.4.3 for kernel compile"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_device_samsung_msm8660-common refs/changes/68/21168/1 && git cherry-pick FETCH_HEAD
cdb

