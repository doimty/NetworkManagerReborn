include $(THEOS)/makefiles/common.mk

export TARGET = iphone:clang:latest:11.0
export ARCHS = arm64 arm64e

BUNDLE_NAME = NetworkManager
NetworkManager_BUNDLE_EXTENSION = bundle
NetworkManager_FILES = CCNetworkManager.x
NetworkManager_FRAMEWORKS = CoreTelephony
NetworkManager_INSTALL_PATH = /Library/ControlCenter/Bundles/

NetworkManager_CFLAGS += "-Wno-unused-function"
NetworkManager_CFLAGS += "-Wno-unused-variable"
NetworkManager_CFLAGS += "-Wno-error=objc-method-access"

# For non-roothide: link to ControlCenterUIKit
ifneq ($(THEOS_PACKAGE_SCHEME),roothide)
NetworkManager_PRIVATE_FRAMEWORKS = ControlCenterUIKit
endif

# For roothide: link roothide library, use -undefined dynamic_lookup instead of private frameworks
ifeq ($(THEOS_PACKAGE_SCHEME),roothide)
NetworkManager_LIBRARIES = roothide
NetworkManager_LDFLAGS += -undefined dynamic_lookup
endif

after-install::
	install.exec "killall -9 SpringBoard"

include $(THEOS_MAKE_PATH)/bundle.mk
SUBPROJECTS += networkmanagerprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
