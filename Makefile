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
PKG_VERSION:=2016-05-12-h
PKG_RELEASE=$(PKG_SOURCE_VERSION)

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=git@github.com:companje/UP3D.git
	# /Users/rick/Documents/Doodle3D/UP3D
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=master
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz
PKG_MAINTAINER:=Maik Stohn <git@stohn.de>

include $(INCLUDE_DIR)/package.mk

define Package/up3dload
	SECTION:=UP3D
	CATEGORY:=UP3D
	TITLE:=up3dload - upload UMC files to UP 3D printer
	DEPENDS:=+libusb-1.0 +libncurses +@LIBC_USE_MUSL
endef

define Package/up3dload/description
	Upload UMC files to UP 3D printer
endef

define Build/Compile
	@echo "------------------------------------"
	@echo "$(PKG_BUILD_DIR)/UP3DTOOLS"

	$(TARGET_CONFIGURE_OPTS) \
		CFLAGS="$(TARGET_CFLAGS) -I$(STAGING_DIR)/usr/include -I$(PKG_BUILD_DIR)" \
		LDFLAGS="$(TARGET_LDFLAGS)" \
		$(MAKE) -C $(PKG_BUILD_DIR)/UP3DTOOLS all
endef

define Package/up3dload/install
	@echo "------------------------------------"
	@echo "Install: $(1)"
	$(INSTALL_DIR) $(1)/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/UP3DTOOLS/up3dload $(1)/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/UP3DTOOLS/up3dshell $(1)/bin/
endef

$(eval $(call BuildPackage,up3dload))


# # define Build/Prepare
# # 	@echo "Build/Prepare"
# # 	@echo "=============================================="
# # 	@echo "Package Build Dir"
# # 	# @echo $(PKG_BUILD_DIR)
# # 	mkdir -p $(PKG_BUILD_DIR)/UP3DCOMMON
# # 	pwd
# # 	#HET PAD IS VERKEERD. HIJ ZOU VANAF THE PACKIGE DIR MOETEN KOPIEREN
# #  HET MOEST TOCH EEN GITHUB URL ZIJN OM DE DEFAULT PREPARE GOED TE DOEN
#PKG_SOURCE_URL:=file://$(TOPDIR)/../Documents/[name]

# # 	#$(CP) ./UP3DCOMMON/* $(PKG_BUILD_DIR)/UP3DCOMMON
# # endef

# define Package/up3dload/install
# 	$(INSTALL_BIN) $(PKG_BUILD_DIR)/UP3DTOOLS/up3dload $(1)/bin/
# endef




# # define Build/Compile

# # FIXME

# # 	$(TARGET_CONFIGURE_OPTS) \
# # 		CFLAGS="$(TARGET_CFLAGS) -I$(STAGING_DIR)/usr/include -I$(PKG_BUILD_DIR)" \
# # 		LDFLAGS="$(TARGET_LDFLAGS)" \
# # 		$(MAKE) -C $(PKG_BUILD_DIR)/UP3DTOOLS/up3dload all
# # endef





# # define Build/Compile
# # 	$(TARGET_CONFIGURE_OPTS) \
# # 		CFLAGS="$(TARGET_CFLAGS) -I$(STAGING_DIR)/usr/include -I$(PKG_BUILD_DIR)" \
# # 		LDFLAGS="$(TARGET_LDFLAGS)" \
# # 		$(MAKE) -C $(PKG_BUILD_DIR)/UP3DTOOLS/up3dload all
# # endef

