CM10.1 Build Instructions
=======================
```
mkdir cm-10.1
cd cm-10.1
repo init -u git://github.com/CyanogenMod/android.git -b cm-10.1
```

Modify your `.repo/local_manifest.xml` as follows:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<manifest>
  <project name="TheMuppets/proprietary_vendor_samsung" path="vendor/samsung" remote="github" />
  <project name="TeamChopsticks/hercskytools" path="hercskytools" remote="github" revision="master">
   <copyfile src="/hercskytools/build.sh" dest="build.sh" />
</manifest>
```

```
repo sync
vendor/cm/get-prebuilts
```

Build
=====

```
. build/envsetup.sh
breakfast cm_skyrocket-userdebug  # only if building for skyrocket
breakfast cm_hercules-userdebug   # only if building for hercules
./hercskytools/cm-10.1-apply.sh   # apply our patches (done on topic branch 'auto')
mka bacon
```

or

---
Use the build.sh script.

```
./hercskytools/build.sh clean      # cleans and clobbers
./hercskytools/build.sh prepare    # abandons old branches and repo sync
./hercskytools/build.sh skyrocket-10.1  # runs update script and builds for skyrocket cm-10.1
./hercskytools/build.sh skyrocket-10.2  # runs update script and builds for skyrocket cm-10.1
./hercskytools/build.sh hercules-10.1   # runs update script and builds for hercules cm-10.1
./hercskytools/build.sh hercules-10.2   # runs update script and builds for hercules cm-10.2
```
