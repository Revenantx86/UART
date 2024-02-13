export DESIGN_NAME = fifo
export PLATFORM    = sky130hd

export WORK_HOME = .

export VERILOG_FILES = ./user_design/uart/src/fifo.v

export SDC_FILE      = ./user_design/uart/submodule/fifo/constraint.sdc

export CORE_UTILIZATION = 75
export CORE_ASPECT_RATIO = 2
#export FP_PDN_CORE_RING = 1

export TNS_END_PERCENT = 100

export PLACE_DENSITY ?= 0.90

# Power #
export PDN_TCL ?= ./user_design/uart/script/pdn.tcl