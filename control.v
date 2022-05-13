module control(
input [2:0] opcode, 
output reg jump, branch, memwrite, regwrite, aluop, reg_dest, memtoreg );
 always @(*)
 begin 
     case (opcode)
     3'b000:
     begin 
     jump = 0;
     branch = 0;
     memwrite = 0;
     regwrite = 1;
     aluop = 0;
     reg_dest = 0;
     memtoreg = 0;
     end
     3'b001:
      begin 
     jump = 0;
     branch = 0;
     memwrite = 0;
     regwrite = 1;
     aluop = 1;
     reg_dest = 1;
     memtoreg = 0;
     end
     endcase
 end

endmodule



