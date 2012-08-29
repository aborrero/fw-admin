fw-admin
========

Custom tool for admin netfilter-based firewalls in dual stack mode (IPv4 &amp;&amp; IPv6)

Features
========

Some nice features.

###Designed to easily implement a firewall in dual stack mode (IPv4 and IPv6)

Today, the way it's recommended to face IPv6 is dual stack mode.  
This mean that a single FQDN will have both A and AAAA registries.  
Using `fw-admin`, you will write each rule just once. That rule will be valid for IPv4 and IPv6 using the variable declaration system.  


###Using a variable declaration system that avoid thousand of DNS queries

You usally set your ruleset in this way:  

`$IPT -A INPUT -i $IF -s $INTERNET -d $MYSERVER -p tcp --sport 1024: --dport $SSH_PORT -j ACCEPT`  

Using `fw-admin`, you will have a handy way of manage thousands of variables like `$MYSERVER`, with full support for FQDN variable declarations.

IMPORTANT NOTE:

Current development version of `fw-admin` include support for abstraction at ruleset in `iptables-save` format. But this is still quite new.

The main idea is that `fw-admin` being able to parse a ruleset like this:

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


###Full support for all iptables/ip6tables/ipset commands.

The netfilter base isn't modified. So you still could design your netfilter system as you like, i.e. declaring other chains, etc...


###Support for massive rule sets.

`fw-admin` is designed to work with tons of thousand of rules. There are some nice progress bars, so you don't get bored when reloading the firewall.

###Syntax check and variable checks.

When loading a ruleset, `fw-admin` will perform a complete syntax and variable check, so most human mistakes are avoided.  
Also, when loading rulesets, `fw-admin` will warn you about what rule have problems with iptables.


###Easy to revert. Easy to customize.

Migrate to or from `fw-admin` it's easy, because all shell-like organization in rulesets are allways preserved.

Also, `fw-admin` is just a complex bash script, so you can modify it to fit your environment or requisites.


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

2. Having a working directory with your ruleset, separed by vlans/subnets or whatever you like:

		/var/local/fw.d/rules/core
		/var/local/fw.d/rules/sets
		/var/local/fw.d/rules/sets_rules
		/var/local/fw.d/rules/vlan_1
		/var/local/fw.d/rules/vlan_2
		/var/local/fw.d/rules/vlan_3

	I this example, a `core` file is used for building all custom chains, a `set` file is used to declare all sets, and all others files are pure rule declaration zone.  

3. Tunning global variables

`fw-admin` have some global variables to help you customize your experiencie: working directories, company domain, etc..



More to come
============

Expect more changes in the future, this is only the first approach.
