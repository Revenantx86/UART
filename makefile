# Behaivoral Test Commands #

# Module test
fifo-test:
	iverilog -o test/fifo/fifo_wave.vvp  test/fifo/fifo_tb.sv src/fifo_8x64.v
	vvp -n test/fifo/fifo_wave.vvp


