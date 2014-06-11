#!/bin/bash

echo "##################################################################"
echo "W: Running this testbench will break your current fw-admin system!!"
echo "W: It is intended to run while developing the code of fw-admin."
echo "W: This script is fully tested only in a Debian Wheezy system."

help() {
	echo ""
	echo "fw-admin testbench. Summary of options:"
	echo -e "\t-d		turn on debug mode."
	echo -e "\t-y		run directly, without asking for confirmation."
	echo -e "\t-h		show this message."
}

# Option parsing
DEBUG="n"
RUN="n"
OPT=$( getopt -o hdy -n 'runtests.sh' -- "$@" )
if [ $? != 0 ] ; then echo "E: getopt failed" >&2 ; exit 1 ; fi
eval set -- "$OPT"

while true ; do
	case "$1" in
		-h) help ; exit 0 ;;
                -d) DEBUG="y" ; shift ;;
                -y) RUN="y" ; shift ;;
                --) shift ; break ;;
                *) echo "W: Invalid option $1" ; exit 1 ;;
        esac
done

if [ `id -u` -ne 0 ]
then
	echo "W: Not Root!"
	exit 0
fi

FW_ADMIN=$( which fw-admin )
if [ ! -x "$FW_ADMIN" ] ; then
	echo "E: No fw-admin binary found."
	exit 1
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

if [ "$RUN" != "y" ] ; then
	read -p "Continue? [N/y] " RUN
	if [ "$RUN" != "y" ] ; then
		exit 0
	fi
fi

if [ "$DEBUG" != "y" ] ; then
	exec 2>/dev/null
	set -x
fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Environment
clean_vars() {
	rm -rf /var/lib/fw-admin
}
export -f clean_vars

install_vars() {
	$FW_ADMIN --check-datafiles --install
}
export -f install_vars

clean_nf() {
	iptables -F
	iptables -F -t nat
	iptables -F -t mangle
	iptables -F -t raw
	iptables -X
	ip6tables -F
	ip6tables -F -t mangle
	ip6tables -F -t raw
	ip6tables -X
}
export -f clean_nf

install_testdata() {
	cp -f ${DIR}/data/* /var/lib/fw-admin/
	cp -f ${DIR}/rules/* /usr/local/etc/fw-admin.d/rules/
}
export -f install_testdata

install_all() {
	install_vars
	install_testdata
}
export -f install_all

format_script() {
	sed -i s/FORMAT=restore/FORMAT=script/ /usr/local/etc/fw-admin.d/fw-admin.conf
}
export -f format_script

format_restore() {
	sed -i s/FORMAT=script/FORMAT=restore/ /usr/local/etc/fw-admin.d/fw-admin.conf
}
export -f format_restore

# Running the tests
clean_vars
clean_nf
export FW_ADMIN
export DIR

for test in $( ls ${DIR}/testfiles ) ; do
	n=$( awk -F'_' '{print $1}' <<< "$test" )
	ret=$( awk -F'_' '{print $2}' <<< "$test" )
	name=$( awk -F'_' '{print $3}' <<< "$test" | awk -F'.' '{print $1}' )

	echo -n "Running test $test ..."
	if [ "$DEBUG" == "y" ] ; then
		bash -x ${DIR}/testfiles/${test} >&2
	else
		bash ${DIR}/testfiles/${test} >&2
	fi
	if [ "$?" != "$ret" ] ; then
		echo -e "\tFAILED"
	else
		echo -e "\tOK"
	fi
done
exit 0
