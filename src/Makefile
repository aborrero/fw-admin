VERSION := 0.8
TAR := fw-admin_$(VERSION).tar.gz
INSTALL_PREFIX := /
ROOT := build


.PHONY : clean install

$(TAR) : clean

	# Deal with libs and bins
	mkdir -p $(ROOT)/usr/sbin/
	mkdir -p $(ROOT)/usr/lib/fw-admin.d/
	cp fw-admin $(ROOT)/usr/sbin/
	cp lib/libfw-admin* $(ROOT)/usr/lib/fw-admin.d/

	# Deal with conffiles
	mkdir -p $(ROOT)/etc/fw-admin.d/
	mkdir -p $(ROOT)/etc/init.d/
	cp conf/fw $(ROOT)/etc/init.d/
	cp conf/fw-admin.conf $(ROOT)/etc/fw-admin.d/

	# Deal with man pages
	mkdir -p $(ROOT)/usr/share/man/man5
	mkdir -p $(ROOT)/usr/share/man/man8
	cp man/fw-admin.conf.5 $(ROOT)/usr/share/man/man5/
	gzip -9 $(ROOT)/usr/share/man/man5/fw-admin.conf.5
	cp man/fw-admin.8 $(ROOT)/usr/share/man/man8/
	gzip -9 $(ROOT)/usr/share/man/man8/fw-admin.8

	# Finishing
	cd build && tar czf $(TAR) * --exclude-vcs && mv $(TAR) ../ && cd ..
	rm -rf build

clean :
	rm -rf build
	rm -f $(TAR)

install : $(TAR)
	tar xzf $(TAR) -C $(INSTALL_PREFIX)
