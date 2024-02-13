export DESIGN_NAME = uart
export PLATFORM    = sky130hd

# Macro Placement #
export SYNTH_HIERARTICAL = 1
export RTLMP_FLOW = True

export VERILOG_FILES = ./user_design/uart/src/uart.v \
					   ./user_design/uart/src/fifo.v

export SDC_FILE      = ./user_design/uart/constraint.sdc

export ADDITIONAL_LEFS = ./fifo.lef

export CORE_UTILIZATION = 75
export CORE_ASPECT_RATIO = 2
#export FP_PDN_CORE_RING = 1

export TNS_END_PERCENT = 100

export PLACE_DENSITY ?= 0.90

export MACRO_PLACE_HALO = 10 10
export MACRO_PLACE_CHANNEL = 20 20 

# Power #
#export PDN_TCL ?= ./user_design/uart/script/pdn.tcl