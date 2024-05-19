.PHONY: install
install: ## Install a lua dependency to the local project, usage: make install package=package-name
	# TODO: also add the package to the .rockspec file
	luarocks install --tree lua_modules $(package)

.PHONY: run
run: ## Run the reststop tool
	# TODO: pass args to the reststop tool
	@source $(CURDIR)/.env && ./src/reststop.lua

.PHONY: format
format: ## Format lua source files
	@stylua -v src/

.PHONY: help
help: ## Show this help
	@grep -E '^[a-z.A-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
