ROOT_DIR=$(shell pwd)
# Tasks

init37: src install
init26: venv26 install26
init27: venv27 install27
init336: venv336 install336
init374: venv374 install374

venv26:
	pyenv local 2.6.9;\
	virtualenv -p /Users/bradley.atkins/.pyenv/versions/2.6.9/bin/python venv26;\
	. venv26/bin/activate;\

venv27:
	pyenv local 2.7.16;\
	virtualenv -p /Users/bradley.atkins/.pyenv/versions/2.7.16/bin/python venv27;\
	. venv27/bin/activate;\

venv336:
	pyenv local 3.3.6;\
	python -m venv venv336;\
	. venv336/bin/activate;\

venv374:
	pyenv local 3.7.4;\
	python -m venv venv374;\
	. venv374/bin/activate;\

src:
	cd $(ROOT_DIR);\
	git submodule update --init --recursive --remote;\
	pip install --upgrade pip;\
	cd ScoutSuite;\
	git checkout develop;\
	pip install -r ./requirements.txt;\
	cd $(ROOT_DIR);\
	cd boto3;\
	git checkout develop;\
	cd $(ROOT_DIR);\
	cd botocore;\
	git checkout develop;\
	cd $(ROOT_DIR);\

install26:
	. venv26/bin/activate;\
	pip install statistics;\
	pip install monotonic;\
	pip uninstall boto3 -y;\
	pip uninstall botocore -y;\
	cd $(ROOT_DIR);\
	cd boto3;\
	python setup.py install;\
	cd $(ROOT_DIR);\
	cd botocore;\
	python setup.py install;\

install27:
	. venv27/bin/activate;\
	pip install statistics;\
	pip install monotonic;\
	pip uninstall boto3 -y;\
	pip uninstall botocore -y;\
	cd $(ROOT_DIR);\
	cd boto3;\
	python setup.py install;\
	cd $(ROOT_DIR);\
	cd botocore;\
	python setup.py install;\

install336:
	. venv336/bin/activate;\
	pip install statistics;\
	pip install monotonic;\
	pip uninstall boto3 -y;\
	pip uninstall botocore -y;\
	cd $(ROOT_DIR);\
	cd boto3;\
	python setup.py install;\
	cd $(ROOT_DIR);\
	cd botocore;\
	python setup.py install;\

install374:
	. venv374/bin/activate;\
	pip install statistics;\
	pip install monotonic;\
	pip uninstall boto3 -y;\
	pip uninstall botocore -y;\
	cd $(ROOT_DIR);\
	cd boto3;\
	python setup.py install;\
	cd $(ROOT_DIR);\
	cd botocore;\
	python setup.py install;\

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
	@echo "	init26: Initialise the development environment with python 2.6.9:"
	@echo "		Update pip and install ScoutSuite dependencies."
	@echo "		Local installation of boto3 and botocore."
	@echo "	install: Install the boto components locally."
	@echo "	tasks: Display this list of tasks."
	@echo "	test: Run the unit tests. Expects valid AWS creds in your environment variables."
	@echo "	update_root:	Update the snapshot in the root project (botorate)."
	@echo "			Be sure to have committed each sub repo first..."
	@echo "	---------------------------------------"

test:
	python $(ROOT_DIR)/botocore/tests/unit/test_rate_mgr.py;\
	python $(ROOT_DIR)/botocore/tests/unit/test_rate_mgr_integration.py;\
