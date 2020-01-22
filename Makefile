MODULE_PATHS:=$(shell find . -name '*.tf' -exec dirname '{}' \; | sort -u)
MODULE_DOC_PATHS:=$(shell find . -name README.md -exec grep -qF '<!-- bin/docs -->' '{}' \; -print | sort)

STAGED_MODULE_PATHS:=$(shell git diff --name-only --cached | grep '\.tf$$' | xargs -L 1 dirname | sort -u)
STAGED_MODULE_DOC_PATHS:=$(shell git diff --name-only --cached | grep '\.tf$$' | xargs -L 1 dirname | sort -u | xargs -I '{}' -L 1 echo '{}/README.md')
STAGED_DOC_PATHS:=$(shell git diff --name-only --cached | grep -F 'README.md')

all : $(MODULE_PATHS) $(MODULE_DOC_PATHS)

staged : $(STAGED_MODULE_PATHS) $(STAGED_MODULE_DOC_PATHS) $(STAGED_DOC_PATHS)

precommit : precommit-stash staged precommit-pop
precommit-stash :
	git stash -u -k -q
precommit-pop :
	git stash pop -q
	git reset HEAD -q
	git add $(STAGED_MODULE_PATHS) $(STAGED_MODULE_DOC_PATHS) $(STAGED_DOC_PATHS)

clean :
	rm tools/bin/docs

$(MODULE_PATHS) :
	terraform fmt $@

$(MODULE_DOC_PATHS) : tools/bin/docs tools/bin/update-docs
	tools/bin/update-docs $@

build : tools/bin/docs

tools/bin/docs : tools/docs/main.go tools/docs/go.mod tools/docs/go.sum
	cd tools/docs && go build -o ../bin/docs

.PHONY : all staged precommit precommit-stash precommit-pop clean build $(MODULE_PATHS) $(MODULE_DOC_PATHS)
