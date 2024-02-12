RED=\033[0;31m
GREEN=\033[0;32m
BLUE=\033[0;34m
MAGENTA=\033[0;35m
NC=\033[0m # No Color

# Behaivoral Test Commands #

# Module test
fifo-test:
	@echo "$(GREEN)Verilog testbench sythesis. $(NC)"
	iverilog -o test/fifo/fifo_wave.vvp  test/fifo/fifo_tb.sv src/fifo.v
	@echo "$(MAGENTA)Creating waveform file. $(NC)"
	vvp -n test/fifo/fifo_wave.vvp
	@echo "$(BLUE)Result Checker. $(NC)"
	python3 test/fifo/grade_fifo.py


