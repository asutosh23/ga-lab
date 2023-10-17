# Makefile

# Define the environment variables you want to access
CI_IMAGE_TAG := $(CI_IMAGE_TAG)
CI_COMMIT_TAG := $(CI_COMMIT_TAG)
CI_COMMIT_BRANCH := $(CI_COMMIT_BRANCH)
CI_COMMIT_REF_NAME := $(CI_COMMIT_REF_NAME)
CI_SHA_SHORT := $(CI_SHA_SHORT)

# Print the environment variables
print-env:
	@echo "CI_IMAGE_TAG: $(CI_IMAGE_TAG)"
	@echo "CI_COMMIT_TAG: $(CI_COMMIT_TAG)"
	@echo "CI_COMMIT_BRANCH: $(CI_COMMIT_BRANCH)"
	@echo "CI_COMMIT_REF_NAME: $(CI_COMMIT_REF_NAME)"
	@echo "CI_SHA_SHORT: $(CI_SHA_SHORT)"

	@echo "--------  git exec info"
	@echo "git describe: $(shell git describe --tags --exact-match 2>/dev/null)"
	@echo "git rev-parse: $(shell git rev-parse --short HEAD 2>/dev/null)"
	@echo "git symbolic-ref: $(shell git symbolic-ref -q --short HEAD 2>/dev/null)"
	@echo "--------  git exec info full"
	@echo "git describe: $(shell git describe --tags --exact-match)"
	@echo "git rev-parse: $(shell git rev-parse --short HEAD)"
	@echo "git symbolic-ref: $(shell git symbolic-ref -q --short HEAD)"

.PHONY: print-env
