all: check

check:
		@-for i in tests/*.sh; do echo "Testing `basename $$i .sh`:"; echo; $$i; echo; done

