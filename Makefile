PREFIX ?= /usr/local

SBIN := $(PREFIX)/sbin/
LIB := $(PREFIX)/lib/fw-admin.d
CONF := $(PREFIX)/etc/fw-admin.d

.PHONY : install

install :
	# Deal with libs and bins
	install -d $(LIB)
	install src/fw-admin $(SBIN)
	install src/lib/libfw-admin* $(LIB)

	# Deal with conffiles
	install -d $(CONF)
	install src/conf/fw-admin.conf $(CONF)
	install -d $(CONF)/rules
	install src/conf/rules/* $(CONF)/rules/
