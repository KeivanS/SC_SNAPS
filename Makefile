# SC-Snaps GUI — Makefile
#
PYTHON ?= python3
BINDIR ?= $(HOME)/BIN

.PHONY: run compile clean help

run:
	$(PYTHON) sc-snaps-gui.py

compile:
	@mkdir -p "$(BINDIR)"
	gfortran -O2 -o sc_snaps.x sc_snaps.f90
	mv -f sc_snaps.x "$(BINDIR)/sc_snaps.x"
	mv -f poscar2xyz.py "$(BINDIR)/iposcar2xyz.py"
	@echo "Compiled and moved sc_snaps.x to $(BINDIR)/sc_snaps.x"

clean:
	@find . -name "*.pyc" -delete
	@find . -name "__pycache__" -type d -exec rm -rf {} + 2>/dev/null || true
	@echo "Clean."

help:
	@echo "make compile — compile sc_snaps.f90 and move sc_snaps.x to $(BINDIR)"
	@echo "make run     — start SC-Snaps GUI on http://localhost:5050"
	@echo "make clean   — remove .pyc / __pycache__"
	@echo ""
	@echo "Current settings:"
	@echo "  PYTHON = $(PYTHON)"
	@echo "  BINDIR = $(BINDIR)"
