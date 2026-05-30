-makelib xcelium_lib/xil_defaultlib -sv \
  "C:/Xilinx/Vivado/2018.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "C:/Xilinx/Vivado/2018.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib xcelium_lib/xpm \
  "C:/Xilinx/Vivado/2018.2/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/main/ip/main_clk_wiz_0_0/main_clk_wiz_0_0_clk_wiz.v" \
  "../../../bd/main/ip/main_clk_wiz_0_0/main_clk_wiz_0_0.v" \
-endlib
-makelib xcelium_lib/axi_lite_ipif_v3_0_4 \
  "../../../../final_project.srcs/sources_1/bd/main/ipshared/cced/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/lib_pkg_v1_0_2 \
  "../../../../final_project.srcs/sources_1/bd/main/ipshared/0513/hdl/lib_pkg_v1_0_rfs.vhd" \
-endlib
-makelib xcelium_lib/lib_srl_fifo_v1_0_2 \
  "../../../../final_project.srcs/sources_1/bd/main/ipshared/51ce/hdl/lib_srl_fifo_v1_0_rfs.vhd" \
-endlib
-makelib xcelium_lib/lib_cdc_v1_0_2 \
  "../../../../final_project.srcs/sources_1/bd/main/ipshared/ef1e/hdl/lib_cdc_v1_0_rfs.vhd" \
-endlib
-makelib xcelium_lib/axi_uartlite_v2_0_21 \
  "../../../../final_project.srcs/sources_1/bd/main/ipshared/a15e/hdl/axi_uartlite_v2_0_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/main/ip/main_axi_uartlite_0_0/sim/main_axi_uartlite_0_0.vhd" \
-endlib
-makelib xcelium_lib/microblaze_v10_0_7 \
  "../../../../final_project.srcs/sources_1/bd/main/ipshared/b649/hdl/microblaze_v10_0_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/main/ip/main_microblaze_0_0/sim/main_microblaze_0_0.vhd" \
-endlib
-makelib xcelium_lib/mdm_v3_2_14 \
  "../../../../final_project.srcs/sources_1/bd/main/ipshared/5125/hdl/mdm_v3_2_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/main/ip/main_mdm_1_0/sim/main_mdm_1_0.vhd" \
-endlib
-makelib xcelium_lib/proc_sys_reset_v5_0_12 \
  "../../../../final_project.srcs/sources_1/bd/main/ipshared/f86a/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/main/ip/main_rst_clk_wiz_0_100M_0/sim/main_rst_clk_wiz_0_100M_0.vhd" \
-endlib
-makelib xcelium_lib/lmb_v10_v3_0_9 \
  "../../../../final_project.srcs/sources_1/bd/main/ipshared/78eb/hdl/lmb_v10_v3_0_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/main/ip/main_dlmb_v10_0/sim/main_dlmb_v10_0.vhd" \
  "../../../bd/main/ip/main_ilmb_v10_0/sim/main_ilmb_v10_0.vhd" \
-endlib
-makelib xcelium_lib/lmb_bram_if_cntlr_v4_0_15 \
  "../../../../final_project.srcs/sources_1/bd/main/ipshared/92fd/hdl/lmb_bram_if_cntlr_v4_0_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/main/ip/main_dlmb_bram_if_cntlr_0/sim/main_dlmb_bram_if_cntlr_0.vhd" \
  "../../../bd/main/ip/main_ilmb_bram_if_cntlr_0/sim/main_ilmb_bram_if_cntlr_0.vhd" \
-endlib
-makelib xcelium_lib/blk_mem_gen_v8_4_1 \
  "../../../../final_project.srcs/sources_1/bd/main/ipshared/67d8/simulation/blk_mem_gen_v8_4.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/main/ip/main_lmb_bram_0/sim/main_lmb_bram_0.v" \
  "../../../bd/main/sim/main.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib

