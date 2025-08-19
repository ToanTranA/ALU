//`include "alu_transaction_pkg.sv"
import alu_transaction_pkg::*;

class alu_coverage #(W_DATA_IN = 8, W_DATA_OP = 2, W_DATA_OUT = 8);
	// recieve data from monitor
	mailbox #(alu_transaction) mon2cov;	
	/*logic [7:0] a;
	logic [7:0] b;
	logic [1:0] op;	*/
  
  covergroup cg_a_b_sel with function sample(
  bit [7:0] a_s,
  bit [7:0] b_s,
  bit [1:0] op_s
);

  coverpoint op_s {
    bins add_bin = {2'b00};
    bins sub_bin = {2'b01};
    bins mul_bin = {2'b10};
    bins div_bin = {2'b11};
  }

  coverpoint a_s {
    bins low  = {[0:85]};
    bins mid  = {[86:170]};
    bins high = {[171:255]};
   // illegal_bins others = default; // debug giá trị lạc
  }

  coverpoint b_s {
    bins low  = {[0:85]};
    bins mid  = {[86:170]};
    bins high = {[171:255]};
   // illegal_bins others = default;
  }

  cross op_s, a_s;
  cross op_s, b_s;

endgroup

  
  
  
  
/*	// Covergroup function coverage
	covergroup cg_a_b_sel;
	coverpoint this.op {
	bins add_bin = {2'b00};
	bins sub_bin = {2'b01};
	bins mul_bin = {2'b10};
	bins div_bin = {2'b11};	
		} 
	coverpoint this.a {
	bins low = {[0:30]};
	bins mid = {[31:100]};
	bins high = {[101:127]};	
		}
	coverpoint this.b {
	bins low = {[0:30]};
      bins mid = {[31:100]};
	bins high = {[101:127]};	
		}
	// Cross coverage
	cross this.op,this.a;
	cross this.op,this.b;
endgroup
*/
 
	// contructor
	function new (mailbox #(alu_transaction ) mon2cvg);
		this.mon2cov = mon2cvg;
		 cg_a_b_sel = new ();
	endfunction:new

	// task run
	task run();
		forever begin
		alu_transaction current_item;	
		mon2cov.get(current_item);
		/*a = current_item.a;
		b = current_item.b;
		op = current_item.op;*/
	//	cg_a_b_sel.sample();
      cg_a_b_sel.sample(current_item.a, current_item.b, current_item.op);

		//cg_a_b_sel.sample();
          $display ("COVERAGE a = %b  ,  b = %b,   op = %b",current_item.a,current_item.b,current_item.op);
		//$display("Functional Coverage_CLASS = %0.2%%",cg_a_b_sel.get_inst_coverage());
	        $display ("Functional Coverage_CLASS = %0.2f%%", cg_a_b_sel.get_inst_coverage());

          
          // Debug mỗi lần sample
      $display("[COV] Sample a=%0d, b=%0d, op=%0d => Coverage= %0.2f%%",
                current_item.a, current_item.b, current_item.op,
                cg_a_b_sel.get_inst_coverage());
          
          
		end
	endtask:run

endclass