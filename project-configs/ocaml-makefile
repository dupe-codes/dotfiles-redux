.PHONY: setup
setup:
	opam switch create . 5.1.0 --no-install
	opam install -y dune utop ocamlformat=0.26.1 ocaml-lsp-server

.PHONY: deps
deps:
	dune build
	opam install . -y --deps-only --with-test

