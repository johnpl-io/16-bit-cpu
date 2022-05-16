module control(
input [2:0] opcode, 
output reg jump, branch, memwrite, regwrite, alusrc, reg_dest, memtoreg );
 always @(*)
 begin 
     case (opcode)
     3'b000:  //r type 
     begin 
     jump = 0;
     branch = 0;
     memwrite = 0;
     regwrite = 1;
     alusrc = 0;
     reg_dest = 0;
     memtoreg = 0;
     end
     3'b001:
    begin   //ADDI
     jump = 0;
     branch = 0;
     memwrite = 0;
     regwrite = 1;
     alusrc = 1;
     reg_dest = 1;
     memtoreg = 0;
     end
     3'b010: 
     begin  //SUBI
     jump = 0;
     branch = 0;
     memwrite = 0;
     regwrite = 1;
     alusrc = 1;
     reg_dest = 1;
     memtoreg = 0;
     end
    3'b011: //st
     begin 
     jump = 0;
     branch = 0;
     memwrite = 1;
     regwrite = 0;
     alusrc = 1;
     reg_dest = 1;
     memtoreg = 0;
     end
    3'b100:    //ld
    begin 
    jump = 0;
    branch = 0;
    memwrite = 0;
    regwrite = 1;
    alusrc = 1;
    reg_dest = 1;
    memtoreg = 1;
    end
    3'b101: //jump
    begin  
    jump = 1;
    branch = 0;
    memwrite = 0;
    regwrite = 0;
    alusrc = 0;
    reg_dest = 0;
    memtoreg = 0;
    end
     3'b110: //beq
     begin
    jump = 0;
    branch = 1;
    memwrite = 0;
    regwrite = 0;
    alusrc = 0;
    reg_dest = 0;
    memtoreg = 0;
    end
     endcase
     
 end

endmodule



