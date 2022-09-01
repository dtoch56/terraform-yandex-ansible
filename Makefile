SHELL := /bin/bash

## Basic terraform sanity check
validate:
	terraform validate

## Lint check Terraform
lint:
ifeq ($(OS), darwin)
	@FAIL=`terraform fmt -write=false | xargs -n 1 printf '\t- %s\n'`; \
	[ -z "$$FAIL" ] || (echo "Terraform configuration needs linting. Run 'terraform fmt'"; echo $$FAIL; exit 1)
else
	@FAIL=`terraform fmt -write=false | xargs --no-run-if-empty -n 1 printf '\t- %s\n'`; \
	[ -z "$$FAIL" ] || (echo "Terraform configuration needs linting. Run 'terraform fmt'"; echo $$FAIL; exit 1)
endif

