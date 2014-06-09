#!/bin/bash

DATA="www.google.com"

if ! $FW_ADMIN -a $DATA ; then
	echo "E: Unable to add $DATA"
	exit 1
fi

if ! $FW_ADMIN -i $DATA ; then
	echo "E: $DATA not stored"
	exit 1
fi

exit 0
