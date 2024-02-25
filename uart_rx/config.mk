# Config file for hardening receiver macro
export PLATFORM = sky130hd
export DESIGN_NAME = uart_rx_top
export DESIGN_NICKNAME = uart_rx

export RTL_DIR = ./designs/$(PLATFORM)/uart/src

# Verilog source files #
export VERILOG_FILES = \
					$(RTL_DIR)/uart_rx_top.v \
					$(RTL_DIR)/uart_rx.v \
					$(RTL_DIR)/fifo.v 

# Clock synth constraints #
export SDC_FILE      = ./designs/$(PLATFORM)/uart/uart_rx/constraint.sdc

# Macro Config
export SYNTH_HIERARCHICAL = 1
export RTLMP_FLOW = True
export BLOCKS = fifo

# Power #
#export PDN_TCL = $(TOP_DIR)/script/macro_pdn.tcl

# Size #
export DIE_AREA = 0 0 430 430
export CORE_AREA = 10 10 420 420

# Routing
export MACRO_PLACE_HALO = 20 20
export MACRO_PLACE_CHANNEL = 20 20

export MACRO_HALO_X = 14
export MACRO_HALO_Y = 14
# Met 5 Reserved for global routing