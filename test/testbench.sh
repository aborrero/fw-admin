#!/bin/bash

if [ `id -u` -ne 0 ]
then
	echo "W: Not Root!"
	exit 0
fi

echo "##################################################################"
echo "W: Runing this testbench will break your current fw-admin system!!"
read -p "Continue? [N/y] " continue
if [ -z "$continue" ] || [ $continue != y ]
then
	exit 0
fi

if [ "$1" != "-d" ]
then
	echo "I: Use '-d' to set debug mode."
	exec 2>/dev/null
fi

fail=0

###########################################################
###########################################################
echo "I: Testing building"
echo -n "."
cd ../src
make >&2
if [ $? -ne 0 ]
then
	echo ""
	echo "E: Error building tar.gz package."
	exit 1
fi
echo -n "."
cd ../debian
make >&2
if [ $? -ne 0 ]
then
	echo ""
	echo "E: Error building deb package."
	exit 1
fi

###########################################################
###########################################################
echo ""
echo "I: Testing datafiles"
VALID="r2d2.cica.es www.google.es www.facebook.com github.com 2a00:9ac0:c1ca:27::150 150.214.4.150 192.168.1.1 fe00::1 ::1 127.0.0.1"
INVALID="132.1244.123.21 dd::DDD:DDD::Dddd asdasd.asd.asd.asd.asd..asd"
# Those are valid
for i in $VALID
do
	echo -n "."
	fw-admin -a $i 1>&2 || fail=1
	fw-admin -i $i 1>&2 || fail=1
	fw-admin -d $i 1>&2 <<END
y
END
	[ $? -ne 0 ] && fail=1
	fw-admin -a $i 1>&2 || fail=1

done

# Those are invalid
for i in $INVALID
do
	echo -n "."
	fw-admin -a $i 1>&2 && fail=1
	fw-admin -i $i 1>&2 && fail=1
done

if [ $fail -ne 0 ]
then
	echo ""
	echo "E: Errors found adding IP/FQDN variables to datafiles."
	exit 1
fi

# Sets
SETS="test1 test2 test3 test4 test5"
for i in $SETS
do
	echo -n "."
	fw-admin -d $i 1>&2 <<END
y
END
	fw-admin -as $i 1>&2 || fail=1
	fw-admin -i $i 1>&2 || fail=1
done

if [ $fail -ne 0 ]
then
	echo ""
	echo "E: Errors found teste adding/deleting IPSET variables to datafiles."
	exit 1
fi

###########################################################
###########################################################

echo ""
echo "I: Testing stats"
echo -n "."
fw-admin -s | grep  "Declared iptables variables:" >/dev/null || fail=1
echo -n "."
fw-admin -s | egrep "fw up"\|"fw down" >/dev/null || fail=1

if [ $fail -ne 0 ]
then
	echo ""
	echo "E: Errors found in stats function."
	exit 1
fi

###########################################################
###########################################################

echo ""
echo "I: Testing operations"
echo -n "."
fw-admin --start /dev/null 1>&2 && fail=1
echo -n "."
fw-admin --stop /dev/null 1>&2 && fail=1

if [ $fail -ne 0 ]
then
	echo "E: Errors found testing operations."
	exit 1
fi


echo ""
exit 0
