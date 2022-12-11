.PHONY: build
build:
	git submodule update --recursive --init
	nix build .?submodules=1

.PHONY: start
start:
	bash ./result/bin/hello

