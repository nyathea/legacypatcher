TARGET := iphone:clang:latest:14.0
INSTALL_TARGET_PROCESSES = Twitter
THEOS_PACKAGE_SCHEME = rootless

GIT_COMMIT_HASH := $(shell git rev-parse --short HEAD 2>/dev/null || echo "unknown")
GIT_BRANCH := $(shell git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "unknown")

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = TwitterLegacyPatcher

TwitterLegacyPatcher_FILES = Tweak.x
TwitterLegacyPatcher_CFLAGS = -fobjc-arc -Wno-deprecated-declarations -DGIT_COMMIT_HASH=\"$(GIT_COMMIT_HASH)\" -DGIT_BRANCH=\"$(GIT_BRANCH)\"

include $(THEOS_MAKE_PATH)/tweak.mk
