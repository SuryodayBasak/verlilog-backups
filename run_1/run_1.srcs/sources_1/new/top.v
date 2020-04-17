`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.04.2020 01:02:02
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module top(
input btn0,
input clk,
input RxD,
output TxD
); 

wire [7:0] RxData;
wire [7:0] TxData;
wire recv;

reg [7:0] memory_ptr = 8'b0;
reg trans;
reg [7:0] recv_deb_ctr = 0;

assign TxData = memory_ptr;

receiver R1 (.clk(clk), .reset(btn0), .RxD(RxD), .recv(recv), .RxData(RxData));
transmitter T1 (.clk(clk), .reset(btn0), .transmit(trans), .TxD(TxD), .data(TxData));

always @ (posedge clk)
begin
    if (recv)
    begin
        recv_deb_ctr <= recv_deb_ctr + 8'b1;
        /*
            Bless me. verliLORD,
            for I have SYNCed.
            
            This is a hack. Later on, we need better means of control synchronization.
        */
        if (recv_deb_ctr >= 8'd180)
        begin
            recv_deb_ctr <= 0;
            memory_ptr <= memory_ptr + 8'b1;
            trans <= 1;
        end
    end

    else
    begin
        recv_deb_ctr <= 0;
        trans <= 1;
    end
end
//receiver R1 (.clk(clk), .reset(btn0), .RxD(RxD), .RxData(RxData));
//transmitter T1 (.clk(clk), .reset(btn0),.transmit(~RxD),.TxD(TxD),.data(RxData));

endmodule