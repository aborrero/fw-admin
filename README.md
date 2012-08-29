fw-admin
========

Custom tool for admin netfilter-based firewalls in dual stack mode (IPv4 &amp;&amp; IPv6)

Features
========

###Designed to easily implement a firewall in dual stack mode (IPv4 and IPv6)

Today, the way it's recommended to face IPv6 is dual stack mode.  
This mean that a single FQDN will have both A and AAAA registries.  
Using `fw-admin`, you will write each rule just once. That rule will be valid for IPv4 and IPv6 using the variable declaration system.  


###Two formats for having your firewall: script or ruleset

Working with `fw-admin` it's easy because you have two ways to implement the firewall, two formats that most people use:

	· script (a shell script with rules)
	· ruleset for loading to iptables-restore

`fw-admin` can afford both methods. Continue reading for more info.

###Using a variable declaration system that avoid thousand of DNS queries

In a format like a shellscript, you usally set your ruleset in this way:  

		$IPT -A INPUT -i $IF -s $INTERNET -d $MYSERVER -p tcp --dport $SSH_PORT -j ACCEPT
		$IPT -A INPUT -o $IF -d $INTERNET -s $MYSERVER -p tcp --sport $SSH_PORT -j ACCEPT

Using `fw-admin`, you will have a handy way of manage thousands of variables like `$MYSERVER`, with full support for FQDN variable declarations.

For an iptables-restore format, `fw-admin` implements the same logic:

The main idea is that `fw-admin` being able to parse a ruleset like this (note bash-like variables):

		*nat
		:PREROUTING ACCEPT [0:0]
		:INPUT DROP [0:0]
		:OUTPUT DROP [0:0]
		:POSTROUTING ACCEPT [0:0]
		# some nat rules here
		-A POSTROUTING -j MASQUERADE
		COMMIT
		*filter
		:INPUT DROP [0:0]
		:FORWARD DROP [0:0]
		:OUTPUT DROP [0:0]
		# some customization here
		:sets_rules - [0:0]
		:myotherchain - [0:0]
		:vlan_6 - [0:0]
		-A INPUT -j sets_rules
		-A OUTPUT -j sets_rules
		-A FORWARD -j sets_rules
		# also support for ipset (family inet and family inet6)
		-A sets_rules --match-set $SET_ONE src --match-set $SET_TWO dst -j ACCEPT
		-A sets_rules -j RETURN
		-A FORWARD -i $NIC1 -o $NIC2 -j vlan_6
		# FQDNs with both A and AAAA records
		-A vlan_6 -s $R2D2_EXAMPLE_COM -d $C3PO_EXAMPLE_COM -p tcp --dport 22 -j ACCEPT
		# Also, a IPv4
		-A vlan_6 -s $v192_168_1_2 -p udp -j ACCEPT
		# Or an plain IPv6
		-A vlan_6 -d $2a00_9ac0_11__2 -j ACCEPT
		COMMIT

And then generate an equivalent ruleset valid for iptables and an equivalent ruleset valid for ip6tables.
This method is fast as hell to load a huge ruleset, and recommended if you're using >4.000 rules.


###Support for massive rule sets.

`fw-admin` is designed to work with tons of thousand of rules. There are some nice progress bars, so you don't get bored when reloading working.

###Syntax check and variable checks.

`fw-admin` is able to perform a complete syntax and variable check, so most human mistakes are avoided.

You will control all errors, so forget complex debug modes.

###Transactional-like mechanism

If you want, `fw-admin` will put some permissive rules while reloading the iptables data. That rule (or rules) will be deleted when done, so network impact is strongly minimiced.


How to implement it
===================

The ideal way of working with `fw-admin` is:  

1. Having a data directory with data-files, that contains all variables:

		/var/local/fw.d/data/iptables_vars_ipv4.bash
		/var/local/fw.d/data/iptables_vars_ipv6.bash
		/var/local/fw.d/data/ipset_vars_ipv6.bash
		/var/local/fw.d/data/ipset_vars_ipv4.bash

	A datafile is a bash file with variable declaration (note trailing coments is for reloading the value of all variables against DNS or whatever when you request it):

		R2D2_EXAMPLE_COM=192.168.2.2 #r2d2.example.com
		C3PO_EXAMPLE_COM=192.168.2.3 #c3po.example.com
		IF=eth0 ##ignore##

2. If `FORMAT=script`, having a working directory with your ruleset, separed by vlans/subnets or whatever you like:

		/var/local/fw.d/rules/core
		/var/local/fw.d/rules/sets
		/var/local/fw.d/rules/sets_rules
		/var/local/fw.d/rules/vlan_1
		/var/local/fw.d/rules/vlan_2
		/var/local/fw.d/rules/vlan_3

	I this example, a `core` file is used for building all custom chains, a `set` file is used to declare all sets, and all others files are pure rule declaration zone.  

3. If `FORMAT=restore`, having a ruleset file with all your data:

		/var/local/fw.d/rules/ruleset

4. Simple configuration: `/etc/fw-admin.conf`

	`fw-admin` have some global variables to help you customize your experiencie: working directories, company domain, etc..

	Here is the simple config file: 

		# Values:{restore|script}, Default: script
		FORMAT=script

		# Your company domain
		DOMAIN="cica.es"

		# Working dirs and data files
		WORKING_DIR="/var/local/fw.d"
		CONF_DIR="$WORKING_DIR/rules"
		DATA_DIR="$WORKING_DIR/data"
		VARS_IPV6="$DATA_DIR/iptables_vars_ipv6.bash"
		VARS_IPV4="$DATA_DIR/iptables_vars_ipv4.bash"
		VARS_IPSETV4="$DATA_DIR/ipset_vars_ipv4.bash"
		VARS_IPSETV6="$DATA_DIR/ipset_vars_ipv6.bash"

		# Some options. Values:{yes|no}
		LOG_ERROR_MESSAGES="yes"
		LOG_WARN_MESSAGES="yes"
		USE_COLORS="no"
		USE_PROGRESS_BAR="yes"

		# [...]


5. Check the `/etc/init.d/firewall` startup script.

6. Run it.



More to come
============

Expect more changes in the future, this is only the first approach.

Please comment.
