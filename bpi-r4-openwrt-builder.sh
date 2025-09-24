#!/bin/bash

rm -rf openwrt
rm -rf mtk-openwrt-feeds

git clone --branch master https://git.openwrt.org/openwrt/openwrt.git openwrt || true
cd openwrt; git checkout 5edf6a4c25d6e5fc9046d4e5533b79b07bcb3ef4; cd -;		#ath79: whr-g301n: remove custon wifi LED

git clone https://git01.mediatek.com/openwrt/feeds/mtk-openwrt-feeds || true
cd mtk-openwrt-feeds; git checkout cd9889f1eda6be7abe98416a2e19821166caa92c; cd -;	#Add support to get package information for unified autobuild

echo "cd9889" > mtk-openwrt-feeds/autobuild/unified/feed_revision

#\cp -r my_files/w-rules mtk-openwrt-feeds/autobuild/unified/filogic/rules

### required & thermal zone 
#\cp -r my_files/1007-wozi-arch-arm64-dts-mt7988a-add-thermal-zone.patch mtk-openwrt-feeds/24.10/patches-base/

sed -i 's/CONFIG_PACKAGE_perf=y/# CONFIG_PACKAGE_perf is not set/' mtk-openwrt-feeds/autobuild/unified/filogic/mac80211/24.10/defconfig
sed -i 's/CONFIG_PACKAGE_perf=y/# CONFIG_PACKAGE_perf is not set/' mtk-openwrt-feeds/autobuild/autobuild_5.4_mac80211_release/mt7988_wifi7_mac80211_mlo/.config
sed -i 's/CONFIG_PACKAGE_perf=y/# CONFIG_PACKAGE_perf is not set/' mtk-openwrt-feeds/autobuild/autobuild_5.4_mac80211_release/mt7986_mac80211/.config

#\cp -r my_files/3703-6.6.103-remove-uci-duplicate-ports.patch mtk-openwrt-feeds/autobuild/unified/filogic/24.10/patches-base/

cd openwrt
bash ../mtk-openwrt-feeds/autobuild/unified/autobuild.sh filogic-mac80211-mt7988_rfb-mt7996 log_file=make

exit 0

