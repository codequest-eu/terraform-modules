MODULE_PATHS:=$(shell find . -name '*.tf' -exec dirname '{}' \; | sort -u)
MODULE_DOC_PATHS:=$(shell find . -name README.md -exec grep -qF '<!-- bin/docs -->' '{}' \; -print | sort)

STAGED=$(shell git diff --name-only --cached)
STAGED_MODULE_PATHS:=$(shell git diff --name-only --cached | grep '\.tf$$' | xargs -L 1 dirname | sort -u)
STAGED_MODULE_DOC_PATHS:=$(shell git diff --name-only --cached | grep -F 'README.md' | sort)

all : $(MODULE_PATHS) $(MODULE_DOC_PATHS)

staged : $(STAGED_MODULE_PATHS) $(STAGED_MODULE_DOC_PATHS)

precommit : precommit-stash staged precommit-pop
precommit-stash :
	git stash -u -k
precommit-pop :
	git stash pop
	git reset HEAD
	git add $(STAGED)

clean :
	rm bin/docs

$(MODULE_PATHS) :
	terraform fmt $@

$(MODULE_DOC_PATHS) : bin/docs bin/update-docs
	bin/update-docs $@

build : bin/docs

bin/docs : tools/docs/main.go tools/docs/go.mod tools/docs/go.sum
	cd tools/docs && go build -o ../../bin/docs

.PHONY : all staged precommit precommit-stash precommit-pop clean build $(MODULE_PATHS) $(MODULE_DOC_PATHS)
