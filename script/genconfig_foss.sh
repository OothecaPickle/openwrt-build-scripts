#!/bin/sh


if [ ! -z "$1" -a "$1" != "snapshot" ]; then
  buildinfo="https://downloads.openwrt.org/releases/$1/targets/qualcommax/ipq807x/config.buildinfo"
else
  buildinfo="https://downloads.openwrt.org/snapshots/targets/qualcommax/ipq807x/config.buildinfo"
fi
[ ! -z $3 ] && builddevice=$3

wget $buildinfo -O - | grep -v CONFIG_TARGET_DEVICE_ | grep -v CONFIG_TARGET_ALL_PROFILES | grep -v CONFIG_TARGET_MULTI_PROFILE > .config

echo "
CONFIG_TARGET_ALL_PROFILES=n 
CONFIG_TARGET_MULTI_PROFILE=n
CONFIG_PACKAGE_luci=y
" >> .config

if [ "${builddevice}" = "HomeWRK" ]; then
  echo "
CONFIG_TARGET_qualcommax_ipq807x_DEVICE_linksys_homewrk=y
CONFIG_TARGET_DEVICE_qualcommax_ipq807x_DEVICE_linksys_homewrk=y
CONFIG_TARGET_DEVICE_PACKAGES_qualcommax_ipq807x_DEVICE_linksys_homewrk=\"\"
" >> .config
elif [ "${builddevice}" = "MX4300" ]; then
  echo "
CONFIG_TARGET_qualcommax_ipq807x_DEVICE_linksys_mx4300=y
CONFIG_TARGET_DEVICE_qualcommax_ipq807x_DEVICE_linksys_mx4300=y
CONFIG_TARGET_DEVICE_PACKAGES_qualcommax_ipq807x_DEVICE_linksys_mx4300=\"\"
" >> .config
fi

make defconfig

#add libpam
#echo CONFIG_PACKAGE_libpam=y >> .config

#skip xdp compile
#cat .config | grep -v "CONFIG_PACKAGE.*xdp" > .config.tmp
#cp .config.tmp .config

