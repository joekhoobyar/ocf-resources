#!/bin/sh

chmod 600 $(dirname $0)/config/monitrc

ocf-tester -n monit-test \
	-o monit=$(which monit) \
	-o config=$(dirname $0)/config/monitrc \
	-o log=/tmp/monit.log \
	-o pid=/tmp/monit.pid \
	-o state=/tmp/monit.state \
	-o interval=150 \
	$(dirname $0)/../joekhoobyar/monit
RETVAL=$?

rm -f /tmp/monit.{log,pid,state}
chmod 644 $(dirname $0)/config/monitrc

exit $RETVAL
