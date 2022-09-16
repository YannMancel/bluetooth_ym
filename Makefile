DART?=dart
REPOSITORIES?=lib/

GREEN_COLOR=\033[32m
NO_COLOR=\033[0m

define print_color_message
	@echo "$(GREEN_COLOR)$(1)$(NO_COLOR)";
endef

##
## ---------------------------------------------------------------
## Dart
## ---------------------------------------------------------------
##

.PHONY: dependencies
dependencies: ## Update dependencies
	@$(call print_color_message,"Update dependencies")
	$(DART) pub get

.PHONY: format
format: ## Format code by default lib directory
	@$(call print_color_message,"Format code by default lib directory")
	$(DART) format $(REPOSITORIES)

.PHONY: analyze
analyze: ## Analyze Dart code of the project
	@$(call print_color_message,"Analyze Dart code of the project")
	$(DART) analyze .

.PHONY: format-analyze
format-analyze: format analyze ## Format & Analyze Dart code of the project

##
## ---------------------------------------------------------------
## Generator
## ---------------------------------------------------------------
##

.PHONY: generate-files
generate-files: ## Generate files with build_runner
	@$(call print_color_message,"Generate files with build_runner")
	$(DART) run build_runner build --delete-conflicting-outputs

#
# ----------------------------------------------------------------
# Help
# ----------------------------------------------------------------
#

.DEFAULT_GOAL := help
.PHONY: help
help:
	@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "$(GREEN_COLOR)%-30s$(NO_COLOR) %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'
