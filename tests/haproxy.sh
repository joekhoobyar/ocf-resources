#!/bin/sh
#
# HAProxy OCF resource agent tests.
#
# Author:		Joe Khoobyar <joe@ankhcraft.com>
# License:	GNU General Public License (GPL) version 2
# Copyright (c) 2009 All Rights Reserved
#

ocf-tester -n haproxy-test \
	-o haproxy=$(which haproxy) \
	-o config=$(dirname $0)/config/haproxy.conf \
	-o pid=/tmp/haproxy.pid \
	-o log=/tmp/haproxy.log \
	-o monitor_url=http://localhost:3128/status \
	$(dirname $0)/../joekhoobyar/HAProxy
RETVAL=$?

rm -f /tmp/haproxy.{log,pid}

exit $RETVAL
