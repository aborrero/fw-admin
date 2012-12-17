#!/bin/sh

if [ `id -u` -ne 0 ]
then
	echo "W: Not Root!"
	exit 0
fi

echo "W: Runing this testbench could break your current fw-admin system" >&2
read -p "Continue? [N/y] " continue

if [ -z "$continue" ] || [ $continue != y ]
then
	exit 0
fi


echo "I: Testing datafiles"
fail=0
counter=0

VALID="r2d2.cica.es www.google.es www.facebook.com github.com 2a00:9ac0:c1ca:27::150 150.214.4.150 192.168.1.1 fe00::1 ::1 127.0.0.1"
INVALID="132.1244.123.21 dd::DDD:DDD::Dddd asdasd.asd.asd.asd.asd..asd"

# Those are valid
for i in $VALID
do
	counter=`expr $counter + 1`
	fw-admin -a $i || fail=1
	fw-admin -i $i || fail=1
	fw-admin -d $i <<END
y
END
	[ $? -ne 0 ] && fail=1
	fw-admin -a $i || fail=1

done

# Those are invalid
for i in $INVALID
do
	fw-admin -a $i && fail=1
	fw-admin -i $i && fail=1
done

if [ $fail -ne 0 ]
then
	echo ""
	echo "E: Errors found adding IP/FQDN variables to datafiles."
	exit 1
fi


fw-admin -s | grep  "Declared iptables variables:	 $counter 	 $counter"
