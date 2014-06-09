#!/bin/bash

set -e

clean_nf
install_all
format_script

$FW_ADMIN --start core
$FW_ADMIN --start vlan_1
iptables-save | grep void3 >/dev/null && exit 1
ip6tables-save | grep void3 >/dev/null && exit 1
