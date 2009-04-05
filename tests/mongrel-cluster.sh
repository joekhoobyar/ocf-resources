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
cp $(dirname $0)/config/mongrel-cluster.yml /tmp/mongrel-test/config/mongrel-cluster.yml

ocf-tester -n mongrel-test \
	-o config=/tmp/mongrel-test/config/mongrel-cluster.yml \
	-o only=8089 \
	-o monitor_url=http://localhost:8089/ \
	$(dirname $0)/../joekhoobyar/Mongrel
RETVAL=$?

rm -f /tmp/mongrel.{log,pid}
rm -rf /tmp/mongrel-test

exit $RETVAL
