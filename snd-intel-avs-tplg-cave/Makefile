.PHONY: all clean clean-all

VERSION=0.0.1-1
GITAVSDK=https://github.com/thesofproject/avsdk.git
GITAVSTPLG=https://github.com/thesofproject/avs-topology-xml.git
GITLINUXFW=https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/plain/intel/avs/skl/dsp_basefw.bin

ARCH?=amd64
SUBARCH?=chrultrabook

PKGNAME=snd-intel-avs-tplg-$(SUBARCH)-cave-$(VERSION)_$(ARCH)
PKGNOSPKERNAME=snd-intel-avs-tplg-nospker-$(SUBARCH)-cave-$(VERSION)_$(ARCH)

DRIVER=avs
VENDOR=intel
SPKER=max98357a
AUDIOJ=nau8825

MPDIR=/etc/modprobe.d/
FWDIR=lib/firmware/$(VENDOR)/avs

PKGFWDIR=$(PKGNAME)/$(FWDIR)

all: $(PKGFWDIR)
	dpkg -b $(PKGNAME)
	
	cp -r $(PKGNAME) $(PKGNOSPKERNAME)
	rm -f $(PKGNOSPKERNAME)/$(FWDIR)/$(SPKER)-tplg.bin
	dpkg -b $(PKGNOSPKERNAME)

$(PKGFWDIR): $(PKGNAME) source-tplg firmware
	mkdir -p $(PKGFWDIR)
	
	install -Dm600 source-tplg/dmic/*.bin $(PKGFWDIR)/
	install -Dm600 source-tplg/hdmi/*.bin $(PKGFWDIR)/
	install -Dm600 source-tplg/hda/*.bin $(PKGFWDIR)/
	install -Dm600 source-tplg/i2s/i2s-test-tplg.bin $(PKGFWDIR)/
	install -Dm600 source-tplg/i2s/$(SPKER)-tplg.bin $(PKGFWDIR)/
	install -Dm600 source-tplg/i2s/$(AUDIOJ)-tplg.bin $(PKGFWDIR)/
	install -Dm600 dsp_basefw.bin $(PKGFWDIR)/skl/dsp_basefw.bin

$(PKGNAME):
	mkdir -p $(PKGNAME)
	
	sed -e 's#@ARCH@#$(ARCH)#' debian/control > control
	install -Dm644 control $(PKGNAME)/DEBIAN/control
	install -Dm644 debian/copyright $(PKGNAME)/DEBIAN/copyright
	rm control
	
	install -Dm644 modprobe-enable-snd-intel-avs.conf $(PKGNAME)/$(MPDIR)/enable-snd-intel-avs.conf

firmware:
	wget $(GITLINUXFW)

source-tplg: source-avsdk
	git clone $(GITAVSTPLG) source-tplg
	PATH=$(PATH) $(MAKE) -C source-tplg

source-avsdk:
	git clone $(GITAVSDK) source-avsdk
	$(MAKE) -C source-avsdk/avstplg
CURDIR:=$(dir $(realpath $(lastword $(MAKEFILE_LIST))))
PATH:=$(PATH):$(CURDIR)/source-avsdk/avstplg/build/bin/Debug/net6.0/publish

clean:
	rm -rf dsp_basefw.bin source-* $(PKGNAME) $(PKGNOSPKERNAME)

clean-all: clean
	rm -rf *.deb

