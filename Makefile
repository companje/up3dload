##############################################
# OpenWrt Makefile for up3dload program
#
#
# Most of the variables used here are defined in
# the include directives below. We just need to
# specify a basic description of the package,
# where to build our program, where to find
# the source files, and where to install the
# compiled program on the router.
#
# Be very careful of spacing in this file.
# Indents should be tabs, not spaces, and
# there should be no trailing whitespace in
# lines that are not commented.
#
##############################################

include $(TOPDIR)/rules.mk

# Name and release number of this package
PKG_NAME:=up3dload
PKG_RELEASE:=1
PKG_VERSION:=0.7

include $(INCLUDE_DIR)/package.mk

define Package/up3dload
	SECTION:=up3dload
	CATEGORY:=up3dload
	TITLE:=up3dload -- upload UMC files to UP 3D printer
	DEPENDS:=+libusb-1.0 +@LIBC_USE_MUSL
endef

define Package/up3dload/description
	Upload UMC files to UP 3D printer
endef

define Build/Prepare
	@echo "Build/Prepare"
	@echo "=============================================="

	@echo "Package Build Dir"
	@echo $(PKG_BUILD_DIR)

	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./src/* $(PKG_BUILD_DIR)/
endef

# define Build/Compile
# 	@echo "======================Package Build Dir========================"
# 	@echo $(PKG_BUILD_DIR)
# 	# CONFIGURE_VARS+= \
#  #        CC="$(TOOLCHAIN_DIR)/bin/$(TARGET_CC)"

# 	$(TARGET_CONFIGURE_OPTS) \
# 		CFLAGS="$(TARGET_CFLAGS) -I$(STAGING_DIR)/usr/include -I$(PKG_BUILD_DIR)" \
# 		LDFLAGS="$(TARGET_LDFLAGS)" \
# 	$(MAKE) -C $(PKG_BUILD_DIR) all
# endef

define Package/up3dload/install
	@echo "Package Build Dir"
	@echo $(PKG_BUILD_DIR)
	$(INSTALL_DIR) $(1)/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/up3dload $(1)/bin/
endef

$(eval $(call BuildPackage,up3dload))
