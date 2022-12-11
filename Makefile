.PHONY: dev-build
dev-build:
	bash build.sh

.PHONY: build
build:
	nix build

.PHONY: start
start:
	bash ./result/bin/hello

.PHONY: develop
develop:
	bash develop.sh
