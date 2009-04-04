#!/bin/sh
#
# Monit OCF resource agent tests.
#
# Author:		Joe Khoobyar <joe@ankhcraft.com>
# License:	GNU General Public License (GPL) version 2
# Copyright (c) 2009 All Rights Reserved
#

mkdir /tmp/mongrel-html &&
	touch /tmp/mongrel-html/index.html


ocf-tester -n mongrel-test \
	-o mongrel=$(which mongrel_rails) \
	-o config=$(dirname $0)/config/mongrel.yml \
	-o monitor_url=http://localhost:8088/ \
	$(dirname $0)/../joekhoobyar/Mongrel
RETVAL=$?

rm -f /tmp/mongrel.{log,pid}
rm -rf /tmp/mongrel-html

exit $RETVAL
