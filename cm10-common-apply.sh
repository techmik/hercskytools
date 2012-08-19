# Should only be called from the other apply scripts!

################ Apply Patches Below ####################

repo start auto frameworks/base
cdv frameworks/base
echo "### SamsungQualcommUiccRil: hack to prevent SIM unlock popup"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_frameworks_base refs/changes/19/21719/1 && git cherry-pick FETCH_HEAD
cdb

