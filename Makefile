# SC-Snaps GUI — Makefile
#
PYTHON     ?= python3

.PHONY: run setup compile clean help

run:
	$(PYTHON) sc-snaps-gui.py

compile:
	gfortran -O2 -o sc_snaps.x sc_snaps.f90
	@echo "Compiled sc_snaps.x"

clean:
	@find . -name "*.pyc" -delete
	@find . -name "__pycache__" -type d -exec rm -rf {} + 2>/dev/null || true
	@echo "Clean."

help:
	@echo "make compile — compile sc_snaps.f90 with gfortran"
	@echo "make run    — start SC-Snaps GUI on http://localhost:5050"
	@echo "make clean  — remove .pyc / __pycache__"
	@echo ""
	@echo "Current settings:"
	@echo "  PYTHON     = $(PYTHON)"
