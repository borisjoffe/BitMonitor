
APPID=SXsYMYsnWP
APPNAME=borisapp
TIZEN_SDK_HOME=/home/boris/code/tizen-sdk
#PATH=$(PATH):~/code/tizen-sdk/tools

build:
	web-build $(CURDIR)

sign:
	web-signing -profile $(APPNAME):~/code/tizen-sdk/tools/ide/conf/profiles.xml

package:
	web-packaging $(APPNAME).wgt

install:
	web-install -w $(APPNAME).wgt

run-emulator:
	$(TIZEN_SDK_HOME)/tools/emulator/bin/emulator-x86 --skin-args width=720 height=1280 skin.path=/home/boris/code/tizen-sdk/tools/emulator/skins/emul-general-3btn --qemu-args -drive file=/home/boris/code/tizen-sdk-data/emulator-vms/vms/TizenTestEmulator/emulimg-TizenTestEmulator.x86,if=virtio,index=1 -boot c -append console=ttyS0 video=uvesafb:ywrap,720x1280-32@60 dpi=3160 ip=10.0.2.16::10.0.2.2:255.255.255.0::eth0:none 5 vm_name=TizenTestEmulator -serial file:/home/boris/code/tizen-sdk-data/emulator-vms/vms/TizenTestEmulator/logs/emulator.klog -m 512 -M maru-x86-machine -net nic,model=virtio,macaddr=00:1A:92:0D:A3:C4 -soundhw all -usb -device virtio-touchscreen-pci -vga maru -bios bios.bin -L /home/boris/code/tizen-sdk/tools/emulator/data/bios -kernel /home/boris/code/tizen-sdk/tools/emulator/data/kernel/bzImage.x86 -net user -rtc base=utc -drive file=/home/boris/code/tizen-sdk-data/emulator-vms/vms/TizenTestEmulator/swap-TizenTestEmulator.img,if=virtio,index=2 -enable-gl -device virtio-esm-pci -device virtio-hwkey-pci -max-touch-point 10

manage-emulators:
	java -jar $(TIZEN_SDK_HOME)/tools/emulator/bin/emulator-manager.jar
	#/bin/bash $(TIZEN_SDK_HOME)/tools/emulator/bin/emulator-manager

run:
	web-run -i $(lastmod.sh . 2 | tail -1 | awk '{print $9}').$(APPNAME)
	#web-run -i $1.$(APPNAME)
	#web-run -i $(APPID).$(APPNAME)
