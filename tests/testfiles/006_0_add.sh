#!/bin/bash

DATA="192.168.1.1"

if ! fw-admin -a $DATA ; then
	echo "E: Unable to add $DATA"
	exit 1
fi

if ! fw-admin -i $DATA ; then
	echo "E: $DATA not stored"
	exit 1
fi

exit 0
