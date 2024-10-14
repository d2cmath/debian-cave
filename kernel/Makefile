.PHONY: all clean

VER=6
FULLVER=$(VER).6.53

SRC=linux-$(FULLVER)
SRCURL=https://cdn.kernel.org/pub/linux/kernel/v$(VER).x/$(SRC).tar.xz

PATCH=$(wildcard patch/*.patch)

all: $(PATCH)
	cp config $(SRC)/.config

#	make -C $(SRC) tinyconfig ## for testing purpose only
	make -C $(SRC) olddefconfig
	make bindeb-pkg -C $(SRC) -j$(nproc) INSTALL_MOD_STRIP=1

.PHONY: $(PATCH)
$(PATCH): $(SRC)
	patch -p1 -d $(SRC) < $@

$(SRC):
	wget $(SRCURL)
	tar -xf $(SRC).tar.xz

clean:
	rm -rf $(SRC) $(SRC).tar.xz linux*

