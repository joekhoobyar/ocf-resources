RESOURCE_DIR = /usr/lib/ocf/resource.d
JOEK_DIR = $(RESOURCE_DIR)/joekhoobyar
JOEK_SCRIPTS = NGINX HAProxy Monit
JOEK_FUNCS = .jk-shellfuncs
JOEK_RESOURCES = $(JOEK_SCRIPTS) $(JOEK_FUNCS)

all: check

joek-resources: $(addprefix joekhoobyar/, $(JOEK_RESOURCES))
	mkdir -p gen
	for i in $(JOEK_RESOURCES); do sed -ne 's@\$$(dirname \$$0)@'$(RESOURCE_DIR)'/joekhoobyar/@p' <joekhoobyar/$$i >>gen/$$i; done

install: install-all

install-all: install-joek-resources install-heartbeat-resources

install-joek-resources: joek-resources $(JOEK_DIR) install-joek-scripts install-joek-funcs

$(JOEK_DIR): $(RESOURCE_DIR)
	mkdir $(JOEK_DIR)

install-joek-scripts: $(addprefix gen/, $(JOEK_SCRIPTS))
	install -m 755 -o root -g root $^ $(JOEK_DIR)

install-joek-funcs: $(addprefix gen/, $(JOEK_FUNCS))
	install -m 644 -o root -g root $^ $(JOEK_DIR)

install-heartbeat-resources: $(RESOURCE_DIR)/heartbeat
	cp -dup heartbeat/* $(RESOURCE_DIR)/heartbeat

clean:
	rm -rf gen

check:
		@-for i in tests/*.sh; do echo "Testing `basename $$i .sh`:"; echo; $$i; echo; done

