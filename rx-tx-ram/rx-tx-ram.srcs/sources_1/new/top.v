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
input trans_trig,
input clk,
input RxD,
output TxD
); 

wire [7:0] RxData;
reg [7:0] TxData; // changed from wire to reg.
wire recv;
reg trans = 0; // DO SOMETHING WITH THIS LATER.

reg [7:0] w_addr = 8'b0;
reg [7:0] w_addr_prev = 8'b0;
reg [7:0] r_addr = 8'b0;
reg w_en = 0;
reg r_en = 0;
reg [7:0] recv_deb_ctr = 0; // Receiving debounce counter.

wire trans_done;
reg [15:0] trans_ctr = 0; // Used for waiting during transmission.
//reg [7:0] trans_statectr = 0; // HELP. This one is to keep track of the transmission state in THIS module.

wire [7:0] r_data;
wire [7:0] w_data;
reg w_en;
reg r_en;

// assign TxData = r_data;
assign w_data = RxData;

receiver R1 (.clk(clk),
             .reset(btn0),
             .RxD(RxD),
             .recv(recv),
             .RxData(RxData));
             
transmitter T1 (.clk(clk),
                .reset(btn0),
                .transmit(trans),
                .TxD(TxD),
                .data(TxData),
                .transdone(trans_done));
                
sram S1 (.i_clk(clk),
         .i_addr(w_addr),
         .o_addr(r_addr),
         .w_enable(w_en),
         .r_enable(r_en),
         .i_data(w_data),
         .o_data(r_data));

/*
always @ (posedge clk)
begin
    if (trans)
    begin
        trans_ctr <= trans_ctr + 1;
        if (trans_ctr >= 125) 
        begin
            trans_ctr <= 0;
            r_addr <= r_addr + 1;
        end
    end
    
    else
    begin
        r_addr <= 0;
        trans_ctr <= 0;
    end
end*/

always @ (posedge clk)
begin

    if (trans_trig & (~recv))
    begin
    
        w_en <= 0;
        r_en <= 1;
        /*
        if (trans_done)
        begin
            trans <= 0;
            r_addr <= r_addr + 8'b1;
            if (r_addr >= w_addr)
            begin
                r_addr <= 0;
                trans <= 0;
            end
        end
        
        else
        begin
            trans <= 1;
            TxData <= r_data;
        end*/
        
        
        
        trans_ctr <= trans_ctr + 1;
        if (trans_ctr >= 6) //h a c c again //5 is the magic number.
        begin
            trans_ctr <= 0;
            r_addr <= r_addr + 1;
            TxData <= r_data;
            
            if (r_addr >= w_addr)
            begin
                r_addr <= 0;
                trans <= 0;
            end
            trans <= 1;
        end
        else
        begin
            trans <= 0;
        end
        /*
        //trans_ctr <= 0;
        r_addr <= r_addr + 1;
        TxData <= r_data;
            
        if (r_addr >= w_addr)
        begin
            r_addr <= 0;
            trans <= 0;
        end*/
        
    end
    
    else if (recv & (~trans_trig))
    begin
        /*
            Hacky method to write data to memory.
        */
        w_en <= 1;
        r_en <= 0;
        recv_deb_ctr <= recv_deb_ctr + 8'b1;
        trans <= 0; //???????
        //trans_ctr <= 0;
        //r_addr <= 0;
        
        //trans_statectr <= 1;
        /*
            Bless me. verliLORD,
            for I have SYNCed.
            
            This is a hack. Later on, we need better means of control synchronization.
        */
        if (recv_deb_ctr >= 8'd180) //Calibrate this for Virtex 7.
        begin
            w_en <= 0;
            r_en <= 0;
            recv_deb_ctr <= 0;
            w_addr <= w_addr + 8'b1;
        end
    end

    else
    begin
        recv_deb_ctr <= 0;
        w_en <= 0;
        r_en <= 0;
        trans <= 0; //???????
        //r_addr <= 0;
        
        //trans_statectr <= 1;
        trans_ctr <= 0;
    end
end

endmodule