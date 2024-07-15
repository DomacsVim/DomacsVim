SHELL := /usr/bin/env bash

install:
	bash ./utils/setup/install.sh

uninstall:
	bash ./utils/setup/uninstaller.sh

lint:
	luacheck .

style:
	stylua --check -v .

.PHONY: install lint style uninstall
