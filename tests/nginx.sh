#!/bin/sh

ocf-tester -n nginx-test -o nginx=$(which nginx) -o config=$(dirname $0)/config/nginx.conf $(dirname $0)/../joekhoobyar/NGINX
