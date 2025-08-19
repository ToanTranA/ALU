package alu_transaction_pkg;

  class alu_transaction;

    parameter W_DATA_IN  = 8;
    parameter W_OP       = 2;
    parameter W_DATA_OUT = 8;

    // Input
    rand logic [W_DATA_IN-1:0] a;
    rand logic [W_DATA_IN-1:0] b;
    rand logic [W_OP-1:0]      op;

    // Output
    logic [W_DATA_OUT-1:0] result;

    // Constructor
    function new( );
      
    endfunction

     constraint op_c { op inside {[0:3]}; }
    
    // Display
    function void display();
      $display("[TRANSACTION] a = %0d, b = %0d, op = %0d", a, b, op);
    endfunction

  endclass

endpackage
