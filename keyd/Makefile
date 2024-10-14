.PHONY: all clean clean-all

GITSRC=https://github.com/rvaiya/keyd.git
VERSION=2.5.0-1
REV=393d341

PATCH=$(wildcard patch/*.patch)

ARCH?=amd64
SUBARCH?=chrultrabook

PKGNAME=keyd-$(SUBARCH)-$(VERSION)_$(ARCH)

all: $(PATCH)
	$(MAKE) -C source all
	fakeroot $(MAKE) DESTDIR=../$(PKGNAME) -C source install
		
	sed -e 's#@ARCH@#$(ARCH)#' debian/control > control

	install -Dm644 control $(PKGNAME)/DEBIAN/control
	install -Dm644 debian/copyright $(PKGNAME)/DEBIAN/copyright

	install -Dm755 debian/postinst $(PKGNAME)/DEBIAN/postinst
	install -Dm755 debian/prerm $(PKGNAME)/DEBIAN/prerm
	install -Dm755 debian/postrm $(PKGNAME)/DEBIAN/postrm

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

