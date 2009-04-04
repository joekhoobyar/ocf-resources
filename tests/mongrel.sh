#!/bin/sh
#
# Mongrel OCF resource agent tests.
#
# Author:		Joe Khoobyar <joe@ankhcraft.com>
# License:	GNU General Public License (GPL) version 2
# Copyright (c) 2009 All Rights Reserved
#

rm -rf /tmp/mongrel-test
echo "Generating a test Rails app in /tmp/mongrel-test..."
rails /tmp/mongrel-test -d sqlite3 2>/dev/null >/dev/null
cp $(dirname $0)/config/mongrel.yml /tmp/mongrel-test/config/mongrel.yml

ocf-tester -n mongrel-test \
	-o mongrel=$(which mongrel_rails) \
	-o config=/tmp/mongrel-test/config/mongrel.yml \
	-o monitor_url=http://localhost:8088/ \
	$(dirname $0)/../joekhoobyar/Mongrel
RETVAL=$?

rm -f /tmp/mongrel.{log,pid}
rm -rf /tmp/mongrel-test

exit $RETVAL
