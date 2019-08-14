# botorate
Parent project to wrap changes to boto3, botocore and ScoutSuite to 
handle AWS rate limiting.

---

## Control

A make file is provided for managing the build and installation of the 
three sub-projects that make up this feature. You can list them by 
issuing the command `make tasks` like so:
```
make tasks
	---------------------------------------
	Manage API rate manager dependent projects:
	---------------------------------------
	install: Run a local install of all dependant projects into the virtual environment.
	install_boto: Just install the boto components.
	tasks: Display this list of tasks.
	test: Run the unit tests. Expects valid AWS creds in your environment variables.
	update_root:	Update the snapshot in the root project (botorate).
		Be sure that you have committed each sub repo first...
	---------------------------------------
```

### Local Installation

When developing you need to run the code using locally installed 
versions of the sub-projects. The supplied makefile supports installing 
either all projects or just the boto components, boto3 and botocore.

Keep in mind that when developing you need to work in each repo, while 
when you are debugging, you are stepping through the locally installed 
packages instead.

If I had a penny for every time I'd edited the local package instead of 
the repo...
