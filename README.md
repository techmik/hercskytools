CM10.2 Build Instructions
=======================
```
mkdir cm-10.2
cd cm-10.2
repo init -u git://github.com/CyanogenMod/android.git -b cm-10.2
```

Modify your `.repo/local_manifest.xml` as follows:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<manifest>
  <project name="TheMuppets/proprietary_vendor_samsung" path="vendor/samsung" remote="github" />
  <project name="TeamChopsticks/hercskytools" path="hercskytools" remote="github" revision="master" />
   <copyfile src="build.sh" dest="build.sh" />
</manifest>
```

From your cm-10.2 directory, execute the following to pull all source code from github:

```
repo sync
vendor/cm/get-prebuilts
```

Build
=====

Build manually:

```
. build/envsetup.sh
make clean                        # remove the curent out directory for a clean build
breakfast cm_skyrocket-userdebug  # only if building for skyrocket
breakfast cm_hercules-userdebug   # only if building for hercules
breakfast cm_quincyatt-userdebug  # only if building for quincy
./hercskytools/cm-10.2-celox.sh   # apply our patches (done on topic branch 'auto')
mka bacon
```

Build with the Team Chopsticks build tools to include gerrit patches automatically:

```
build.sh clean           # cleans and clobbers
build.sh prepare         # abandons old branches and repo sync

build.sh skyrocket-10.1  # runs update script and builds for skyrocket cm-10.1
build.sh skyrocket-10.2  # runs update script and builds for skyrocket cm-10.2

build.sh hercules-10.1   # runs update script and builds for hercules cm-10.1
build.sh hercules-10.2   # runs update script and builds for hercules cm-10.2

build.sh quincyatt-10.1  # runs update script and builds for quincyatt cm-10.1
build.sh quincyatt-10.2  # runs update script and builds for quincyatt cm-10.2
```

*Note: For the CM10.1 builds noted above, you will need to reset your source repositories to the cm-10.1 branch.
