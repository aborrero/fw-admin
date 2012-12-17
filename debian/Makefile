SOURCE_VERSION := 0.8
PKG_VERSION := 1
VERSION := $(SOURCE_VERSION)-$(PKG_VERSION)
PKG := fw-admin_$(VERSION)_all.deb
TAR := fw-admin_$(SOURCE_VERSION).tar.gz

.PHONY : clean

$(PKG) : clean
ifneq ($(shell whoami), root)
	echo "E: Must be root"
	exit 1
endif
	# Control files
	tar czf control.tar.gz * --exclude="README*" --exclude="Makefile" --exclude="copyright" --exclude="changelog.Debian" --exclude="examples" --exclude-vcs
	mkdir -p fw-admin_$(VERSION)_all/DEBIAN
	tar xzf control.tar.gz -C fw-admin_$(VERSION)_all/DEBIAN/
	rm -f control.tar.gz

	# Source code
	cd ../src ; make ; cd ../debian
	tar xzf ../src/fw-admin_$(SOURCE_VERSION).tar.gz -C fw-admin_$(VERSION)_all/
	mkdir -p fw-admin_$(VERSION)_all/usr/share/doc/fw-admin/
	gzip -9 -c changelog.Debian > fw-admin_$(VERSION)_all/usr/share/doc/fw-admin/changelog.Debian.gz
	cp copyright fw-admin_$(VERSION)_all/usr/share/doc/fw-admin/
	cp -r examples fw-admin_$(VERSION)_all/usr/share/doc/fw-admin/

	# Building and testing
	chown -R root:root fw-admin_$(VERSION)_all/*
	dpkg-deb -b fw-admin_$(VERSION)_all
	rm -rf fw-admin_$(VERSION)_all
	lintian -i $(PKG)

clean :
ifneq ($(shell whoami), root)
	echo "E: Must be root"
	exit 1
endif
	rm -rf fw-admin_*_all
	rm -rf control.tar.gz
	rm -rf *.deb
