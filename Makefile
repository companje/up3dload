include $(TOPDIR)/rules.mk

PKG_NAME:=up3dload
PKG_VERSION:=2016-05-12-i
PKG_RELEASE=$(PKG_SOURCE_VERSION)

PKG_SOURCE_PROTO:=git
# PKG_SOURCE_URL:=git@github.com:companje/UP3D.git
PKG_SOURCE_URL:=https://github.com/companje/UP3D.git

	# file://Users/rick/Documents/Doodle3D/UP3D
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=master
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz
PKG_MAINTAINER:=Maik Stohn <git@stohn.de>

include $(INCLUDE_DIR)/package.mk

define Package/up3dload
	SECTION:=UP3D
	CATEGORY:=UP3D
	TITLE:=UpMachineCode (UMC) uploader
	DEPENDS:=+libusb-1.0 +@LIBC_USE_MUSL
endef

define Package/up3dshell
	SECTION:=UP3D
	CATEGORY:=UP3D
	TITLE:=interactive printer monitor and debugging tool
	DEPENDS:=+libusb-1.0 +libncurses +@LIBC_USE_MUSL
endef

define Package/up3dinfo
	SECTION:=UP3D
	CATEGORY:=UP3D
	TITLE:=info about the connected UP printer
	DEPENDS:=+libusb-1.0 +@LIBC_USE_MUSL
endef

define Build/Compile
	@echo "------------- Compile UPTOOLS -----------------"
	
	$(TARGET_CONFIGURE_OPTS) \
		CFLAGS="$(TARGET_CFLAGS) -I$(STAGING_DIR)/usr/include -I$(PKG_BUILD_DIR)" \
		LDFLAGS="$(TARGET_LDFLAGS)" \
		$(MAKE) -C $(PKG_BUILD_DIR)/UP3DTOOLS all
endef

define Package/up3dload/install
	$(INSTALL_DIR) $(1)/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/UP3DTOOLS/up3dload $(1)/bin/
endef

define Package/up3dshell/install
	$(INSTALL_DIR) $(1)/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/UP3DTOOLS/up3dshell $(1)/bin/
endef

define Package/up3dinfo/install
	$(INSTALL_DIR) $(1)/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/UP3DTOOLS/up3dinfo $(1)/bin/
endef

$(eval $(call BuildPackage,up3dload))
$(eval $(call BuildPackage,up3dshell))
$(eval $(call BuildPackage,up3dinfo))
