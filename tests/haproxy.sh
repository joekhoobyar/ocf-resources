#!/bin/sh

ocf-tester -n haproxy-test -o haproxy=$(which haproxy) -o config=$(dirname $0)/config/haproxy.conf $(dirname $0)/../joekhoobyar/HAProxy
