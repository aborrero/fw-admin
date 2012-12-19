#!/bin/bash

if [ `id -u` -ne 0 ]
then
	echo "W: Not Root!"
	exit 0
fi

echo "##################################################################"
echo "W: Runing this testbench will break your current fw-admin system!!"
echo "W: It is intended to run while developing the code of fw-admin."
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
echo "I: Testing building and installation"

echo -n "."
debMakeVersion=$( grep ^"SOURCE_VERSION :=" ../debian/Makefile | awk -F'=' '{print $2}' | tr -d [:space:] )
srcMakeVersion=$( grep ^"VERSION :=" ../src/Makefile | awk -F'=' '{print $2}' | tr -d [:space:] )
codeVersion=$( grep -R "VERSION=" ../src/* | awk -F'=' '{print $2}' | tr -d \" | tr -d [:space:] )
debPkgVersion=$( grep ^fw-admin ../debian/changelog.Debian | head -1 | awk -F'(' '{print $2}' | awk -F')' '{print $1}' | tr -d [:space:] )
debControlVersion=$( grep ^Version: ../debian/control | awk -F' ' '{print $2}' | tr -d [:space:] )

echo debMakeVersion $debMakeVersion >&2
echo srcMakeVersion $srcMakeVersion >&2
echo codeVersion $codeVersion >&2
echo debPkgVersion $debPkgVersion >&2
echo debControlVersion $debControlVersion >&2

if [ "$codeVersion" != "$srcMakeVersion" ] || [ "$codeVersion" != "$debMakeVersion" ] || [ "$debPkgVersion" != "$debControlVersion" ]
then
	echo ""
	echo "E: Version mismatch!"
fi

echo -n "."
cd ../src
make >&2
if [ $? -ne 0 ]
then
	echo ""
	echo "E: Error building tar.gz package."
fi

echo -n "."
tar xvzf fw-admin_*.tar.gz -C / >&2
if [ $? -ne 0 ]
then
	echo ""
	echo "E: Error installing tar.gz package."
fi

echo -n "."
cd ../debian
make >&2
if [ $? -ne 0 ]
then
	echo ""
	echo "E: Error building deb package."
fi
echo -n "."
dpkg -i fw-admin_*.deb >&2
if [ $? -ne 0 ]
then
	echo ""
	echo "E: Error installing deb package."
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
	fail=0
fi

# Sets
SETS="test1 test2 test3 test4 test5 asd asdasd test123"
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
	echo "E: Errors found testing adding/deleting IPSET variables to datafiles."
	fail=0
fi

echo -n "."
fw-admin -r >&2 || fail=1
fw-admin --check-datafiles >&2 || fail=1
if [ $fail -ne 0 ]
then
	echo ""
	echo "E: Bad reload of variable values."
	fail=0
fi

###########################################################
###########################################################

echo ""
echo "I: Testing stats"
echo -n "."
fw-admin -s | grep  "Declared iptables variables:" >&2 || fail=1
echo -n "."
fw-admin -s | egrep "\[fw up\]"\|"\[fw down\]" >&2 || fail=1

if [ $fail -ne 0 ]
then
	echo ""
	echo "E: Errors found in stats function."
	fail=0
fi

###########################################################
###########################################################

echo ""
echo "I: Testing operations"
echo -n "."
fw-admin --start /dev/null 1>&2 && fail=1
echo -n "."
fw-admin --stop /dev/null 1>&2 && fail=1

cp -f data/* /var/lib/fw-admin/

cp rules/core /etc/fw-admin.d/rules/
fw-admin --start core >&2 || fail=1
fw-admin -s | grep "\[fw up\]" >&2 || fail=1
fw-admin --ipset-reload >&2 || fail=1
fw-admin --stop core >&2 || fail=1
fw-admin -s | grep "\[fw down\]" >&2 || fail=1
fw-admin --start ./rules/core >&2 || fail=1
fw-admin --start ./rules/vlan_1 >&2 || fail=1

if [ $fail -ne 0 ]
then
	echo ""
	echo "E: Errors found testing operations."
	fail=0
fi


echo ""
exit 0
