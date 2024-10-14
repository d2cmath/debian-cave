.PHONY: all clean clean-all

GITSRC=https://github.com/WeirdTreeThing/cros-keyboard-map.git
VERSION=0.0.1-1
REV=b2e6936

PATCH=$(wildcard patch/*.patch)

ARCH?=amd64
SUBARCH?=chrultrabook

PKGNAME=keyd-toprow-remap-$(SUBARCH)-cave-$(VERSION)_$(ARCH)

all: $(PATCH)
	$(MAKE) -C source all
	fakeroot $(MAKE) DESTDIR=../$(PKGNAME) -C source install
		
	sed -e 's#@ARCH@#$(ARCH)#' debian/control > control

	install -Dm644 control $(PKGNAME)/DEBIAN/control
	install -Dm644 debian/copyright $(PKGNAME)/DEBIAN/copyright

	rm control
	dpkg -b $(PKGNAME)

.PHONY: $(PATCH)
$(PATCH): source
	patch -p1 -d source < $@

source:
	git clone $(GITSRC) source	
	git -C source checkout $(REV)

clean:
	rm -rf source $(PKGNAME)

clean-all: clean
	rm -rf *.deb

