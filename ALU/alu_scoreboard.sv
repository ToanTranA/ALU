//`include "alu_transaction_pkg.sv"
import alu_transaction_pkg::*;
 
class alu_scoreboard #(W_DATA_IN = 8, W_DATA_OP = 2, W_DATA_OUT = 8) ;
	// actual value from monitor
	mailbox #(alu_transaction) mon2sb;
	//contructor
	function new (mailbox #(alu_transaction ) mon2sb);
		this.mon2sb = mon2sb;
	endfunction:new

	//task run
	task run ();
		//create transaction
		alu_transaction act;
		forever begin 
			mon2sb.get(act);
			compare(act);
		end	
	
	endtask:run

	// compare 
	function void compare (alu_transaction tr );
		logic [W_DATA_OUT-1:0] expected;
		logic [W_DATA_OUT-1:0] actual;
		
		case (tr.op)
			2'd0: expected = tr.a + tr.b; //add
			2'd1: expected = tr.a - tr.b;//sub
			2'd2: expected = tr.a * tr.b;// mul
			2'd3: expected = tr.a / tr.b;//dib
		endcase
		
		actual = tr.result;
      $display("SCOREBOARD WAITING ");
      if (actual !== expected ) begin
			$display("[SB] MISHMATCH at expected_data = %0d, actual_data = %0d ", expected, actual);
		end
		else 
			$display("[SB] MATCH at expected_data = %0d, actual_data = %0d ", expected, actual);
	endfunction:compare


endclass