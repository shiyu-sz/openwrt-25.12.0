include $(TOPDIR)/rules.mk

# 包名和版本
PKG_NAME:=example_qt
PKG_VERSION:=1.0
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

# 定义包的菜单位置
define Package/$(PKG_NAME)
  SECTION:=utils
  CATEGORY:=my_package
  TITLE:=My Custom Qt Application
  DEPENDS:=+qt5base-core +qt5base-gui +qt5base-widgets +libpcre2 +libstdcpp
endef

# 准备源码：如果是本地代码，直接拷贝过去
define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./src/* $(PKG_BUILD_DIR)/
endef

# 配置阶段：调用 qmake
# 
define Build/Configure
	(cd $(PKG_BUILD_DIR); \
		$(STAGING_DIR)/host/bin/qt5/qmake \
		$(PKG_BUILD_DIR)/example_qt.pro \
		CONFIG+=release \
        "QMAKE_CC=$(TARGET_CC)" \
		"QMAKE_CXX=$(TARGET_CXX)" \
		"QMAKE_LINK=$(TARGET_CXX)" \
		"QMAKE_LFLAGS+=$(TARGET_LDFLAGS)" \
	)
endef

# 编译阶段：直接执行 make
define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR)
endef

# 安装阶段：将生成的二进制文件拷贝到镜像对应的目录
define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/$(PKG_NAME) $(1)/usr/bin/
endef

$(eval $(call BuildPackage,$(PKG_NAME)))