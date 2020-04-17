`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.04.2020 01:20:08
// Design Name: 
// Module Name: sram
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

module sram #(parameter ADDR_WIDTH = 8, DATA_WIDTH = 8, DEPTH = 256) (
    input wire i_clk,
    input wire [ADDR_WIDTH-1:0] i_addr,
    input wire [ADDR_WIDTH-1:0] o_addr, 
    input wire w_enable,
    input wire r_enable,
    input wire [DATA_WIDTH-1:0] i_data,
    output reg [DATA_WIDTH-1:0] o_data 
    );

    reg [DATA_WIDTH-1:0] memory_array [0:DEPTH-1]; 
    reg [DATA_WIDTH-1:0] inp_data_buf;
    
    always @ (posedge i_clk)
    begin
        if(w_enable & ~r_enable)
        begin
            memory_array[i_addr] <= i_data;
        end
        
        else if(r_enable & ~w_enable)
        begin
            o_data <= memory_array[o_addr];
        end  
    end
endmodule
