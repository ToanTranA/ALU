package alu_transaction_pkg;
	typedef class alu_transaction;


	class alu_transaction ;

	parameter W_DATA_IN = 8;
	parameter W_OP = 2;
	parameter W_DATA_OUT = 8;
	//input
	rand logic [W_DATA_IN-1:0] a;
	rand logic [W_DATA_IN-1:0] b;
	rand logic [W_OP-1:0] op; 
	//output
     	logic [W_DATA_OUT-1:0] result;

	//constructor
	function new (logic [W_DATA_IN-1:0] a, logic [W_DATA_IN-1:0] b, logic [W_OP-1:0] op );
		this.a = a;
		this.b = b;
		this.op = op;
	endfunction:new

	//display
	function void  display ();
		$display ("[TRANSACTION] a = %b, b = %b, op = %b",this.a, this.b, this.op);
	endfunction

	endclass

endpackage
