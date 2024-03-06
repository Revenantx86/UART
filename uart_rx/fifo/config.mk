# Config file for hardening fifo sub-module
export PLATFORM    = sky130hd

export DESIGN_NAME = fifo
export DESIGN_NICKNAME = uart_rx-fifo

export VERILOG_FILES = ./designs/sky130hd/uart/src/fifo.v

export SDC_FILE      = ./designs/sky130hd/uart/uart_rx/fifo/constraint.sdc

export CORE_UTILIZATION = 75
export CORE_ASPECT_RATIO = 2
export CORE_MARGIN = 2
export PLACE_DENSITY ?= 0.90

# Power #
export PDN_TCL ?= ./designs/sky130hd/uart/script/macro_pdn.tcl

export MAX_ROUTING_LAYER      = met4