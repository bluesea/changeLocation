THEOS_DEVICE_IP = 192.168.0.129
ARCHS = armv7 arm64
TARGET = iphone:latest:9.3
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = fenshare
fenshare_FILES = Tweak.xm
fenshare_FRAMEWORKS = UIKit,CoreLocation

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 FaciShare"
