TARGET := iphone:clang:latest:9.0
INSTALL_TARGET_PROCESSES = Twitter
ARCHS = arm64 armv7 armv7s

GIT_COMMIT_HASH := $(shell git rev-parse --short HEAD 2>/dev/null || echo "unknown")
GIT_BRANCH := $(shell git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "unknown")
PATCHER_VERSION := $(shell grep -m1 "Version:" control | cut -d' ' -f2)

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = TwitterLegacyPatcher

TwitterLegacyPatcher_FILES = Tweak.x
TwitterLegacyPatcher_CFLAGS = -fobjc-arc -Wno-deprecated-declarations -DPATCHER_VERSION=\"$(PATCHER_VERSION)\" -DGIT_COMMIT_HASH=\"$(GIT_COMMIT_HASH)\" -DGIT_BRANCH=\"$(GIT_BRANCH)\"

ifeq ($(FINALPACKAGE),1)
TwitterLegacyPatcher_CFLAGS += -DFINALPACKAGE
endif

include $(THEOS_MAKE_PATH)/tweak.mk
