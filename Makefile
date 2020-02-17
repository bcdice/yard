all: pull yard commit

.PHONY: init pull yard commit

init:
	git submodule init
	git submodule update
	cd bcdice/src && bundle install

pull:
	git submodule foreach git pull origin master

yard:
	cd bcdice/src && bundle exec rake yard
	rm -Rf docs/
	mv bcdice/src/doc docs
	echo "yard.bcdice.org" > docs/CNAME

commit:
	git add bcdice docs
	git commit -m "Generate document at $(shell cd bcdice && git rev-parse --short HEAD)"
