#
# Regular cron jobs for the fw-admin package
#
0 4	* * *	root	[ -x /usr/bin/fw-admin_maintenance ] && /usr/bin/fw-admin_maintenance
