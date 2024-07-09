.PHONY: lint
lint:	## Run linter on gdscript files
	@echo "Running linter..."
	@gdlint ./

.PHONY: format
format:	## Run formatter on gdscript files
	@echo "Running formatter..."
	@gdformat ./

.PHONY: help
help: ## Show this help
	@grep -E '^[a-z.A-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'
