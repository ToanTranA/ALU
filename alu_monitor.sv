
import alu_transaction_pkg::*;


class alu_monitor ;
	//interface
	virtual alu_interface intf;
	//mailbox to transfer transaction to scoreboard
	mailbox #(alu_transaction ) mon2sb;
	//contructor
	function new (virtual alu_interface intf, mailbox #(alu_transaction) mon2sb);
		this.intf = intf;
		this.mon2sb = mon2sb;
	endfunction

	//recive data from DUT by interface
	task run();
		forever begin
			alu_transaction tr;
			@(posedge intf.clk);
			#2;
		//	tr = new(intf.a, intf.b, intf.op);
		//	tr.reuslt = intf.result;
			tr.a = intf.a;
			tr.b = intf.b;
			tr.op = intf.op;
			tr.result = intf.result;
		end
	endtask:run

endclass
