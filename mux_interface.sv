`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/19/2024 10:44:57 AM
// Design Name: 
// Module Name: mux_interface
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
import sif_mux_aliases_pkg::*;

module mux_interface #(
    parameter   SYS_CLK_FREQ = 50_000_000,
    parameter   SPI_CLK_FREQ = 10_000_000   )
    (
    
    input               clk_i,
    input               rst_i,
    
    input               write_i,       //assert this signal to begin transfer process of the addresses of the lines to the multiplexers
    output              busy_o,        //logical inverse of latch_o signal, signifies if the module is busy or not
    
    input logic [3:0]   TX1_addr_i,
    input logic [3:0]   TX2_addr_i,
    input logic [3:0]   RX1_addr_i,
    input logic [3:0]   RX2_addr_i,
    
    output              latch_o,    //logical inverse of busy_o signal, never use internally, only route out
    output              sclk_o,
    output              TX1_data_o,
    output              TX2_data_o,
    output              RX1_data_o,
    output              RX2_data_o

    );
    
    //////////////////SYS_CLK must be >=4*SPI_CLK or you get issues///////////////////
    
    localparam CLK_DIV = $ceil($itor(SYS_CLK_FREQ / SPI_CLK_FREQ) / 2); //set clock divider with requested SPI frequency, rounding up to integer clock division
    
    localparam ACTUAL_F = SYS_CLK_FREQ / (CLK_DIV*2);  //the actual frequency output after the division
    
    localparam HALF_PERIOD = 1e9 / ACTUAL_F / 2; //number of nanoseconds for half period of SPI_CLK
    localparam SYS_PERIOD = 1e9 / SYS_CLK_FREQ; //number of nanoseconds for SYS_CLK period
    
    localparam WAIT_TIME = HALF_PERIOD >= 60 ? 0 : (60-HALF_PERIOD) / SYS_PERIOD; //how many system cycles after the negedge of SCLK to wait before raising latch to comply with the t_CSH requirement from page 4, 60ns - half period
    
    localparam CLK_CNT_SIZE = WAIT_TIME > CLK_DIV ? WAIT_TIME : CLK_DIV;
    logic [$clog2(CLK_CNT_SIZE)-1:0] clk_div_cnt;
    
    logic clk_div;
    logic latch;
     
    always_ff @(posedge clk_i)
        if(latch)                                                   clk_div_cnt <= '0;
        else if(bit_cnt < 32 && clk_div_cnt == CLK_DIV - 1'b1)      clk_div_cnt <= '0;
        else                                                        clk_div_cnt <= clk_div_cnt + 1'b1;
    always_ff @(posedge clk_i)
        if(latch)                                                   clk_div <= '0;
        else if(bit_cnt < 32 && clk_div_cnt == CLK_DIV - 1'b1)      clk_div <= !clk_div;
    
    
    assign sclk_o = !latch && clk_div;
    assign latch_o = latch;   
    logic sclk_pos, sclk_neg; //edges of sclk
    
    always_ff @(posedge clk_i)
        if(clk_div_cnt == CLK_DIV - 1'b1)
            if(clk_div)                     sclk_neg <= 1'b1;  //when clock is about to change, if the current clock is high, that means a negative edge
            else                            sclk_pos <= 1'b1;  //same for positive edge
        else begin
                                            sclk_neg <= 1'b0;
                                            sclk_pos <= 1'b0;
        end
                                            
    logic [31:0]    TX1_reg, TX2_reg, RX1_reg, RX2_reg; //registers for holding MUX configurations
    logic [5:0]     bit_cnt;    //bit counter for cycling through the registers, needs to be able to hit 32, comparisons involving this register are >= or < so as to only map to the [5] bit
    
    assign TX1_data_o = TX1_reg[31];
    assign TX2_data_o = TX2_reg[31];
    assign RX1_data_o = RX1_reg[31];
    assign RX2_data_o = RX2_reg[31];
    
    typedef enum
        {   Idle,
            Shift   }   state_e;
    (* fsm_encoding ="auto" *)  state_e state, next; //options are one_hot, sequential, johnson, gray, none and auto
    
    //////// state transitions /////////////
    always_comb
        case(state)
            Idle:       if(write_i)                                                 next = Shift;
            Shift:      if(bit_cnt >= 32 && !clk_div && clk_div_cnt >= WAIT_TIME)   next = Idle;
                        else                                                        next = Shift;
            default:                                                                next = Idle;
        endcase
    /////////////////////////////////////////

    assign latch = !(state == Shift); //latch signal goes low when bits are being sent to multiplexers
    assign busy_o = !latch;
     
    always_ff @(posedge clk_i)
        if(write_i && state == Idle) begin
            TX1_reg <= resolveTX1(TX1_addr_i);
            TX2_reg <= resolveTX2(TX2_addr_i);
            RX1_reg <= resolveRX1(RX1_addr_i);
            RX2_reg <= resolveRX2(RX2_addr_i);
            bit_cnt <= '0;
        end else if(sclk_neg && state == Shift && bit_cnt != 32) begin
            TX1_reg <= TX1_reg << 1;
            TX2_reg <= TX2_reg << 1;
            RX1_reg <= RX1_reg << 1;
            RX2_reg <= RX2_reg << 1;
            bit_cnt <= bit_cnt + 1'b1;
        end     
    
    always_ff @(posedge clk_i)
        if(rst_i)   state <= Idle;
        else        state <= next;      
    
endmodule
