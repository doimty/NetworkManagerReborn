include $(THEOS)/makefiles/common.mk

export TARGET = iphone:clang:latest:11.0
export ARCHS = arm64 arm64e
export VERSION = $(shell grep '^Version:' ../control | cut -d: -f2- | tr -d ' ')

BUNDLE_NAME = NetworkManagerPrefs

NetworkManagerPrefs_FILES = CCNMRootListController.m
NetworkManagerPrefs_INSTALL_PATH = /Library/PreferenceBundles
NetworkManagerPrefs_FRAMEWORKS = UIKit
# Preferences is a private framework, don't link against it
# NetworkManagerPrefs_PRIVATE_FRAMEWORKS = Preferences
NetworkManagerPrefs_CFLAGS = -fobjc-arc

NetworkManagerPrefs_CFLAGS += -DNETWORK_MANAGER_VERSION=\"$(VERSION)\"

# Link roothide library and allow undefined symbols for private frameworks
ifeq ($(THEOS_PACKAGE_SCHEME),roothide)
NetworkManagerPrefs_LIBRARIES = roothide
NetworkManagerPrefs_LDFLAGS += -undefined dynamic_lookup
endif

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	@echo "Version: $(VERSION)"
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/NetworkManagerPrefs.plist$(ECHO_END)
