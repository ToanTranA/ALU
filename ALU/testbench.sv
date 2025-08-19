`timescale 1ns/1ps
//`include "alu_transaction_pkg.sv"
`include "alu_enviroment.sv"
import alu_transaction_pkg::*;

module testbench;
  
parameter W_DATA_IN = 8;
parameter W_DATA_OP = 2;
parameter W_DATA_OUT =8;
  
 
  // interface
  alu_interface intf();

  // dut
  alu  DUT (
    .i_rst_n(intf.rst_n),	
    .i_clk(intf.clk),
    .i_a(intf.a),
    .i_b(intf.b),
    .i_op(intf.op),
    .o_result(intf.result)
  );
  
  
  
  
initial begin
	intf.clk <= 0;
	forever #5 intf.clk <= ~intf.clk;
end

initial begin
	intf.a <= 0 ;
	intf.b <= 0;
    intf.rst_n <= 0;
  #15;
  intf.rst_n <= 1;
end
  
initial begin
	$dumpfile ("testbench.vcd");
	$dumpvars(0,testbench);
end

initial begin

	alu_enviroment env;
	env = new (intf);
  $display ("RUN ENV");
	env.run();
	#1000;
	$finish;

end
//
//
endmodule