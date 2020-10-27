# Resmue generating makefile

include config.mk

.PHONY: all
all: spellcheck $(RESUME_OUTPUT_NAME).txt $(RESUME_OUTPUT_NAME).html

$(RESUME_OUTPUT_NAME).txt: $(RESUME_OUTPUT_NAME).html
	pandoc -f html -t plain $< -o $@

$(RESUME_OUTPUT_NAME).html : process-template.py $(RESUME_SOURCE) $(CONFIG_SOURCE)
	pipenv install && pipenv run python3 $^ > $@;

spellcheck: $(RESUME_SOURCE)
	@cat $< | aspell list --mode html > $@; \
	if [ $$(wc -l <$@) -gt 0 ]; then \
		echo "There are spelling errors in $<"; \
		echo "Please run \"aspell -c $< --mode html\""; \
		exit 1; \
	fi;

.PHONY: variables
variables:
	@echo RESUME_SOURCE: $(RESUME_SOURCE)
	@echo CONFIG_SOURCE: $(RESUME_SOURCE)
	@echo RESUME_OUTPUT_NAME: $(RESUME_OUTPUT_NAME)

.PHONY: clean
clean:
	rm -f spellcheck
	rm -f $(RESUME_OUTPUT_NAME).txt
	rm -f $(RESUME_OUTPUT_NAME).html
