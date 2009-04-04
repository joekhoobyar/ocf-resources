RESOURCE_DIR = /usr/lib/ocf/resource.d

all: check

joekhoobyar-resources: $(RESOURCE_DIR)
	mkdir -p gen
	for i in joekhoobyar/*; do sed -ne 's@\$$(dirname \$$0)@'$(RESOURCE_DIR)'/joekhoobyar/@p' <$$i >>gen/`basename $$i`; done

install: install-all

install-all: install-joekhoobyar-resources install-heartbeat-resources

install-joekhoobyar-resources: joekhoobyar-resources
	mkdir $(RESOURCE_DIR)/joekhoobyar
	install -m 755 -o root -g root joekhoobyar/* $(RESOURCE_DIR)/joekhoobyar

install-heartbeat-resources: $(RESOURCE_DIR)/heartbeat
	cp -dup heartbeat/* $(RESOURCE_DIR)/heartbeat

clean:
	rm -rf gen

check:
		@-for i in tests/*.sh; do echo "Testing `basename $$i .sh`:"; echo; $$i; echo; done

