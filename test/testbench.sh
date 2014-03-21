#!/bin/bash

if [ `id -u` -ne 0 ]
then
	echo "W: Not Root!"
	exit 0
fi

MKTEMP=$( which mktemp )
if [ ! -x "$MKTEMP" ] ; then
	echo "E: No mktemp found."
	exit 1
fi

TMPFILE=$( $MKTEMP )
if [ ! -w "$TMPFILE" ] ; then
	echo "E: Unable to create tmp file with mktemp."
	exit 1
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
echo ""
echo "I: Testing datafiles"
VALID="www.google.es www.facebook.com github.com 2a00:9ac0:c1ca:27::150 150.214.4.150 192.168.1.1 fe00::1 ::1 127.0.0.1"
# Those are valid
for i in $VALID
do
	echo -n "."
	fw-admin -a $i 1>&2 || { fail=1 ; echo "" ; echo "*Error add variable*" ; }
	fw-admin -i $i 1>&2 || { fail=1 ; echo "" ; echo "*Error search varible*" ; }
	fw-admin -d $i 1>&2 <<END
y
END
	[ $? -ne 0 ] && { fail=1 ; echo "" ; echo "*fw-admin -d fail*" ; } 
	fw-admin -a $i 1>&2 || { fail=1 ; echo "" ; echo "*Error add variable*" ; }

done

echo -n "."
fw-admin --check-datafiles >&2 || { fail=1 ; echo "" ; echo "*Error check datafiles*" ; }

echo "."
fw-admin -r || { fail=1 ; echo "*Error reload variables*" ; }

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
fw-admin -s | grep  "Declared variables:" >&2 || { fail=1 ; echo "" ; echo "*Error fw-admin -s (Not show varibles)*" ; }
echo -n "."
fw-admin -s | egrep "\[fw up\]"\|"\[fw down\]" >&2 || { fail=1 ; echo "" ; echo "*Error fw-admin -s (Not show fw up | fw down)*" ; }

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
fw-admin --start core >&2 || { fail=1 ; echo "" ; echo "*Init or reload rules fail*" ; }
echo -n "."
fw-admin -s | grep "\[fw up\]" >&2 || { fail=1 ; echo "" ; echo "*Not show fw up on fw-admin -s*" ; }
echo -n "."
fw-admin --ipset-reload >&2 && { fail=1 ; echo "" ; echo "*This command not should run*" ; }
echo -n "."
fw-admin --stop core >&2 || { fail=1 ; echo "" ; echo "*Stop rules fail*" ; }
echo -n "."
fw-admin --start ./rules/core >&2 || { fail=1 ; echo "" ; echo "*Fail start ./rules/core*" ; }
echo -n "."
fw-admin --start ./rules/vlan_1 >&2 || { fail=1 ; echo "" ; echo "*Fail start ./rules/vlan_1*" ; }
echo -n "."
fw-admin --start ./rules/sets >&2 || { fail=1 ; echo "" ; echo "*Fail start ./rules/sets*" ; }

echo -n "."
fw-admin --start vlan_2 >&2 || { fail=1 ; echo "" ; echo "*Fail start vlan_2*" ; }

echo -n "."
fw-admin --start vlan_1 >&2 || { fail=1 ; echo "" ; echo "*Fail start vlan_1*" ; }

# void1 must appear in both
echo -n "."
iptables-save | grep void1 >&2 || { fail=1 ; echo "" ; echo "*Rule creating ipv4 fail 1*" ; }
echo -n "."
ip6tables-save | grep void1 >&2 || { fail=1 ; echo "" ; echo "*Rule creating ipv6 fail 1*" ; }
# void2 must appear just in ipv4
echo -n "."
iptables-save | grep void2 >&2 || { fail=1 ; echo "" ; echo "*Rule creating ipv4 fail 2*" ; }
echo -n "."
ip6tables-save | grep void2 >&2 && { fail=1 ; echo "" ; echo "*Rule creating ipv6 fail 2*" ; }
# void3 must not appear
echo -n "."
iptables-save | grep void3 >&2 && { fail=1 ; echo "" ; echo "*Rule creating ipv4 fail 3*" ; }
echo -n "."
ip6tables-save | grep void3 >&2 && { fail=1 ; echo "" ; echo "*Rule creating ipv6 fail 3*" ; }
# void4 must appear just in ipv6
echo -n "."
iptables-save | grep void4 >&2 && { fail=1 ; echo "" ; echo "*Rule creating ipv4 fail 4*" ; }
echo -n "."
ip6tables-save | grep void4 >&2 || { fail=1 ; echo "" ; echo "*Rule creating ipv6 fail 4*" ; }
# void5 must not appear
echo -n "."
iptables-save | grep void5 >&2 && { fail=1 ; echo "" ; echo "*Rule creating ipv4 fail 5*" ; }
echo -n "."
ip6tables-save | grep void5 >&2 && { fail=1 ; echo "" ; echo "*Rule creating ipv6 fail 5*" ; }

# Testing FORMAT=restore
echo -n "."
sed -i s/FORMAT=script/FORMAT=restore/ /etc/fw-admin.d/fw-admin.conf
fw-admin --start ruleset >&2 || { fail=1 ; echo "" ; echo "*Reload rules fail*" ; }

echo -n "."
# In FORMAT=restore, a file must be provided
fw-admin --start >&2 && { fail=1 ;  echo "" ; echo "*Command --start /void/ fail  *" ; }

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
[ "$?" != "0" ] && { fail=1 ;  echo "" ; echo "*/etc/init.d/fw stop fail (stop now)*" ; }

# stop when already stopped should return 0
echo -n "."
/etc/init.d/fw stop >&2
[ "$?" != "0" ] && { fail=1 ; echo "" ;  echo  "*/etc/init.d/fw stop fail (Stopped)*" ; }

# status -> stopped should return 3
echo -n "."
/etc/init.d/fw status >&2
[ "$?" != "3" ] && { fail=1 ; echo "" ; echo  "*/etc/init.d/fw status fail (Stopped)*" ; }

# bad argument should return 4
echo -n "."
/etc/init.d/fw asdasd >&2
[ "$?" != "4" ] && { fail=1 ; echo "" ; echo  "*Bad argument return fail*" ; }

# success start should return 0
echo -n "."
/etc/init.d/fw start >&2
[ "$?" != "0" ] && { fail=1 ; echo "" ; echo  "*/etc/init.d/fw start fail*" ; }

# status -> started should return 0
echo -n "."
/etc/init.d/fw status >&2
[ "$?" != "0" ] && { fail=1 ; echo "" ; echo  "*/etc/init.d/fw status fail (Started)/" ; }

# if ENABLED=no, return code should be 3
echo -n "."
sed -i s/ENABLED=yes/ENABLED=no/ /etc/default/fw
/etc/init.d/fw status >&2
[ "$?" != "3" ] && { fail=1 ; echo "" ; echo  "*if ENABLED=no $?!=3*" ; }

sed -i s/ENABLED=no/ENABLED=yes/ /etc/default/fw

# test start/stop HOOKs
INST="PRE_STOP=\"{ echo pre_stop1 > $TMPFILE ; echo pre_stop2 >> $TMPFILE ; }\""
sed -i s/PRE_STOP=\"\"// /etc/default/fw
echo "$INST" >> /etc/default/fw
if ! grep "$INST" /etc/default/fw >&2 ; then
	fail=1
	echo "" 
	echo "*PRE_STOP fail*"
else
	echo -n "."
fi

INST="POST_STOP=\"{ echo post_stop1 >> $TMPFILE ; echo post_stop2 >> $TMPFILE ; }\""
sed -i s/POST_STOP=\"\"// /etc/default/fw
echo "$INST" >> /etc/default/fw
if ! grep "$INST" /etc/default/fw >&2 ; then
	fail=1
	echo "" 
	echo "*POST_STOP fail*"
else
	echo -n "."
fi

echo -n "."
/etc/init.d/fw stop >&2
[ "$?" != "0" ] && { fail=1 ; echo  "*!*" ; }

if grep "pre_stop1" $TMPFILE >&2 ; then
	echo -n "."
else
	echo "" 
	echo "*pre_stop1 fail*"
	fail=1
fi

if grep "pre_stop2" $TMPFILE >&2 ; then
	echo -n "."
else
	echo "" 
	echo "*pre_stop2 fail*"
	fail=1
fi

if grep "post_stop1" $TMPFILE >&2 ; then
	echo -n "."
else
	echo "" 
	echo "*pre_stop1 fail*"
	fail=1
fi

if grep "post_stop2" $TMPFILE >&2 ; then
	echo -n "."
else
	echo ""
	echo "*post_stop2 fail*"
	fail=1
fi

INST="PRE_START=\"{ echo pre_start1 > $TMPFILE ; echo pre_start2 >> $TMPFILE ; }\""
sed -i s/PRE_START=\"\"// /etc/default/fw
echo "$INST" >> /etc/default/fw
if ! grep "$INST" /etc/default/fw >&2 ; then
	fail=1
	echo "" 
	echo "*PRE_START fail*"
else
	echo -n "."
fi


INST="POST_START=\"{ echo post_start1 >> $TMPFILE ; echo post_start2 >> $TMPFILE ; }\""
sed -i s/POST_START=\"\"// /etc/default/fw
echo "$INST" >> /etc/default/fw
if ! grep "$INST" /etc/default/fw >&2 ; then
	fail=1
	echo "" 
	echo "*POST_START fail*"
else
	echo -n "."
fi

echo -n "."
/etc/init.d/fw start >&2
[ "$?" != "0" ] && { fail=1 ; echo  "*!*" ; }

if grep "pre_start1" $TMPFILE >&2 ; then
	echo -n "."
else
	echo "" 
	echo "*fail pre_start1*"
	fail=1
fi

if grep "pre_start2" $TMPFILE >&2 ; then
	echo -n "."
else
	echo "" 
	echo "*fail pre_start2*"
	fail=1
fi

if grep "post_start1" $TMPFILE >&2 ; then
	echo -n "."
else
	echo "" 
	echo "*fail post_start1*"
	fail=1
fi

if grep "post_start2" $TMPFILE >&2 ; then
	echo -n "."
else
	echo "" 
	echo "*fail post_start2*"
	fail=1
fi

if [ $fail -ne 0 ]
then
	echo ""
	echo "E: Errors found testing service integration"
	fail=0
fi

echo ""
rm -f $TMPFILE 2>/dev/null >/dev/null
exit 0
