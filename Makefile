.PHONY: all lint

all_tests: lint unittest integration

help:
	@echo "Please use 'make <target>' where <target> is one of:"
	@echo "  lint			to run flake8 on all Python files"
	@echo "  unittest		to run unit tests on phys2bids"
	@echo "  integration	to run the integration test set on phys2bids"
	@echo "  all_tests		to run 'lint', 'unittest', and 'integration'"

lint:
	@flake8 phys2bids

unittest:
	@py.test --skipintegration --cov-append --cov-report term-missing --cov=phys2bids phys2bids/

integration:
	@pip install -e ".[test]"
	@pytest --log-cli-level=INFO --cov-append --cov-report term-missing --cov=phys2bids --junitxml=/tmp/cirrus-ci-build/coverage_integration_37.xml -k test_integration phys2bids/tests/test_integration.
