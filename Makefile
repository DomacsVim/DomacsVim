SHELL := /usr/bin/bash
dvim:
	@echo running domacsvim.
	./bin/domacsvim-cli-template.sh
style:
	@echo starting stylua.
	stylua -v .
lint:
	@echo starting luacheck.
	luacheck .
