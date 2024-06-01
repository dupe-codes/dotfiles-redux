.PHONY: run
run: ## Run the project
	@zig build run

.PHONY: test
test: ## Run project tests
	@zig build test --summary all

.PHONY: docs
docs: ## Generate documentation
	@echo "Generating documentation"

.PHONY: help
help: ## Show this help
	@grep -E '^[a-z.A-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
