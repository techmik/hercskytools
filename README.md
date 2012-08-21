CM10 Build Instructions
=======================
```
mkdir cm10
cd cm10
repo init -u git://github.com/CyanogenMod/android.git -b ics
```

Modify your `.repo/local_manifest.xml` as follows:

```xml
<?xml version="1.0" encoding="UTF-8"?>
  <manifest>
    <project name="TeamChopsticks/hercskytools" path="hercskytools" remote="github" revision="ics" />
  </manifest>
```

```
repo sync
vendor/cm/get-prebuilts
```

Auto Apply Patches
==================
This script will remove any topic branches named auto, then apply all patches under topic branch auto.

```
hercskytools/cm10-apply.sh
```

Build
=====

```
. build/envsetup.sh
breakfast cm_skyrocket-userdebug #if building for skyrocket
breakfast cm_hercules-userdebug #if building for hercules
mka bacon
```
