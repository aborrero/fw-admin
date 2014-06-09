#!/bin/bash

set -e

clean_nf
install_all
format_script

$FW_ADMIN --start core
$FW_ADMIN --start vlan_1
iptables-save | grep void1 >/dev/null
ip6tables-save | grep void1 >/dev/null
