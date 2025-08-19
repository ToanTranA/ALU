`include "alu_transaction_pkg.sv"  // nếu bạn cần include file package ở đây

import alu_transaction_pkg::*;     // Bắt buộc import package để dùng class bên trong

class alu_generator;

  // Mailbox để gửi transaction đến driver
  mailbox #(alu_transaction) gen2drv;

  // Constructor
  function new(mailbox #(alu_transaction) gen2drv);
    this.gen2drv = gen2drv;
  endfunction

  // Tạo và gửi transaction
  task run();
    repeat (100) begin
      // Tạo transaction 
       alu_transaction tr;
      tr = new();   
      if (!tr.randomize())
        $error("[GENERATOR] Randomization failed!");
      
      gen2drv.put(tr);
      tr.display();
      #20;
    end
  endtask : run

endclass
