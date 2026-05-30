vlib work
vlib activehdl

vlib activehdl/xil_defaultlib
vlib activehdl/xpm
vlib activehdl/axi_lite_ipif_v3_0_4
vlib activehdl/lib_pkg_v1_0_2
vlib activehdl/lib_srl_fifo_v1_0_2
vlib activehdl/lib_cdc_v1_0_2
vlib activehdl/axi_uartlite_v2_0_21
vlib activehdl/microblaze_v10_0_7
vlib activehdl/mdm_v3_2_14
vlib activehdl/proc_sys_reset_v5_0_12
vlib activehdl/lmb_v10_v3_0_9
vlib activehdl/lmb_bram_if_cntlr_v4_0_15
vlib activehdl/blk_mem_gen_v8_4_1

vmap xil_defaultlib activehdl/xil_defaultlib
vmap xpm activehdl/xpm
vmap axi_lite_ipif_v3_0_4 activehdl/axi_lite_ipif_v3_0_4
vmap lib_pkg_v1_0_2 activehdl/lib_pkg_v1_0_2
vmap lib_srl_fifo_v1_0_2 activehdl/lib_srl_fifo_v1_0_2
vmap lib_cdc_v1_0_2 activehdl/lib_cdc_v1_0_2
vmap axi_uartlite_v2_0_21 activehdl/axi_uartlite_v2_0_21
vmap microblaze_v10_0_7 activehdl/microblaze_v10_0_7
vmap mdm_v3_2_14 activehdl/mdm_v3_2_14
vmap proc_sys_reset_v5_0_12 activehdl/proc_sys_reset_v5_0_12
vmap lmb_v10_v3_0_9 activehdl/lmb_v10_v3_0_9
vmap lmb_bram_if_cntlr_v4_0_15 activehdl/lmb_bram_if_cntlr_v4_0_15
vmap blk_mem_gen_v8_4_1 activehdl/blk_mem_gen_v8_4_1

vlog -work xil_defaultlib  -sv2k12 "+incdir+../../../../final_project.srcs/sources_1/bd/main/ipshared/b65a" "+incdir+../../../../final_project.srcs/sources_1/bd/main/ipshared/b65a" \
"C:/Xilinx/Vivado/2018.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"C:/Xilinx/Vivado/2018.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"C:/Xilinx/Vivado/2018.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../final_project.srcs/sources_1/bd/main/ipshared/b65a" "+incdir+../../../../final_project.srcs/sources_1/bd/main/ipshared/b65a" \
"../../../bd/main/ip/main_clk_wiz_0_0/main_clk_wiz_0_0_clk_wiz.v" \
"../../../bd/main/ip/main_clk_wiz_0_0/main_clk_wiz_0_0.v" \

vcom -work axi_lite_ipif_v3_0_4 -93 \
"../../../../final_project.srcs/sources_1/bd/main/ipshared/cced/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd" \

vcom -work lib_pkg_v1_0_2 -93 \
"../../../../final_project.srcs/sources_1/bd/main/ipshared/0513/hdl/lib_pkg_v1_0_rfs.vhd" \

vcom -work lib_srl_fifo_v1_0_2 -93 \
"../../../../final_project.srcs/sources_1/bd/main/ipshared/51ce/hdl/lib_srl_fifo_v1_0_rfs.vhd" \

vcom -work lib_cdc_v1_0_2 -93 \
"../../../../final_project.srcs/sources_1/bd/main/ipshared/ef1e/hdl/lib_cdc_v1_0_rfs.vhd" \

vcom -work axi_uartlite_v2_0_21 -93 \
"../../../../final_project.srcs/sources_1/bd/main/ipshared/a15e/hdl/axi_uartlite_v2_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/main/ip/main_axi_uartlite_0_0/sim/main_axi_uartlite_0_0.vhd" \

vcom -work microblaze_v10_0_7 -93 \
"../../../../final_project.srcs/sources_1/bd/main/ipshared/b649/hdl/microblaze_v10_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/main/ip/main_microblaze_0_0/sim/main_microblaze_0_0.vhd" \

vcom -work mdm_v3_2_14 -93 \
"../../../../final_project.srcs/sources_1/bd/main/ipshared/5125/hdl/mdm_v3_2_vh_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/main/ip/main_mdm_1_0/sim/main_mdm_1_0.vhd" \

vcom -work proc_sys_reset_v5_0_12 -93 \
"../../../../final_project.srcs/sources_1/bd/main/ipshared/f86a/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/main/ip/main_rst_clk_wiz_0_100M_0/sim/main_rst_clk_wiz_0_100M_0.vhd" \

vcom -work lmb_v10_v3_0_9 -93 \
"../../../../final_project.srcs/sources_1/bd/main/ipshared/78eb/hdl/lmb_v10_v3_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/main/ip/main_dlmb_v10_0/sim/main_dlmb_v10_0.vhd" \
"../../../bd/main/ip/main_ilmb_v10_0/sim/main_ilmb_v10_0.vhd" \

vcom -work lmb_bram_if_cntlr_v4_0_15 -93 \
"../../../../final_project.srcs/sources_1/bd/main/ipshared/92fd/hdl/lmb_bram_if_cntlr_v4_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/main/ip/main_dlmb_bram_if_cntlr_0/sim/main_dlmb_bram_if_cntlr_0.vhd" \
"../../../bd/main/ip/main_ilmb_bram_if_cntlr_0/sim/main_ilmb_bram_if_cntlr_0.vhd" \

vlog -work blk_mem_gen_v8_4_1  -v2k5 "+incdir+../../../../final_project.srcs/sources_1/bd/main/ipshared/b65a" "+incdir+../../../../final_project.srcs/sources_1/bd/main/ipshared/b65a" \
"../../../../final_project.srcs/sources_1/bd/main/ipshared/67d8/simulation/blk_mem_gen_v8_4.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../final_project.srcs/sources_1/bd/main/ipshared/b65a" "+incdir+../../../../final_project.srcs/sources_1/bd/main/ipshared/b65a" \
"../../../bd/main/ip/main_lmb_bram_0/sim/main_lmb_bram_0.v" \
"../../../bd/main/sim/main.v" \

vlog -work xil_defaultlib \
"glbl.v"

