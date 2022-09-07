SHELL := /bin/bash

help:
	@echo ''
	@echo 'Usage: make [TARGET]'
	@echo 'Targets:'
	@echo '  fmt       Format all terraform files'
	@echo '  val       Basic terraform sanity check'
	@echo '  lint      Lint check Terraform'
	@echo ''

fmt:
	terraform fmt -recursive .

val:
	terraform validate

lint:
ifeq ($(OS), darwin)
	@FAIL=`terraform fmt -write=false | xargs -n 1 printf '\t- %s\n'`; \
	[ -z "$$FAIL" ] || (echo "Terraform configuration needs linting. Run 'terraform fmt'"; echo $$FAIL; exit 1)
else
	@FAIL=`terraform fmt -write=false | xargs --no-run-if-empty -n 1 printf '\t- %s\n'`; \
	[ -z "$$FAIL" ] || (echo "Terraform configuration needs linting. Run 'terraform fmt'"; echo $$FAIL; exit 1)
endif

