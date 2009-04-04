#!/bin/sh

ocf-tester -n nginx-test \
	-o nginx=$(which nginx) \
	-o config=$(dirname $0)/config/nginx.conf \
	-o log=/tmp/nginx.log \
	$(dirname $0)/../joekhoobyar/NGINX
RETVAL=$?

rm -f /tmp/nginx.log

exit $RETVAL
