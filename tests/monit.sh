#!/bin/sh

ocf-tester -n monit-test \
	-o monit=$(which monit) \
	-o config=$(dirname $0)/config/monitrc \
	-o log=/tmp/monit.log \
	-o state=/tmp/monit.state \
	$(dirname $0)/../joekhoobyar/monit
RETVAL=$?

rm -f /tmp/monit.{log,state}

exit $RETVAL
