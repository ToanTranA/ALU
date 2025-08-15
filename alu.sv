module alu #(parameter W_DATA_IN = 8, W_DATA_OP = 2, W_DATA_OUT =8)
		(
		 input  logic 		      i_rst_n,	
		 input  logic 		      i_clk,
		 input  logic [W_DATA_IN-1:0] i_a,
		 input  logic [W_DATA_IN-1:0] i_b,
		 input  logic [W_DATA_OP-1:0] i_op,
		 output logic [W_DATA_OUT-1:0] o_result);

parameter add = 2'd0;
parameter sub = 2'd1;
parameter mul = 2'd2;
parameter div = 2'd3;

logic [W_DATA_OUT-1:0] temp;

	always@(*) begin
		case (i_op)
			add: temp =i_a + i_b;
			sub: temp =i_a - i_b;
			mul: temp =i_a * i_b;
			div: temp =i_a / i_b;
			default: temp = 'd1;
		endcase
	end
	
	always@(posedge i_clk or negedge i_rst_n) begin
	
		if (!i_rst_n) 
			o_result <= 'd0;
		else 
			o_result <= temp;	

	end		

endmodule
