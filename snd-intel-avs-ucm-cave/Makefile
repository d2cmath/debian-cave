.PHONY: all clean clean-all

VERSION=0.0.1-1
GITUCM=https://github.com/amadeuszslawinski-intel/alsa-ucm-conf.git
GITBRANCH=aslawinx/ucms

ARCH?=amd64
SUBARCH?=chrultrabook

PKGNAME=snd-intel-avs-ucm-$(SUBARCH)-cave-$(VERSION)_$(ARCH)

DEVICE=Google-Cave-1.0
DRIVER=avs
VENDOR=Intel
DMIC=dmic
SPKER=max98357a
HDMI=hdaudioB0D2
AUDIOJ=nau8825

UCMDIR=usr/share/alsa/ucm2
DMICDIR=$(DRIVER)_$(DMIC)
SPKERDIR=$(DRIVER)_$(SPKER)
HDMIDIR=$(HDMI)
AUDIOJDIR=$(DRIVER)_$(AUDIOJ)

PKGDIR=$(PKGNAME)/$(UCMDIR)

all: $(PKGDIR)
	dpkg -b $(PKGNAME)

$(PKGDIR): $(PKGNAME) source-ucm
	mkdir -p $(PKGDIR)/$(VENDOR)/$(DRIVER)/$(DMICDIR)
	mkdir -p $(PKGDIR)/$(VENDOR)/$(DRIVER)/$(SPKERDIR)
	mkdir -p $(PKGDIR)/$(VENDOR)/$(DRIVER)/$(HDMIDIR)
	mkdir -p $(PKGDIR)/$(VENDOR)/$(DRIVER)/$(AUDIOJDIR)
	install -m644 source-ucm/ucm2/$(VENDOR)/$(DRIVER)/$(DMICDIR)/*.conf $(PKGDIR)/$(VENDOR)/$(DRIVER)/$(DMICDIR)/
	install -m644 source-ucm/ucm2/$(VENDOR)/$(DRIVER)/$(SPKERDIR)/*.conf $(PKGDIR)/$(VENDOR)/$(DRIVER)/$(SPKERDIR)/
	install -m644 source-ucm/ucm2/$(VENDOR)/$(DRIVER)/$(HDMIDIR)/*.conf $(PKGDIR)/$(VENDOR)/$(DRIVER)/$(HDMIDIR)/
	install -m644 source-ucm/ucm2/$(VENDOR)/$(DRIVER)/$(AUDIOJDIR)/$(DEVICE)*.conf $(PKGDIR)/$(VENDOR)/$(DRIVER)/$(AUDIOJDIR)/
	
	mkdir -p $(PKGDIR)/conf.d/$(DMICDIR)
	mkdir -p $(PKGDIR)/conf.d/$(SPKERDIR)
	mkdir -p $(PKGDIR)/conf.d/$(HDMIDIR)
	mkdir -p $(PKGDIR)/conf.d/$(AUDIOJDIR)
	cd $(PKGDIR)/conf.d/$(DMICDIR); \
		ln -s ../../$(VENDOR)/$(DRIVER)/$(DMICDIR)/DMIC-2ch.conf ./$(DEVICE).conf
	cd $(PKGDIR)/conf.d/$(SPKERDIR); \
		ln -s ../../$(VENDOR)/$(DRIVER)/$(SPKERDIR)/$(SPKERDIR).conf ./$(DEVICE).conf
	cd $(PKGDIR)/conf.d/$(HDMIDIR); \
		ln -s ../../$(VENDOR)/$(DRIVER)/$(HDMIDIR)/$(HDMIDIR).conf ./$(DEVICE).conf
	cd $(PKGDIR)/conf.d/$(AUDIOJDIR); \
		ln -s ../../$(VENDOR)/$(DRIVER)/$(AUDIOJDIR)/$(DEVICE).conf ./$(DEVICE).conf	

$(PKGNAME):
	mkdir -p $(PKGNAME)
	sed -e 's#@ARCH@#$(ARCH)#' debian/control > control
	install -Dm644 control $(PKGNAME)/DEBIAN/control
	install -Dm644 debian/copyright $(PKGNAME)/DEBIAN/copyright
	rm control	

source-ucm:
	git clone $(GITUCM) -b $(GITBRANCH) source-ucm	

clean:
	rm -rf source-* $(PKGNAME)

clean-all: clean
	rm -rf *.deb

