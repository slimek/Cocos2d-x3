#
# Store the local path
#

COCOS_LOCAL_PATH := $(call my-dir)


#
# Build Cocos2d-x Sub-Modules
#

$(call import-add-path,../..)
$(call import-add-path,../../cocos)
$(call import-add-path,../../external)

include ../../cocos/Android.mk

COCOS_BUILT_MODULE := $(LOCAL_BUILT_MODULE)


#
# Make Output Directories
#

COCOS_LIB := ../../lib
COCOS_LIB_NDK_CFG := $(COCOS_LIB)/Android.Ndk.$(COCOS_CONFIG)
COCOS_EXTERNAL := ../../external

COCOS_ARCH_ABI := $(TARGET_ARCH_ABI)

# $(call cocos-copy,lib-filename)
define cocos-copy
  $(call host-cp,obj/$(COCOS_CONFIG)/local/$@/$1,$(COCOS_LIB_NDK_CFG)/$@/$1)
endef

all: $(COCOS_ARCH_ABI)

$(COCOS_ARCH_ABI): $(COCOS_BUILT_MODULE)
	$(call host-mkdir,$(COCOS_LIB))
	$(call host-mkdir,$(COCOS_LIB_NDK_CFG))
	$(call host-mkdir,$(COCOS_LIB_NDK_CFG)/$@)

