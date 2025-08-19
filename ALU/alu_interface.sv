//`include "alu_transaction_pkg.sv"
//import alu_transaction_pkg::*;


interface alu_interface #(parameter W_DATA_IN = 8, W_DATA_OUT = 8, W_DATA_OP = 2);
    logic rst_n;
    logic clk;
	logic [W_DATA_IN-1:0] a;
	logic [W_DATA_IN-1:0] b;
	logic [W_DATA_OP-1:0] op;
	logic [W_DATA_OUT-1:0] result;


endinterface