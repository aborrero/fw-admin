DESTDIR ?= /usr/local
PREFIX ?= $(DESTDIR)

SBIN := $(PREFIX)/sbin/
LIB := $(PREFIX)/lib/fw-admin.d
CONF := $(PREFIX)/etc/fw-admin.d

.PHONY: build install

build :

install :
	# Deal with libs and bins
	install -d $(SBIN)
	install src/fw-admin $(SBIN)
	install -d $(LIB)
	install src/lib/libfw-admin* $(LIB)

	# Deal with conffiles
	install -d $(CONF)
	install -m 0644 conf/fw-admin.conf $(CONF)
	install -d $(CONF)/rules
	install conf/rules/* $(CONF)/rules/
