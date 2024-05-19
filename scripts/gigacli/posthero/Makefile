.PHONY: install
install: ## Install a lua dependency to the local project, usage: make install package=package-name
	luarocks install --tree lua_modules $(package)

.PHONY: run
run: ## Run the posthero tool
	@echo "Running the application..."
	@source $(CURDIR)/.env && ./src/posthero.lua

.PHONY: help
help: ## Show this help
	@grep -E '^[a-z.A-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
