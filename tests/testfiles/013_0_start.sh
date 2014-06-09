#!/bin/bash

clean_nf
install_testdata
$FW_ADMIN --start core
$FW_ADMIN -s | grep "\[fw up\]" || exit 1
