#!/bin/bash

set -e

clean_nf
install_all
format_script

$FW_ADMIN --start core
$FW_ADMIN --start vlan_1
if iptables-save | grep void5 >/dev/null ; then
	exit 1
fi
if ip6tables-save | grep void5 >/dev/null ; then
	exit 1
fi
