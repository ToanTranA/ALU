//`include "alu_transaction_pkg.sv"
//import alu_transaction_pkg::*;

 
`include "alu_generator.sv"
`include "alu_interface.sv"
`include "alu_driver.sv"
`include "alu_monitor.sv"
`include "alu_scoreboard.sv"
`include "alu_coverage.sv"
 


class alu_enviroment ;
	alu_generator gen;
	alu_driver drv;
	alu_monitor mon;
	alu_scoreboard sb;
	alu_coverage cvg;
	mailbox #(alu_transaction) gen2drv;
	mailbox #(alu_transaction) mon2sb;
	mailbox #(alu_transaction) mon2cvg;
	virtual alu_interface intf;

	function new (virtual alu_interface intf);
		this.intf = intf;
		gen2drv = new ();
		mon2sb = new();
      mon2cvg = new ();
      
		sb = new (mon2sb);
		gen = new (gen2drv);
		drv = new (intf, gen2drv);
        mon = new (intf, mon2sb,mon2cvg);
		cvg = new (mon2cvg);
	endfunction

	task run ();
		fork 
          $display("RUN GEN");
			gen.run();
          $display("RUN DRIVER");
			drv.run();
          $display("RUN MON");
			mon.run();
          $display("RUN SCB");
			sb.run();
          $display("RUN CVG");
			cvg.run();
        join_any
	endtask
	
endclass