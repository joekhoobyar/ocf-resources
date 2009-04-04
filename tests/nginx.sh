#!/bin/sh
#
# NGINX OCF resource agent tests.
#
# Author:		Joe Khoobyar <joe@ankhcraft.com>
# License:	GNU General Public License (GPL) version 2
# Copyright (c) 2009 All Rights Reserved
#

mkdir -p /tmp/nginx-html &&
	touch /tmp/nginx-html/index.html

ocf-tester -n nginx-test \
	-o nginx=$(which nginx) \
	-o config=$(dirname $0)/config/nginx.conf \
	-o pid=/tmp/nginx.pid \
	-o log=/tmp/nginx.log \
	-o monitor_url=http://localhost:8088/ \
	$(dirname $0)/../joekhoobyar/NGINX
RETVAL=$?

rm -f /tmp/nginx.{log,pid}

exit $RETVAL
