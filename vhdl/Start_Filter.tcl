
#Setup the path to point to the standard cells
set_attribute lib_search_path {/doppler/cadence/mudd_labs/lab3/} /

set_attribute information_level 2

#Leave clock gating enabled to lower power consumption
#set_attribute lp_insert_clock_gating true /

#set_attribute lp_insert_operand_isolation true /

set_attribute library {muddlib.lib} /


set_attribute write_vlog_empty_module_for_logic_abstract false

#Read in the design (can read in multiple files if desired
read_hdl -library work -vhdl ./convmult.vhd ./fulladder.vhd ./add16.vhd ./sum.vhd ./dff.vhd ./shiftreg.vhd ./filter.vhd

set_attribute endpoint_slack_opto true /

 
#elaborate LATCH
elaborate FILTER

#next setup some constraints
#define_clock -domain myclkdomain -name myclk -period 10000 [find /designs/controller_synth/ports_in/ -ignorecase -port ph1]
#define_cost_group -name myclkgroup -weight 1
#path_group -from myclk -group myclkgroup

#external_delay -input 500 -clock myclk [find /designs/controller_synth/ports_in/ -port *]
#external_delay -output 500 -clock myclk [find /designs/controller_synth/ports_out/ -port *]

#netlist needs to be unique for encounter to work
edit_netlist uniquify /designs/FILTER

#set_attribute external_pin_cap 50 [find /designs/controller_synth/ports_out -port *]

#set_attribute max_transition 2000 SigDelADC

#now synthesize it to the technology
synthesize -to_mapped


#report clock_gating 
#report area /designs/ShiftRegister
#report timing -lint /designs/ShiftRegister
#report design_rules /designs/ShiftRegister

write -mapped /designs/FILTER > filter_syn.v

write_sdc /designs/FILTER > filter.sdc

