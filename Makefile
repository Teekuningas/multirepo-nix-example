.PHONY: init
init:
	git submodule update --recursive --init

.PHONY: build
build:
	nix build \
		--update-input packageA \
		--update-input packageB \
		.?submodules=1

.PHONY: start
start:
	bash ./result/bin/hello

