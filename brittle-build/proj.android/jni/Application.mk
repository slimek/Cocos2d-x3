NDK_TOOLCHAIN_VERSION := 4.8

APP_PLATFORM := android-15
APP_STL := gnustl_static

APP_CFLAGS := -fexceptions
APP_CPPFLAGS := -std=c++11 -frtti

#APP_ABI := x86 armeabi armeabi-v7a
#APP_ABI := x86
APP_ABI := armeabi


ifeq ($(NDK_DEBUG),1)

# Debug
APP_OPTIM := debug

COCOS_CONFIG := gcc48.Debug

APP_CFLAGS += -g -DCOCOS2D_DEBUG=1

else

# Release
APP_OPTIM := release

COCOS_CONFIG := gcc48.Release

endif


NDK_APP_OUT := obj/$(COCOS_CONFIG)
