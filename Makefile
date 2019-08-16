ROOT_DIR=$(shell pwd)
# Tasks

init: env install

env:
	cd $(ROOT_DIR)
	git submodule update --init --recursive --remote
	pip install --upgrade pip
	cd ScoutSuite
	git checkout develop
	pip install -r ./requirements.txt
	cd $(ROOT_DIR)
	cd boto3
	git checkout develop
	cd $(ROOT_DIR)
	cd botocore
	git checkout develop
	cd $(ROOT_DIR)

install:
	pip uninstall boto3 -y
	pip uninstall botocore -y
	cd $(ROOT_DIR)
	cd boto3 && python setup.py install
	cd $(ROOT_DIR)
	cd botocore && python setup.py install

update_root:
	git submodule foreach git push origin develop
	git submodule foreach git checkout develop

tasks:
	@echo "	---------------------------------------"
	@echo "	Manage API rate manager dependent projects:"
	@echo "	---------------------------------------"
	@echo "	init: Initialise the development environment:"
	@echo "		Update pip and install ScoutSuite dependencies."
	@echo "		Local installation of boto3 and botocore."
	@echo "	install: Install the boto components locally."
	@echo "	tasks: Display this list of tasks."
	@echo "	test: Run the unit tests. Expects valid AWS creds in your environment variables."
	@echo "	update_root:	Update the snapshot in the root project (botorate)."
	@echo "			Be sure to have committed each sub repo first..."
	@echo "	---------------------------------------"

test:
	python $(ROOT_DIR)/botocore/tests/unit/test_rate_mgr.py
	python $(ROOT_DIR)/botocore/tests/unit/test_rate_mgr_integration.py
