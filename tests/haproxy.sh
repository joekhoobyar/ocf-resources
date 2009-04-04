#!/bin/sh

ocf-tester -n haproxy-test \
	-o haproxy=$(which haproxy) \
	-o config=$(dirname $0)/config/haproxy.conf \
	-o pid=/tmp/haproxy.pid \
	-o log=/tmp/haproxy.log \
	$(dirname $0)/../joekhoobyar/HAProxy
RETVAL=$?

rm -f /tmp/haproxy.log

exit $RETVAL
