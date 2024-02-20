# Config file for hardening receiver macro
export TOP_NICKNAME = uart
export TOP_DIR = ./designs/$(PLATFORM)/$(TOP_NICKNAME)

export DESIGN_NAME = rx_module_top
export DESIGN_NICKNAME = ${TOP_NICKNAME}_${DESIGN_NAME}
export PLATFORM    = sky130hd
export RTL_DIR = ${TOP_DIR}/src


# Verilog source files #
export VERILOG_FILES = \
					$(RTL_DIR)/uart_rx_top.v \
					$(RTL_DIR)/uart_rx.v \
					$(RTL_DIR)/fifo.v 

# Clock synth constraints #
export SDC_FILE      = ./user_design/uart/submodule/fifo/constraint.sdc

# Power #
export PDN_TCL ?= ./user_design/uart/script/pdn.tcl

# Size #
export CORE_UTILIZATION = 75
export CORE_ASPECT_RATIO = 2
export PLACE_DENSITY ?= 0.90

# Routing
export MIN_ROUTING_LAYER = met1
export MAX_ROUTING_LAYER = met4 

# Met 5 Reserved for global routing