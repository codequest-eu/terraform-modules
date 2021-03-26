MODULE_PATHS:=$(shell find . -name '*.tf' -exec dirname '{}' \; | sort -u)
MODULE_DOC_PATHS:=$(shell find . -name README.md -exec grep -qF '<!-- bin/docs -->' '{}' \; -print | sort)

all : $(MODULE_PATHS) $(MODULE_DOC_PATHS)

$(MODULE_PATHS) :
	terraform fmt $@

$(MODULE_DOC_PATHS) :
	tools/bin/update-docs $@

.PHONY : all $(MODULE_PATHS) $(MODULE_DOC_PATHS)
