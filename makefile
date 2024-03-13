RED=\033[0;31m
GREEN=\033[0;32m
BLUE=\033[0;34m
MAGENTA=\033[0;35m
NC=\033[0m # No Color

# Behaivoral Test Commands #

# Module test L1
fifo-test:
	@echo "$(GREEN)Verilog testbench sythesis. $(NC)"
	iverilog -o test/fifo/fifo_wave.vvp  test/fifo/fifo_tb.sv src/fifo.v
	@echo "$(MAGENTA)Creating waveform file. $(NC)"
	vvp -n test/fifo/fifo_wave.vvp
	@echo "$(BLUE)Result Checker. $(NC)"
	python3 test/fifo/grade_fifo.py


# Module test L2
uart_rx-test:
	@echo "$(GREEN)Verilog testbench sythesis. $(NC)"
	iverilog -g2012  -o test/rx_module/rx_module.vvp  test/rx_module/rx_module_tb.sv src/fifo.v src/uart_rx.v src/baud_gen.v
	@echo "$(MAGENTA)Creating waveform file. $(NC)"
	vvp -n test/rx_module/rx_module.vvp


uart-test:
	@echo "$(GREEN)Verilog testbench sythesis. $(NC)"
	iverilog -g2012  -o test/uart/uart_tb.vvp  test/uart/uart_tb.sv src/uart_top.v src/fifo.v src/uart_rx.v src/baud_gen.v
	@echo "$(MAGENTA)Creating waveform file. $(NC)"
	vvp -n test/uart/uart_tb.vvp


yosys:
	yosys synth.ys
