.PHONY: clean kernel

SUBDIR = keyd \
	keyd-toprow-remap-cave \
	snd-intel-avs-ucm-cave \
	snd-intel-avs-tplg-cave

all: $(SUBDIR)

kernel:
	$(MAKE) -C kernel
	mv kernel/*.deb .
#	$(MAKE) -C kernel clean	

.PHONY: $(SUBDIR)
$(SUBDIR):
	$(MAKE) -C $@
	$(MAKE) -C $@ clean
	mv $@/*.deb .

clean:
	rm -rf *.deb

