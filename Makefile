
APPID=SXsYMYsnWP
APPNAME=borisapp

TIZEN_SDK_HOME=/home/boris/code/tizen-sdk
TIZEN_SDK_TOOLS=$(TIZEN_SDK_HOME)/tools
TIZEN_SDK_DATA_HOME=$(TIZEN_SDK_HOME)-data
EMULATOR_PATH=$(TIZEN_SDK_DATA_HOME)/emulator-vms/vms/TizenTestEmulator
#PATH=$(PATH):~/code/tizen-sdk/tools

VIDEO_OPTION=video=uvesafb:ywrap,720x1280-32@60
DPI_OPTION=dpi=3160
IP_OPTION=ip=10.0.2.16::10.0.2.2:255.255.255.0::eth0:none 5
VM_OPTION=vm_name=TizenTestEmulator
DEFAULT_EMULATOR_OPTIONS=--skin-args width=720 height=1280 skin.path=$(TIZEN_SDK_TOOLS)/emulator/skins/emul-general-3btn --qemu-args -drive file=$(TIZEN_SDK_DATA_HOME)/emulator-vms/vms/TizenTestEmulator/emulimg-TizenTestEmulator.x86,if=virtio,index=1 -boot c -append console=ttyS0 -serial file:$(TIZEN_SDK_DATA_HOME)/emulator-vms/vms/TizenTestEmulator/logs/emulator.klog -m 512 -M maru-x86-machine -net nic,model=virtio,macaddr=00:1A:92:0D:A3:C4 -soundhw all -usb -device virtio-touchscreen-pci -vga maru -bios bios.bin -L $(TIZEN_SDK_TOOLS)/emulator/data/bios -kernel $(TIZEN_SDK_TOOLS)/emulator/data/kernel/bzImage.x86 -net user -rtc base=utc -drive file=$(TIZEN_SDK_DATA_HOME)/emulator-vms/vms/TizenTestEmulator/swap-TizenTestEmulator.img,if=virtio,index=2 -enable-gl -device virtio-esm-pci -device virtio-hwkey-pci -max-touch-point 10

EMULATOR_OPTIONS=-verbose -shell -show-kernel
EMULATOR_OPTIONS=-shell
SIMPLE_EMULATOR_OPTIONS=-system
#EMULATOR_OPTIONS="-snapshot-list"

build:
	web-build $(CURDIR)

sign:
	web-signing -profile $(APPNAME):~/code/tizen-sdk/tools/ide/conf/profiles.xml

package:
	mv $(APPNAME).wgt $(APPNAME).wgt.bak
	web-packaging -o $(APPNAME).wgt

install:
	web-install -w $(APPNAME).wgt

uninstall:
	web-uninstall -i $(APPID)

find-devices:
	$(TIZEN_SDK_TOOLS)/sdb devices

simulator:
	$(TIZEN_SDK_TOOLS)/tools/websimulator/simulator.sh

root-shell-emulator:
	$(TIZEN_SDK_TOOLS)/sdb -e root on
	$(TIZEN_SDK_TOOLS)/sdb -e shell

shell:
	$(TIZEN_SDK_TOOLS)/sdb -e shell

simple-emulator:
	$(TIZEN_SDK_TOOLS)/emulator/bin/emulator-x86 -system $(EMULATOR_PATH) $(SIMPLE_EMULATOR_OPTIONS) $(EMULATOR_OPTIONS)

emulator:
	$(TIZEN_SDK_TOOLS)/emulator/bin/emulator-x86 $(DEFAULT_EMULATOR_OPTIONS) $(EMULATOR_OPTIONS)

manage-emulators:
	java -jar $(TIZEN_SDK_TOOLS)/emulator/bin/emulator-manager.jar
	#/bin/bash $(TIZEN_SDK_TOOLS)/emulator/bin/emulator-manager

run:
	#web-run -i $(lastmod.sh $(CURDIR) 2 | tail -1 | awk '{print $9}').$(APPNAME)
	#web-run -i $1.$(APPNAME)
	web-run -i $(APPID).$(APPNAME)

ide:
	$(TIZEN_SDK_HOME)/ide/startup.sh

ORIGINAL_EMULATOR_OPTIONS=--skin-args width=720 height=1280 skin.path=$(TIZEN_SDK_TOOLS)/emulator/skins/emul-general-3btn --qemu-args -drive file=$(TIZEN_SDK_DATA_HOME)/emulator-vms/vms/TizenTestEmulator/emulimg-TizenTestEmulator.x86,if=virtio,index=1 -boot c -append console=ttyS0 video=uvesafb:ywrap,720x1280-32@60 dpi=3160 ip=10.0.2.16::10.0.2.2:255.255.255.0::eth0:none 5 vm_name=TizenTestEmulator -serial file:$(TIZEN_SDK_DATA_HOME)/emulator-vms/vms/TizenTestEmulator/logs/emulator.klog -m 512 -M maru-x86-machine -net nic,model=virtio,macaddr=00:1A:92:0D:A3:C4 -soundhw all -usb -device virtio-touchscreen-pci -vga maru -bios bios.bin -L $(TIZEN_SDK_TOOLS)/emulator/data/bios -kernel $(TIZEN_SDK_TOOLS)/emulator/data/kernel/bzImage.x86 -net user -rtc base=utc -drive file=$(TIZEN_SDK_DATA_HOME)/emulator-vms/vms/TizenTestEmulator/swap-TizenTestEmulator.img,if=virtio,index=2 -enable-gl -device virtio-esm-pci -device virtio-hwkey-pci -max-touch-point 10
