//`include "alu_transaction_pkg.sv"
import alu_transaction_pkg::*;


class alu_driver;
// interface
virtual alu_interface intf;
//maibox recieve transaction form generator
mailbox #(alu_transaction ) gen2drv;

function new (virtual alu_interface intf,
	      mailbox #(alu_transaction ) gen2drv);
	      
	      this.intf = intf;
	      this.gen2drv = gen2drv;
endfunction:new

// task run
task run ();

	forever begin
		// create transaction	
		alu_transaction tr;
		//recieve transaction from generator
		gen2drv.get (tr);
		//trasfer transaction to interface
		intf.a <= tr.a;
		intf.b <= tr.b;
		intf.op <= tr.op;
		@(posedge intf.clk);	
      $display("DRIVER WAITING ");
    end

endtask



endclass