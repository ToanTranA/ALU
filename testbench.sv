
import alu_transaction_pkg::*;
`include "alu_enviroment.sv"

module testbench;

reg  clk;
alu_interface intf(clk);

initial begin
	clk <= 0;
	forever #5 clk <= ~clk;
end

initial begin
	intf.a <= 0 ;
	intf.b <= 0;

end

initial begin
	$dumpfile ("testbench.vcd");
	$dumpvars(0,testbench);
end

initial begin

	alu_enviroment env;
	env = new (intf);
	env.run();
	#50000;
	$finish;

end
//
//
endmodule
