ROOT_DIR=$(shell pwd)
# Tasks
install:
	cd boto3 && python setup.py install
	cd $(ROOT_DIR)
	cd botocore && python setup.py install
	cd $(ROOT_DIR)
	cd ScoutSuite && python setup.py install

install_boto:
	cd boto3 && python setup.py install
	cd $(ROOT_DIR)
	cd botocore && python setup.py install
	cd $(ROOT_DIR)

update_root:
	git submodule foreach git push origin develop
	git submodule foreach git checkout develop

tasks:
	@echo "	---------------------------------------"
	@echo "	Manage API rate manager dependent projects:"
	@echo "	---------------------------------------"
	@echo "	install: Run a local install of all dependant projects into the virtual environment."
	@echo "	install_boto: Just install the boto components."
	@echo "	tasks: Display this list of tasks."
	@echo "	test: Run the unit tests. Expects valid AWS creds in your environment variables."
	@echo "	update_root:	Update the snapshot in the root project (botorate)."
	@echo "			Be sure to have committed each sub repo first..."
	@echo "	---------------------------------------"

test:
	python $(ROOT_DIR)/botocore/tests/unit/test_rate_mgr.py
	python $(ROOT_DIR)/botocore/tests/unit/test_rate_mgr_integration.py
