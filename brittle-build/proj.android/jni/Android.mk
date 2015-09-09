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
include ../../cocos/platform/android/Android.mk
include ../../cocos/3d/Android.mk
include ../../cocos/audio/android/Android.mk
include ../../cocos/editor-support/cocosbuilder/Android.mk
include ../../cocos/editor-support/cocostudio/Android.mk
include ../../cocos/editor-support/spine/Android.mk
include ../../cocos/network/Android.mk
include ../../cocos/ui/Android.mk
include ../../extensions/Android.mk
include ../../external/Box2D/Android.mk
include ../../external/flatbuffers/Android.mk

COCOS_LIBRARIES := \
	cocos2dx_internal_static \
	cocos2dxandroid_static \
	cocos3d_static \
	cocosdenshion_static \
	cocosbuilder_static \
	cocostudio_static \
	spine_static \
	cocos_network_static \
	cocos_ui_static \
	cocos_extension_static \
	box2d_static \
	cocos_flatbuffers_static \


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

# $(call external-copy,lib-name)
define external-copy
	$(call host-cp,$(COCOS_EXTERNAL)/$1/prebuilt/android/$@/*.a,$(COCOS_LIB_NDK_CFG)/$@/*.a)
endef

all: $(COCOS_ARCH_ABI)

$(COCOS_ARCH_ABI): $(COCOS_LIBRARIES)
	$(call host-mkdir,$(COCOS_LIB_NDK_CFG)/$@)
	$(call cocos-copy,*.a)
	$(call external-copy,chipmunk)
	$(call external-copy,curl)
	$(call external-copy,freetype2)
	$(call external-copy,jpeg)
	$(call external-copy,png)
	$(call external-copy,zlib)

	
	
#
# Clean the output directories
#

clean: $(COCOS_ARCH_ABI)-clean

$(COCOS_ARCH_ABI)-clean:
	$(call host-rm,$(COCOS_LIB_NDK_CFG)/$(subst -clean,,$@)/*.a)
		
		
#
# Appendix
# - Validate all necessary NDK undocumented macros are defined
#

ifndef LOCAL_BUILT_MODULE
$(error LOCAL_BUILT_MODULE not defined)
endif
 
ifndef host-mkdir
$(error host-mkdir not defined)
endif
 
ifndef host-cp
$(error host-cp not defined)
endif
 
ifndef host-rm
$(error host-rm not defined)
endif
		