MODULE_PATHS:=$(shell tools/bin/find-modules)

all : $(MODULE_PATHS) $(MODULE_DOC_PATHS)

$(MODULE_PATHS) :
	terraform fmt $@
	tools/bin/update-docs $@/README.md

.PHONY : all $(MODULE_PATHS) $(MODULE_DOC_PATHS)
