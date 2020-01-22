MODULE_PATHS:=$(shell find . -name '*.tf' -exec dirname '{}' \; | sort -u)
MODULE_DOC_PATHS:=$(shell find . -name README.md -exec grep -qF '<!-- bin/docs -->' '{}' \; -print | sort)

all : $(MODULE_PATHS) $(MODULE_DOC_PATHS)

clean :
	rm -f tools/bin/docs

$(MODULE_PATHS) :
	terraform fmt $@

$(MODULE_DOC_PATHS) : tools/bin/docs tools/bin/update-docs
	tools/bin/update-docs $@

build : tools/bin/docs

tools/bin/docs : tools/docs/main.go tools/docs/go.mod tools/docs/go.sum
	cd tools/docs && go build -o ../bin/docs

.PHONY : all clean build $(MODULE_PATHS) $(MODULE_DOC_PATHS)
