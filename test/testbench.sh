#!/bin/sh

if [ `id -u` -ne 0 ]
then
	echo "W: Not Root!"
	exit 0
fi

debug=">/dev/null 2>&1"
if [ "$1" != "-d" ]
then
	debug=""
	echo "I: Use '-d' to set debug mode."
fi

echo "##################################################################" >&2
echo "W: Runing this testbench will break your current fw-admin system!!" >&2
read -p "Continue? [N/y] " continue
if [ -z "$continue" ] || [ $continue != y ]
then
	exit 0
fi

fail=0

###########################################################
###########################################################

echo "I: Testing datafiles"
VALID="r2d2.cica.es www.google.es www.facebook.com github.com 2a00:9ac0:c1ca:27::150 150.214.4.150 192.168.1.1 fe00::1 ::1 127.0.0.1"
INVALID="132.1244.123.21 dd::DDD:DDD::Dddd asdasd.asd.asd.asd.asd..asd"
# Those are valid
for i in $VALID
do
	echo -n "."
	fw-admin -a $i $debug || fail=1
	fw-admin -i $i $debug || fail=1
	fw-admin -d $i $debug <<END
y
END
	[ $? -ne 0 ] && fail=1
	fw-admin -a $i $debug || fail=1

done

# Those are invalid
for i in $INVALID
do
	echo -n "."
	fw-admin -a $i $debug && fail=1
	fw-admin -i $i $debug && fail=1
done

if [ $fail -ne 0 ]
then
	echo ""
	echo "E: Errors found adding IP/FQDN variables to datafiles."
	exit 1
fi

# Sets
SETS="test1 t-est2 te_st3 te.st4 te@st5"
for i in $SETS
do
	echo -n "."
	fw-admin -as $i $debug || fail=1
	fw-admin -i $i $debug || fail=1
	fw-admin -d $i $debug <<END
y
END
	[ $? -ne 0 ] && fail=1
	fw-admin -as $i $debug || fail=1
done

if [ $fail -ne 0 ]
then
	echo ""
	echo "E: Errors found adding IPSET variables to datafiles."
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
fw-admin --start /dev/null $debug && fail=1
echo -n "."
fw-admin --stop /dev/null $debug && fail=1

if [ $fail -ne 0 ]
then
	echo "E: Errors found testing operations."
	exit 1
fi


echo ""
exit 0
