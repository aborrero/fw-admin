#!/bin/bash

set -e

clean_nf
install_testdata

$FW_ADMIN --start ${DIR}/rules/core
$FW_ADMIN --start ${DIR}/rules/vlan_1
