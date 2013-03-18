#!/bin/bash

if [ `id -u` -ne 0 ]
then
	echo "W: Not Root!"
	exit 0
fi

echo "##################################################################"
echo "W: Running this testbench will break your current fw-admin system!!"
echo "W: It is intended to run while developing the code of fw-admin."
echo "W: This script is fully tested only in a Debian Wheezy system."
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
cd ..
make install >&2
if [ $? -ne 0 ]
then
	echo ""
	echo "E: Error building and installing tar.gz package." >&2
	fail=1
fi
cd test

if [ $fail -ne 0 ] ; then
	echo ""
	echo "E: Error in testing and installation" >&2
	exit 1
fi

###########################################################
###########################################################
echo ""
echo "I: Testing datafiles"
<<<<<<< HEAD
cd ../test
VALID="r2d2.cica.es www.google.es www.facebook.com github.com 2a00:9ac0:c1ca:27::150 150.214.4.150 192.168.1.1 fe00::1 ::1 127.0.0.1"
=======
VALID="www.google.es www.facebook.com github.com 2a00:9ac0:c1ca:27::150 150.214.4.150 192.168.1.1 fe00::1 ::1 127.0.0.1"
>>>>>>> master
# Those are valid
for i in $VALID
do
	echo -n "."
	fw-admin -a $i 1>&2 || { fail=1 ; echo "*!*" ; }
	fw-admin -i $i 1>&2 || { fail=1 ; echo "*!*" ; }
	fw-admin -d $i 1>&2 <<END
y
END
	[ $? -ne 0 ] && { fail=1 ; echo "*!*" ; }
	fw-admin -a $i 1>&2 || { fail=1 ; echo "*!*" ; }

done

echo -n "."
fw-admin --check-datafiles >&2 || { fail=1 ; echo "*!*" ; }

echo "."
fw-admin -r || { fail=1 ; echo "*!*" ; }

if [ $fail -ne 0 ]
then
	echo ""
	echo "E: Errors found adding variables to datafiles."
	fail=0
fi


###########################################################
###########################################################

echo ""
echo "I: Testing stats"
echo -n "."
fw-admin -s | grep  "Declared iptables variables:" >&2 || { fail=1 ; echo "*!*" ; }
echo -n "."
fw-admin -s | egrep "\[fw up\]"\|"\[fw down\]" >&2 || { fail=1 ; echo "*!*" ; }

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
cp -f data/* /var/lib/fw-admin/
cp -f rules/* /etc/fw-admin.d/rules/

echo -n "."
fw-admin --start core >&2 || { fail=1 ; echo "*!*" ; }
echo -n "."
fw-admin -s | grep "\[fw up\]" >&2 || { fail=1 ; echo "*!*" ; }
echo -n "."
fw-admin --ipset-reload >&2 && { fail=1 ; echo "*!*" ; }
echo -n "."
fw-admin --stop core >&2 || { fail=1 ; echo "*!*" ; }
echo -n "."
fw-admin --start ./rules/core >&2 || { fail=1 ; echo "*!*" ; }
echo -n "."
fw-admin --start ./rules/vlan_1 >&2 || { fail=1 ; echo "*!*" ; }
echo -n "."
fw-admin --start ./rules/sets >&2 || { fail=1 ; echo "*!*" ; }

echo -n "."
fw-admin --start vlan_2 >&2 || { fail=1 ; echo "*!*" ; }

echo -n "."
fw-admin --start vlan_1 >&2 || { fail=1 ; echo "*!*" ; }

# void1 must appear in both
echo -n "."
iptables-save | grep void1 >&2 || { fail=1 ; echo "*!*" ; }
echo -n "."
ip6tables-save | grep void1 >&2 || { fail=1 ; echo "*!*" ; }
# void2 must appear just in ipv4
echo -n "."
iptables-save | grep void2 >&2 || { fail=1 ; echo "*!*" ; }
echo -n "."
ip6tables-save | grep void2 >&2 && { fail=1 ; echo "*!*" ; }
# void3 must not appear
echo -n "."
iptables-save | grep void3 >&2 && { fail=1 ; echo "*!*" ; }
echo -n "."
ip6tables-save | grep void3 >&2 && { fail=1 ; echo "*!*" ; }
# void4 must appear just in ipv6
echo -n "."
iptables-save | grep void4 >&2 && { fail=1 ; echo "*!*" ; }
echo -n "."
ip6tables-save | grep void4 >&2 || { fail=1 ; echo "*!*" ; }
# void5 must not appear
echo -n "."
iptables-save | grep void5 >&2 && { fail=1 ; echo "*!*" ; }
echo -n "."
ip6tables-save | grep void5 >&2 && { fail=1 ; echo "*!*" ; }

# Testing FORMAT=restore
echo -n "."
sed -i s/FORMAT=script/FORMAT=restore/ /etc/fw-admin.d/fw-admin.conf
fw-admin --start ruleset >&2 || { fail=1 ; echo "*!*" ; }

echo -n "."
# In FORMAT=restore, a file must be provided
fw-admin --start >&2 && { fail=1 ; echo "*!*" ; }

if [ $fail -ne 0 ]
then
	echo ""
	echo "E: Errors found testing operations."
	fail=0
fi

############################################################

echo ""
echo "I: Testing service integration"
echo -n "."

cp -f conf/fw-admin.conf /etc/fw-admin.d/fw-admin.conf
cp -f conf/default_fw /etc/default/fw

# Whatever state, stop now. Should return 0
/etc/init.d/fw stop >&2
[ "$?" != "0" ] && { fail=1 : echo "*!*" ; }

# stop when already stopped should return 0
echo -n "."
/etc/init.d/fw stop >&2
[ "$?" != "0" ] && { fail=1 ; echo  "*!*" ; }

# status -> stopped should return 3
echo -n "."
/etc/init.d/fw status >&2
[ "$?" != "3" ] && { fail=1 ; echo  "*!*" ; }

# bad argument should return 4
echo -n "."
/etc/init.d/fw asdasd >&2
[ "$?" != "4" ] && { fail=1 ; echo  "*!*" ; }

# success start should return 0
echo -n "."
/etc/init.d/fw start >&2
[ "$?" != "0" ] && { fail=1 ; echo  "*!*" ; }

# status -> started should return 0
echo -n "."
/etc/init.d/fw status >&2
[ "$?" != "0" ] && { fail=1 ; echo  "*!*" ; }

# if ENABLED=no, return code should be 3
echo -n "."
sed -i s/ENABLED=yes/ENABLED=no/ /etc/default/fw
/etc/init.d/fw status >&2
[ "$?" != "3" ] && { fail=1 ; echo  "*!*" ; }

sed -i s/ENABLED=no/ENABLED=yes/ /etc/default/fw


if [ $fail -ne 0 ]
then
	echo ""
	echo "E: Errors found testing service integration"
	fail=0
fi

echo ""
exit 0
