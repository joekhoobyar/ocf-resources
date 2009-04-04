#!/bin/sh

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
