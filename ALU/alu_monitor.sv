//`include "alu_transaction_pkg.sv"
import alu_transaction_pkg::*;



class alu_monitor ;
	//interface
	virtual alu_interface intf;
	//mailbox to transfer transaction to scoreboard
	mailbox #(alu_transaction ) mon2sb;
  //mailbox to transfer transaction to coverage
  mailbox #(alu_transaction) mon2cvg;
	//contructor
  function new (virtual alu_interface intf, mailbox #(alu_transaction) mon2sb, mailbox #(alu_transaction) mon2cvg );
		this.intf = intf;
		this.mon2sb = mon2sb;
    	this.mon2cvg = mon2cvg;
	endfunction

	//recive data from DUT by interface
	task run();
		forever begin
          alu_transaction tr = new( );
			@(posedge intf.clk);
		//	tr = new(intf.a, intf.b, intf.op);
		//	tr.reuslt = intf.result;
			tr.a = intf.a;
			tr.b = intf.b;
			tr.op = intf.op;
            @(posedge intf.clk);
			tr.result = intf.result;
          $display ("[MONITOR] [TRANSACTION]  tr.a =%d,   tr.b =%d,   tr.op =%d,   tr.result =%d",tr.a, tr.b, tr.op, tr.result );
          $display ("[MONITOR] [INTERFACE]  intf.a =%d,   intf.b =%d,   intf.op =%d,   intf..result =%d",intf.a, intf.b, intf.op, intf.result );
          
            mon2sb.put(tr);   // gửi cho scoreboard
        	mon2cvg.put(tr);  // gửi cho coverage
          $display("MONITOR WAITING ");
		end
	endtask:run

endclass