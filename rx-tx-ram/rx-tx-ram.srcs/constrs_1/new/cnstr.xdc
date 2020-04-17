# Clock signal 12 MHz
set_property -dict { PACKAGE_PIN L17   IOSTANDARD LVCMOS33 } [get_ports { clk }]; #IO_L12P_T1_MRCC_14 Sch=gclk
create_clock -add -name sys_clk_pin -period 83.33 -waveform {0 41.66} [get_ports {clk}];

# Buttons
set_property -dict { PACKAGE_PIN A18   IOSTANDARD LVCMOS33 } [get_ports { btn0 }]; #IO_L19N_T3_VREF_16 Sch=btn[0]
set_property -dict { PACKAGE_PIN B18   IOSTANDARD LVCMOS33 } [get_ports { trans_trig }]; #IO_L19P_T3_16 Sch=btn[1]

## UART
#set_property -dict { PACKAGE_PIN J18   IOSTANDARD LVCMOS33 } [get_ports { TxD }]; #IO_L7N_T1_D10_14 Sch=uart_rxd_out
set_property -dict { PACKAGE_PIN J17   IOSTANDARD LVCMOS33 } [get_ports { RxD }];
set_property -dict { PACKAGE_PIN J18   IOSTANDARD LVCMOS33 } [get_ports { TxD }]; #IO_L7N_T1_D10_14 Sch=uart_rxd_out