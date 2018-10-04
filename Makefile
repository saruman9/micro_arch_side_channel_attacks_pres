MAKEFLAGS  := -j 1
SRC = tex/main.tex
PDF = tex/main.pdf
CACHE_DIR   := $(shell pwd)/.latex-cache
STY = $(wildcard *.sty)

COMPILE_TEX := latexmk -xelatex -shell-escape -use-make -output-directory=$(CACHE_DIR)
export TEXINPUTS:=$(shell pwd):$(shell pwd)/source:${TEXINPUTS}

.PHONY: all presentation clean clean-cache

all: presentation

presentation: $(PDF)

clean: clean-cache

clean-cache:
	@rm -rf "$(CACHE_DIR)"

$(CACHE_DIR):
	@mkdir -p $(CACHE_DIR)

$(PDF): $(STY) $(SRC) | clean-cache $(CACHE_DIR)
	@cd $(firstword $(dir $(SRC))) && $(COMPILE_TEX) $(notdir $(SRC))
	@cp $(CACHE_DIR)/$(notdir $(PDF)) presentation.pdf
