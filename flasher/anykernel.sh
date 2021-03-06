# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
do.devicecheck=0
do.modules=0
do.cleanup=1
do.cleanuponabort=0
device.name1=pine
'; } # end properties

# shell variables
block=/dev/block/platform/soc/7824900.sdhci/by-name/boot
is_slot_device=0;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;


## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
set_perm_recursive 0 0 755 644 $ramdisk/*;
set_perm_recursive 0 0 750 750 $ramdisk/init* $ramdisk/sbin;

## AnyKernel install
ui_print "          |                            |          ";
ui_print "          |       • Beginning...       |          ";
ui_print "          |       • Unpacking...       |          ";
split_boot;
ui_print "          |       • Magic...           |          ";
#
# Replace qcom.post_boot
#
mountpoint -q /data && {
  # Install custom fstab
  mkdir -p /data/adb/magisk_simple/vendor/etc;
  cp $TMPDIR/gm/fstab.qcom /data/adb/magisk_simple/vendor/etc;
  chmod 644 /data/adb/magisk_simple/vendor/etc/fstab.qcom; }

ui_print "          |       • Finishing...       |          ";
ui_print "          |____________________________|          ";
flash_boot;
## end install
