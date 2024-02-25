# Config file for hardening fifo sub-module
export DESIGN_NAME = fifo
export PLATFORM    = sky130hd

export WORK_HOME = .

export VERILOG_FILES = ./designs/sky130hd/uart/src/fifo.v

export SDC_FILE      = ./designs/sky130hd/uart/synthesis/fifo/constraint.sdc

export CORE_UTILIZATION = 75
export CORE_ASPECT_RATIO = 2
export PLACE_DENSITY ?= 0.90

# Power #
export PDN_TCL ?= ./designs/sky130hd/uart/script/macro_pdn.tcl