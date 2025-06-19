TARGET := iphone:clang:latest:7.0
INSTALL_TARGET_PROCESSES = Twitter

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = TwitterLegacyPatcher

TwitterLegacyPatcher_FILES = Tweak.x
TwitterLegacyPatcher_CFLAGS = -fobjc-arc -Wno-deprecated-declarations

include $(THEOS_MAKE_PATH)/tweak.mk
