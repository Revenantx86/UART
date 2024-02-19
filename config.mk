
export DESIGN_NICKNAME = uart
export DESIGN_NAME = uart
export PLATFORM    = sky130hd


export SYNTH_HIERARTICAL = 1
export RTLMP_FLOW = True

export MAX_UNGROUP_SIZE ?= 1000

export RTLMP_MIN_INST = 1000
export RTLMP_MAX_INST = 3500
export RTLMP_MIN_MACRO = 1
export RTLMP_MAX_MACRO = 5

export VERILOG_FILES = ./designs/$(PLATFORM)/$(DESIGN_NICKNAME)/src/*.
export SDC_FILE      = ./designs/$(PLATFORM)/$(DESIGN_NICKNAME)/constraint.sdc

export BLOCKS = fifo

export ADDITIONAL_GDS = ./designs/$(PLATFORM)/$(DESIGN_NICKNAME)/gds/6_1_merged.gds
export ADDITIONAL_LEFS = ./designs/$(PLATFORM)/$(DESIGN_NICKNAME)/lef/fifo_wrapper.lef


export DIE_AREA = 0 0 80 90
export CORE_AREA = 5 5 75 85 

export MACRO_PLACE_HALO    = 1 1
export MACRO_PLACE_CHANNEL = 6 6

export TNS_END_PERCENT   = 100
