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

.PHONY: print-env
