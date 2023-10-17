# Makefile

# Define the environment variables you want to access
CI_IMAGE_TAG := $(CI_IMAGE_TAG)
CI_COMMIT_TAG := $(CI_COMMIT_TAG)
CI_COMMIT_BRANCH := $(CI_COMMIT_BRANCH)
CI_COMMIT_REF_NAME := $(CI_COMMIT_REF_NAME)
CI_SHA_SHORT := $(CI_SHA_SHORT)

COMMIT_TAG ?= $(shell git describe --tags --exact-match 2>/dev/null)
ifeq ($(COMMIT_TAG),)
    COMMIT_TAG := $(CI_COMMIT_TAG)
endif
COMMIT_HASH ?= $(shell git rev-parse --short HEAD 2>/dev/null)
ifeq ($(COMMIT_HASH),)
    COMMIT_HASH := $(CI_COMMIT_SHORT_SHA)
endif
ifeq ($(COMMIT_HASH),)
    COMMIT_HASH := unknown
endif
BRANCH_REF ?= $(shell git symbolic-ref -q --short HEAD 2>/dev/null)
ifeq ($(BRANCH_REF),)
    BRANCH_REF := $(CI_COMMIT_BRANCH)
endif
ifeq ($(BRANCH_REF),)
    BRANCH_REF := $(CI_COMMIT_REF_NAME)
endif
ifeq ($(BRANCH_REF),)
    BRANCH_REF := unknown
endif
# Rules for version string:
# 1- If commit tag exists, then we use tag as version.
# 2- If not we will use v0.0.0-branch_name-short_commit_sha
ifneq ($(COMMIT_TAG),)
    VERSION := $(COMMIT_TAG)
endif
ifeq ($(VERSION),)
    VERSION := v0.0.0-$(subst /,_,$(BRANCH_REF))-$(COMMIT_HASH)
endif

DATE_FMT = +%FT%T%z
ifdef SOURCE_DATE_EPOCH
    BUILD_DATE ?= $(shell date -u -d "@$(SOURCE_DATE_EPOCH)" "$(DATE_FMT)" 2>/dev/null || date -u -r "$(SOURCE_DATE_EPOCH)" "$(DATE_FMT)" 2>/dev/null || date -u "$(DATE_FMT)")
else
    BUILD_DATE ?= $(shell date "$(DATE_FMT)")


# Print the environment variables
print-env:
	@echo "CI_IMAGE_TAG: $(CI_IMAGE_TAG)"
	@echo "CI_COMMIT_TAG: $(CI_COMMIT_TAG)"
	@echo "CI_COMMIT_BRANCH: $(CI_COMMIT_BRANCH)"
	@echo "CI_COMMIT_REF_NAME: $(CI_COMMIT_REF_NAME)"
	@echo "CI_SHA_SHORT: $(CI_SHA_SHORT)"

	@echo "-------- internal vars"
	@echo "COMMIT_TAG: ${COMMIT_TAG}"
	@echo "COMMIT_HASH: ${COMMIT_HASH}"
	@echo "BRANCH_REF: ${BRANCH_REF}"
	@echo "VERSION: ${VERSION}"
	@echo "BUILD_DATE: ${BUILD_DATE}"
	@echo "-------- git exec info"
	@echo "git describe: $(shell git describe --tags --exact-match 2>/dev/null)"
	@echo "git rev-parse: $(shell git rev-parse --short HEAD 2>/dev/null)"
	@echo "git symbolic-ref: $(shell git symbolic-ref -q --short HEAD 2>/dev/null)"
	@echo "-------- git exec info full"
	@echo "git describe: $(shell git describe --tags --exact-match)"
	@echo "git rev-parse: $(shell git rev-parse --short HEAD)"
	@echo "git symbolic-ref: $(shell git symbolic-ref -q --short HEAD)"

.PHONY: print-env
