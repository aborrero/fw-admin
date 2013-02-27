#!/bin/bash

if [ `id -u` -ne 0 ]
then
	echo "W: Not Root!"
	exit 0
fi

echo "##################################################################"
echo "W: Runing this testbench will break your current fw-admin system!!"
echo "W: It is intended to run while developing the code of fw-admin."
echo "W: This script is only fully tested in a Debian Wheezy system."
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
	fail=1
fi

echo -n "."
cd ../src
make >&2
if [ $? -ne 0 ]
then
	echo ""
	echo "E: Error building tar.gz package." >&2
	fail=1
fi

echo -n "."
tar xvzf fw-admin_${codeVersion}.tar.gz -C / >&2
if [ $? -ne 0 ]
then
	echo ""
	echo "E: Error installing tar.gz package." >&2
	fail=1
fi

echo -n "."
cd ../debian
make >&2
if [ $? -ne 0 ]
then
	echo ""
	echo "E: Error building deb package." >&2
	fail=1
fi
echo -n "."
dpkg -i fw-admin_${debPkgVersion}_all.deb >&2
if [ $? -ne 0 ]
then
	echo ""
	echo "E: Error installing deb package." >&2
	fail=1
fi

if [ $fail -ne 0 ] ; then
	echo ""
	echo "E: Error in testing and installation" >&2
	exit 1
fi

###########################################################
###########################################################
echo ""
echo "I: Testing datafiles"
cd ../test
VALID="r2d2.cica.es www.google.es www.facebook.com github.com 2a00:9ac0:c1ca:27::150 150.214.4.150 192.168.1.1 fe00::1 ::1 127.0.0.1"
INVALID="132.1244.123.21 dd::DDD:DDD::Dddd asdasd.asd.asd.asd.asd..asd"
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

# Those are invalid
for i in $INVALID
do
	echo -n "."
	fw-admin -a $i 1>&2 && { fail=1 ; echo "*!*" ; }
	fw-admin -i $i 1>&2 && { fail=1 ; echo "*!*" ; }
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
	fw-admin -as $i 1>&2 || { fail=1 ; echo "*!*" ; }
	fw-admin -i $i 1>&2 || { fail=1 ; echo "*!*" ; }
done

if [ $fail -ne 0 ]
then
	echo ""
	echo "E: Errors found testing adding/deleting IPSET variables to datafiles."
	fail=0
fi

echo -n "."
#fw-admin -r >&2 || { fail=1 ; echo "*!*" ; }
fw-admin --check-datafiles >&2 || { fail=1 ; echo "*!*" ; }
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
fw-admin --ipset-reload >&2 || { fail=1 ; echo "*!*" ; }
echo -n "."
fw-admin --stop core >&2 || { fail=1 ; echo "*!*" ; }
echo -n "."
fw-admin --start ./rules/core >&2 || { fail=1 ; echo "*!*" ; }
echo -n "."
fw-admin --start ./rules/vlan_1 >&2 || { fail=1 ; echo "*!*" ; }
echo -n "."
fw-admin --start ./rules/sets >&2 || { fail=1 ; echo "*!*" ; }

echo -n "."
echo "\$ASDASD" >> /etc/fw-admin.d/rules/core
fw-admin -c core >&2 && { fail=1 ; echo "*!*" ; }
echo -n "."
echo "ASDASD=\$VOID ##ignore##" >> /var/lib/fw-admin/iptables_vars_ipv6.bash
fw-admin -c core >&2 && { fail=1 ; echo "*!*" ; }
echo -n "."
echo "\${ASDASD}:80" >> /etc/fw-admin.d/rules/core
echo "ASDASD=\$VOID ##ignore##" >> /var/lib/fw-admin/iptables_vars_ipv4.bash
fw-admin -c core >&2 || { fail=1 ; echo "*!*" ; }


# VOID issues
#$IPT -A FORWARD -s $WWW_GOOGLE_COM -m state --state NEW -m comment --comment "void1" -j ACCEPT
#$IPT -A FORWARD -s $WWW_GOOGLE_COM -d $V192_168_0_1 -m state --state NEW -m comment --comment "void2" -j ACCEPT
#$IPT -A FORWARD -s $V2A00_9AC0_C1CA__1 -d $V192_168_0_1 -m state --state NEW -m comment --comment "void3" -j ACCEPT
#$IPT -A FORWARD -s $V2A00_9AC0_C1CA__1 -m state --state NEW -m comment --comment "void4" -j ACCEPT
#$IPT -A INPUT -s $VOID -m comment --comment "void5" -j ACCEPT
echo -n "."
fw-admin --start vlan_1 >&2 || { fail=1 ; echo "*!*" ; }

# void1 must appeaar in both
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

# Testing ENABLED directive in /etc/default/fw
echo ENABLED=no >> /etc/default/fw

# How many seconds to wait for the start operation. 0 means infinite.
# Values: integer >= 0 Default: 5
START_TIMEOUT="5"

# The fw-admin config file.
# Values: /absolute/path/to/file Default: /etc/fw.admin.d/fw-admin.conf
CONF_FILE=/etc/fw-admin.d/fw-admin.conf

# When doing a start operation, wich ruleset to load (secuencially)
# Its a space separated list of files, being absolute path or
# filenames in CONF_DIR as described in fw-admin.conf(5)
# Values: /absolute/path/to/file AND OR file_in_CONF_DIR
# Default: "core sets"
START_ORDER="core sets"

# The inverse of START_ORDER
# Values: /absolute/path/to/file AND OR file_in_CONF_DIR
# Default: "core"
STOP_ORDER="core"

# Here you can set some scripts that need to be run when stopping
# and starting the firewall. Names are self explanatory.
# NOTE: You will not recive any stdout or stderr of this commands
# The return code of this commands will be ignored, as they will be evaluated
# (using bash `eval') in background with '&'
# Values: a command
# Default: <empty>
PRE_START=""
POST_START=""
PRE_STOP=""
POST_STOP=""



if [ $fail -ne 0 ]
then
	echo ""
	echo "E: Errors found testing service integration"
	fail=0
fi

echo ""
exit 0
