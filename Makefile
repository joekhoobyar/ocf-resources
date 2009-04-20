# Makefile for ocf-resources
# http://github.com/joekhoobyar/ocf-resources
#
# Author:		Joe Khoobyar <joe@ankhcraft.com>
# License:	GNU General Public License (GPL) version 2
# Copyright (c) 2009 All Rights Reserved
#
RESOURCE_DIR = /usr/lib/ocf/resource.d
JOEK_DIR = $(RESOURCE_DIR)/joekhoobyar
JOEK_SCRIPTS = NGINX HAProxy Monit Mongrel svnserve tracd
JOEK_FUNCS = jk-shellfuncs
JOEK_RESOURCES = $(JOEK_SCRIPTS) $(JOEK_FUNCS)

all: check

joek-resources: $(addprefix joekhoobyar/, $(JOEK_RESOURCES))
	mkdir -p gen
	for i in $(JOEK_FUNCS); do cp joekhoobyar/$$i gen/.$$i; done
	for i in $(JOEK_SCRIPTS); do \
		DETECTED_COMMAND=$$(sed -ne 's@^: $${\([^=]\+\)_which=\([^}]\+\)}@:\2@p' <joekhoobyar/$$i \
		                     | xargs basename 2>/dev/null | xargs which 2>/dev/null); \
		if [ -z "$$DETECTED_COMMAND" ]; then \
			sed -e 's@\$$(dirname \$$0)/@$${OCF_ROOT:-/usr/lib/ocf}/resource.d/joekhoobyar/.@g;' <joekhoobyar/$$i >>gen/$$i; \
		else \
			sed -e 's@\$$(dirname \$$0)/@$${OCF_ROOT:-/usr/lib/ocf}/resource.d/joekhoobyar/.@g;' \
				-e 's@^: $${\([^=]\+\)_which=\([^}]\+\)}@[ -z "$$\1_which" ] \&\& \1_which="'"$$DETECTED_COMMAND"'"\n[ -z "$$\1_which" ] \&\& \1_which="\2"@g' \
				<joekhoobyar/$$i >>gen/$$i; \
		fi; \
	done

install: install-all

install-all: install-joek-resources install-heartbeat-resources

install-joek-resources: joek-resources $(JOEK_DIR) install-joek-scripts install-joek-funcs

$(JOEK_DIR): $(RESOURCE_DIR)
	mkdir -p $(JOEK_DIR)

install-joek-scripts: $(addprefix gen/, $(JOEK_SCRIPTS))
	install -m 755 -o root -g root $^ $(JOEK_DIR)

install-joek-funcs: $(addprefix gen/., $(JOEK_FUNCS))
	install -m 644 -o root -g root $^ $(JOEK_DIR)

install-heartbeat-resources: $(RESOURCE_DIR)/heartbeat
	install -m 755 -o root -g root heartbeat/* $(JOEK_DIR)
	mv $(JOEK_DIR)/README $(JOEK_DIR)/README.heartbeat-ocf-ra
	chmod 644 $(JOEK_DIR)/README.heartbeat-ocf-ra

clean:
	rm -rf gen

check:
		@-for i in tests/*.sh; do echo "Testing `basename $$i .sh`:"; echo; $$i; echo; done

