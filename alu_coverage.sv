import alu_transaction_pkg::*;
class alu_coverage #(W_DATA_IN = 8, W_DATA_OP = 2, W_DATA_OUT = 8);
	// recieve data from monitor
	mailbox #(alu_transaction) mon2cov;	
	logic [7:0] a;
	logic [7:0] b;
	logic [1:0] op;	
	// Covergroup function coverage
	covergroup cg_a_b_sel;
	coverpoint op {
		
	bins add_bin = {2'b00};
	bins sub_bin = {2'b01};
	bins mul_bin = {2'b10};
	bins div_bin = {2'b11};	
		} 
	coverpoint a {
	bins low = {[0:30]};
	bins mid = {[31:100]};
	bins high = {[101:127]};	
		}
	coverpoint b {
	bins low = {[0:30]};
	bins mid = {[31:200]};
	bins high = {[101:127]};	
		}
	// Cross coverage
	cross op,a;
	cross op,b;
endgroup

	cg_a_b_sel cg_inst;
	// contructor
	function new (mailbox #(alu_transaction ) mon2cvg);
		this.mon2cov = mon2cvg;
		//cg_a_b_sel = new ();
	endfunction:new

	// task run
	task run();
		forever begin
		alu_transaction current_item;	
		mon2cov.get(current_item);
		a = current_item.a;
		b = current_item.b;
		op = current_item.op;
	//	cg_a_b_sel.sample();
		cg_inst.sample();
		//$display("Functional Coverage_CLASS = %0.2%%",cg_a_b_sel.get_inst_coverage());
	        $display ("Functional Coverage_CLASS = %0.2f%%", cg_inst.get_inst_coverage());

		end
	endtask:run

endclass
