set_property SRC_FILE_INFO {cfile:/home/ubuntu/Development/vivado-projects/nittany/rx-tx-ram/rx-tx-ram.srcs/constrs_1/new/cnstr.xdc rfile:../../../rx-tx-ram.srcs/constrs_1/new/cnstr.xdc id:1} [current_design]
set_property src_info {type:XDC file:1 line:2 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN L17   IOSTANDARD LVCMOS33 } [get_ports { clk }]; #IO_L12P_T1_MRCC_14 Sch=gclk
set_property src_info {type:XDC file:1 line:6 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN A18   IOSTANDARD LVCMOS33 } [get_ports { btn0 }]; #IO_L19N_T3_VREF_16 Sch=btn[0]
set_property src_info {type:XDC file:1 line:7 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN B18   IOSTANDARD LVCMOS33 } [get_ports { trans_trig }]; #IO_L19P_T3_16 Sch=btn[1]
set_property src_info {type:XDC file:1 line:11 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN J17   IOSTANDARD LVCMOS33 } [get_ports { RxD }];
set_property src_info {type:XDC file:1 line:12 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN J18   IOSTANDARD LVCMOS33 } [get_ports { TxD }]; #IO_L7N_T1_D10_14 Sch=uart_rxd_out
