import  alu_transaction_pkg::*;
class  alu_generator ;
// mailbox 
mailbox #( alu_transaction ) gen2drv;
// constructori
function new ( mailbox #(alu_transaction) gen2drv);
	this.gen2drv = gen2drv;
endfunction;

//create value for input
task run ();
	repeat (100) begin
		alu_transaction tr;
		tr = new ($urandom_range(0,127),$urandom_range(0,127),$urandom_range(0,3));
		gen2drv.put(tr);
		tr.display();
		#10;
	end

endtask:run

endclass
