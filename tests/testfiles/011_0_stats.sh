#!/bin/bash

$FW_ADMIN -s | grep "Declared variables:" >/dev/null || exit 1
