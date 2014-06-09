#!/bin/bash

$FW_ADMIN -s | egrep "\[fw up\]"\|"\[fw down\]" >/dev/null || exit 1
