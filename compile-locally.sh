# tar -czvf everything.tar.gz /etc/ /tmp/ /usr/

cd /home/y29shi/OpenWRT_x86_x64
chmod +x immortalwrt/*.sh
/home/y29shi/OpenWRT_x86_x64/immortalwrt/system-Information.sh

# git clone --depth 1 https://github.com/immortalwrt/immortalwrt -b openwrt-24.10 openwrt
git clone --depth 1 https://github.com/immortalwrt/immortalwrt -b openwrt-24.10 openwrt


cd openwrt
# sed -i '1i src-git passwall_packages https://github.com/Openwrt-Passwall/openwrt-passwall-packages.git;main\n' feeds.conf.default
# sed -i '1i src-git passwall_luci https://github.com/Openwrt-Passwall/openwrt-passwall.git;main\n' feeds.conf.default
# sed -i '1i src-git passwall2_luci https://github.com/Openwrt-Passwall/openwrt-passwall2.git;main\n' feeds.conf.default
./scripts/feeds update -a

# rm -rf feeds/packages/lang/golang
# git clone https://github.com/sbwml/packages_lang_golang feeds/packages/lang/golang

# sed -i -e 's/PKG_VERSION:=1.9.5/PKG_VERSION:=1.9.4/' -e 's/PKG_MIRROR_HASH:=a9d53209c5e31503cdc61518ca5887bb01cf1dab546928272a9aa7051713e4be/PKG_MIRROR_HASH:=0521b15bb15ad46704ccf65f7ae683a47d54e7bae57fbe4e2a4341da6d424e58/' feeds/packages/utils/irqbalance/Makefile
# sed -i -e 's/PKG_VERSION:=26.2.4/PKG_VERSION:=25.1.1/' -e 's/PKG_HASH:=192200a0b60232a5fd7f63edf5dfa88ecb568f9b40049ca4676b6441f8da6eac/PKG_HASH:=619b10d24bab367a0788b3585f8d31fa4e5e060be7f72647d6ee17bd744603a5/' feeds/passwall_packages/xray-core/Makefile
# sed -i -e 's/PKG_VERSION:=5.44.1/PKG_VERSION:=5.25.0/' -e 's/PKG_HASH:=b8b00f576744716b1ab0c461a45b2b5d4195b763a49d296fd2ddfcf23db87fe5/PKG_HASH:=64d2cc376c16ade97b8e2cce69e0c98d74f530dcf8a30cf7d22255969ca5c10d/' feeds/passwall_packages/v2ray-plugin/Makefile
# sed -i -e 's/PKG_VERSION:=2.7.0/PKG_VERSION:=2.6.5/' -e 's/PKG_HASH:=3cac6adeccdac7cc8b353948e3cead1eb8606aa8ce74dac4853d821a22ceeba7/PKG_HASH:=21a04ef8ce640d7c60c3b8678500b6e6481862d9af62f9ce2663b772211718d0/' feeds/passwall_packages/hysteria/Makefile

# # Fix tools/automake build failure (avoid regeneration)
# sed -i 's|./bootstrap|find . -name Makefile.in -exec touch {} +; touch aclocal.m4 configure|' tools/automake/Makefile
# # Fix Rust build failure (upgrade to 1.90.0 for valid artifacts)
# sed -i -e 's/PKG_VERSION:=1.89.0/PKG_VERSION:=1.90.0/' -e 's/PKG_HASH:=.*/PKG_HASH:=6bfeaddd90ffda2f063492b092bfed925c4b8c701579baf4b1316e021470daac/' feeds/packages/lang/rust/Makefile
# # Fix iptables build failure (remove ABI_VERSION:=0 from libiptext-nft)
# sed -i '/define Package\/libiptext-nft/,/endef/s/ ABI_VERSION:=0//' package/network/utils/iptables/Makefile
# # Fix Geoview Go version mismatch (downgrade to Go 1.23 + fix dependencies)
# sed -i "/define Package\/geoview\/install/i define Build/Prepare\n\t\$(call Build/Prepare/Default)\n\t\$(SED) 's/go 1.24.*/go 1.23/g' \$(PKG_BUILD_DIR)/go.mod\n\techo \"replace golang.org/x/sys => golang.org/x/sys v0.29.0\" >> \$(PKG_BUILD_DIR)/go.mod\n\tcd \$(PKG_BUILD_DIR) && \$(GO_PKG_VARS) go mod tidy\nendef\n" feeds/passwall_packages/geoview/Makefile
# # Fix libsodium build error (timestamp issue)
# sed -i "/define Package\/libsodium\/install/i define Build/Configure\n\t(cd \$(PKG_BUILD_DIR); touch configure config.sub config.guess aclocal.m4 Makefile.in; sleep 1)\n\t\$(call Build/Configure/Default)\nendef\n" feeds/packages/libs/libsodium/Makefile
# # Fix sysfsutils build error (timestamp issue)
# sed -i "/define Build\/InstallDev/i define Build/Configure\n\t(cd \$(PKG_BUILD_DIR); touch configure config.sub config.guess aclocal.m4 Makefile.in; sleep 1)\n\t\$(call Build/Configure/Default)\nendef\n" package/libs/sysfsutils/Makefile
# # Fix libqmi build error (clock skew)
# sed -i "/define Build\/InstallDev/i define Build/Configure\n\t\$(call Meson/CreateNativeFile,\$(PKG_BUILD_DIR)/openwrt-native.txt)\n\t\$(call Meson/CreateCrossFile,\$(PKG_BUILD_DIR)/openwrt-cross.txt)\n\t(cd \$(PKG_BUILD_DIR); touch openwrt-native.txt openwrt-cross.txt; sleep 1)\n\t\$(call Meson, \\\n\t\tsetup \\\n\t\t--buildtype \$(if \$(CONFIG_DEBUG),debug,plain) \\\n\t\t--native-file \$(PKG_BUILD_DIR)/openwrt-native.txt \\\n\t\t--cross-file \$(PKG_BUILD_DIR)/openwrt-cross.txt \\\n\t\t-Ddefault_library=both \\\n\t\t\$(MESON_ARGS) \\\n\t\t\$(MESON_BUILD_DIR) \\\n\t\t\$(MESON_BUILD_DIR)/.., \\\n\t\t\$(MESON_VARS))\nendef\n" feeds/packages/libs/libqmi/Makefile
# # Fix xray-plugin build error (invalid reference to net.errNoSuchInterface)
# sed -i '/GO_PKG:=/a GO_PKG_LDFLAGS:=-s -w -checklinkname=0' feeds/passwall_packages/xray-plugin/Makefile

# Fix wget APK packaging error (remove invalid @wget-any virtual package syntax)
# sed -i 's/PROVIDES:=wget @wget-any/PROVIDES:=wget/' feeds/packages/net/wget/Makefile

./scripts/feeds install -a


cd ..
chmod +x immortalwrt/*.sh && cd openwrt
../immortalwrt/diy-part1.sh

cd ..
[ -e "immortalwrt/x86_64/defconfig" ] && cat "immortalwrt/x86_64/defconfig" > openwrt/.config
chmod +x immortalwrt/*.sh && cd openwrt
../immortalwrt/diy-part2.sh

echo '
CONFIG_DOCKER_CGROUP_OPTIONS=y
CONFIG_DOCKER_NET_MACVLAN=y
CONFIG_DOCKER_STO_EXT4=y
CONFIG_PACKAGE_docker=y
CONFIG_PACKAGE_docker-compose=y
CONFIG_PACKAGE_dockerd=y
CONFIG_PACKAGE_luci-app-dockerman=y
CONFIG_PACKAGE_luci-app-netspeedtest=y
CONFIG_PACKAGE_luci-i18n-dockerman-zh-cn=y
CONFIG_PACKAGE_luci-lib-docker=y
' >> .config
make defconfig
make download -j$(nproc)
find dl -size -1024c -exec ls -l {} \;
find dl -size -1024c -exec rm -f {} \;

rm ../build.log
make -j$(nproc) 2>&1 | tee ../build.log || make -j1 2>&1 | tee -a ../build.log || make -j1 V=sc 2>&1 | tee -a ../build.log

cd bin
find packages/ -type f -name '*.*pk' | zip targets/x86/64/packages.zip -@