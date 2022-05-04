module control(
input [2:0] opcode, 
output reg jump, branch, memwrite, regwrite);
 always @(*)
 begin 
     case (opcode)
     3'b000:
     begin 
     jump = 0;
     branch = 0;
     memwrite = 0;
     regwrite = 1;
     end
     endcase
 end

endmodule



