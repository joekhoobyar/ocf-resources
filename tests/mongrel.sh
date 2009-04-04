#!/bin/sh
#
# Monit OCF resource agent tests.
#
# Author:		Joe Khoobyar <joe@ankhcraft.com>
# License:	GNU General Public License (GPL) version 2
# Copyright (c) 2009 All Rights Reserved
#

ocf-tester -n mongrel-test \
	-o mongrel=$(which mongrel_rails) \
	-o config=$(dirname $0)/config/mongrel.yml \
	-o pid=/tmp/mongrel.pid \
	-o log=/tmp/mongrel.log \
	-o monitor_url=http://localhost:8088/ \
	$(dirname $0)/../joekhoobyar/Mongrel
RETVAL=$?

rm -f /tmp/mongrel.{log,pid}

exit $RETVAL
