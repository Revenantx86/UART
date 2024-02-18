export DESIGN_NAME = uart_top
export DESIGN_NICKNAME = uart
export PLATFORM    = sky130hs


# Macro Placement #
export SYNTH_HIERARTICAL = 1
export RTLMP_FLOW = True

export MAX_UNGROUP_SIZE ?= 1000

export RTLMP_MIN_INST = 1000
export RTLMP_MAX_INST = 3500
export RTLMP_MIN_MACRO = 1
export RTLMP_MAX_MACRO = 5

export VERILOG_FILES = ./user_design/uart/src/*.
export SDC_FILE      = ./user_design/uart/constraint.sdc

export BLOCKS = fifo


export ADDITIONAL_GDS = ./user_design/uart/gds/6_1_merged.gds

export ADDITIONAL_LEFS = ./user_design/uart/lef/fifo_wrapper.lef


export DIE_AREA = 0 0 80 90
export CORE_AREA = 5 5 75 85 

export MACRO_PLACE_HALO    = 1 1
export MACRO_PLACE_CHANNEL = 6 6

#
export TNS_END_PERCENT   = 100
