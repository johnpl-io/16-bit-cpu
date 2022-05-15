# 16-bit Computer in Verilog
## Instruction Set Architecture

### Explanation of design
This processor handles instructions that are 16 bit in lengths. This was chosen to allow for flexibility in creating an RISC-based processor that was inspired by MIPS. The Data-Width of the ALU is also 16 bits in length, allowing the processor to be considered 16 
bit. There are 8 registers in total ```X0-X7``` which each can hold 16 bits of data. This means that each register is represented in 3 bits. This also means that a register Opcodes are consitently 3 bit in length, no matter the instruction given to the processor. The processor supports three types of instruction ```r```, ```i```,  and ```j```. ``r`` contains all instructions that do not require an immediate value and deal with direct manipulation of registers. All instructions of the ``r`` type are ```000``` which allows for a simpler control with more details of this design decision in the control section. ```i``` instructions handle immediate logical operations with registers but also include loading and storing. This was chosen as both loading and storing and traditional immediate instructions add a register to an offset, allowing for easier decoding of instructions. Following this notion, ```i``` also encorporates branching if equal to. ```j``` is reserved for a single instruction, ``J`` which includes jumping to an unconditional jump to an address in instruction memory.

<img width="1075" alt="ISA" src="https://user-images.githubusercontent.com/100248274/168493294-45904a36-2937-47e2-abb1-b45c064e9134.png">

As seen above, the use of `000` for all ``r`` type opcodes allows for additional instructions with only 3 bits of opcode avaiablaity. To allow for easy decoding, R[rs] is always bits 12-10 in an instruction as it is always and ALU operand. The other operand is decided by the Control.

#### Register Name and Conventions 
| Name  | Number | Use |
| :-------------: | :-------------: | :-------------: |
|```X0-X6```  | 0-6  | Random Purpose Registers |
| ```X7``` | 7  | Always Zero |

## Components
### Instruction Memory
When the computer is ran, instruction memory is preloaded with the proper instructions that are to be performed. The program counter, which starts at 0, is inputed into the read address of instruction memory and instruction memory returns the 16 bit instruction at the designed address.
Instruction memory is 256 lines long with each line being 2 bytes. This is because each instruction is 16 bit. This also means instructions of at most 256 lines are supported. The 16 bit output instruction is decoded by Control and multiplexers. The implementation of instruction memory is in ```imem.v```.
### Register File
The Register File is a asynchronous memory unit that is designed to emulate the fast memory that is stored in CPU registers. Since there are only 8 addressable registers, there are only 8 registers initialized in the file. The register file recieves 4 inputs, ```Read register 1```, ```Read register 2```, ```Read register 2```, ```Write Register```, and```Write data```. ```Write Register```, and ```Write data``` are both decided by the control and will be explained in the control section. ```Read register 1``` is always ```instruction ``` 
### ALU
#### ALU Control
### Data Memory
### Control
| Opcode | Command | Jump | branch | memwrite | regwrite | alusrc | reg_dest | memtoreg |
|:--------:|:---------:|:------:|:--------:|:----------:|:----------:|:--------:|:----------:|:----------:|
| 000    | R-Type  | 0    | 0      | 0        | 1        | 0      | 0        | 0        |
| 001    | ADDI    | 0    | 0      | 0        | 1        | 1      | 1        | 0        |
| 010    | SUBI    | 0    | 0      | 0        | 1        | 1      | 1        | 0        |
| 011    | ST      | 0    | 0      | 1        | 0        | 1      | 1        | 0        |
| 100    | LD      | 0    | 0      | 0        | 1        | 1      | 1        | 1        |
| 101    | Jump    | 1    | 0      | 0        | 0        | 0      | 0        | 0        |
| 101    | BEQ     | 0    | 1      | 0        | 0        | 0      | 0        | 0        |
## Data Path

## 

## How to Run Instructions
To run the instructions type the the compiled machine code into ``precode.txt``, dashes can be used to help write the code and make it easier to view. Then run ``./remover.sh`` to remove the dashes and also move the machne code into ``code.txt`` where the computer reads it from. To run the program, compile ```cpu.v``` using ```iverilog -o cpu cpu.v```.  

## Sample Programs
### Fibonacci
The first sample program is an iterative function to caclulate the nth Fibonacci number.

#### C Code
```c
int fib(int i) {
    int num1 = 0;
    int num2 = 1;
    int num3;

    for(int n = 1; n < i; n++){
        num3 = num1 + num2;
        num1 = num2;
        num2 = num3;
    }
    return num1;
} 
```

#### Assembly Code

Assume ``X1 = num1``, ``X2 = num2``, ``X3 = num3``, ``X5 = n``, and ``X0 = i``. Result in ``X1``.
```
    ADDI X2, XZR, #1    //Set X2 to be 1
    ADDI X5, XZR, #1    //Sets counts to start at 1
    ADDI X6, XZR, #1    //Sets X6 to ve zero to check later
    ADDI x0, XZR, #7    //Sets X0 to the fib number we want to calculate
FIB:
    ADD  X3, X2, X1     //X3 equal to two previous answers
    ADD  X1, X2, XZR    //X1 = X2
    ADD  X2, X3, XZR    //X2 = X3
    ADDI X5, X5, #1     //Adds 1 to the count
    SLT  X4, X5, X0     //Checks if the count is less than the input
    BEQ  X4, X6, FIB    //If The count is less than the input, the program branches to fib
HALT                    //Stops the program

```
#### Machine Code 
```
0011110100000001
0011111010000001
0011111100000001
0011110000000111
0000100010110000
0000101110010000
0000111110100000
0011011010000001
0001010001000011
1101001100000100
1111111111111111
```

### Sample Program 2
Since the first sample program did not show loading, storing, or an unconditional branch, a second sample program was created to display these features.

#### Assembly Code
```
    ADDI X0, XZR, #3    //X0 = 3 
    ADDI X1, XZR, #5    //X1 = 5
    ST   X0, [X2, #0]   //Stores X0 in the address stored in X2
    ST   X1, [X2, #1]   //Stores X1 in the address stored in X2 shifted over 2 bytes
    J    Skip           //Jumps to skip
    SUBI X0, X1, #1     //X0 = X1 - 1
    ST   X0, [X2, #0]   //Stores X0 in X2
Skip:
    LD   X3, [X2, #0]   //Loads 3 since it skipped storing 4
    LD   X4, [X2, #1]   //Loads 5
HALT                    //Stops the Program
```

#### Machine Code
```
0011110000000011
0011110010000101
0110100000000000
0110100010000001
1010000000000111
0100010000000001
0110100000000000
1000100110000000
1000101000000001
1111111111111111
```

### Sample Program 3
This sample program is meant to test all of the alu opperations that were not shown in the previous two examples, to show that they work.

#### Assembly Code
```
ADDI X0, XZR, #13   //Sets X0 to be 1101
ADDI X1, XZR, #2    //Sets X1 to ve 0010
ADD  X2, X0,  X1    //X2 = X0 + X1, should be 1111
SUB  X2, X0,  X1    //X2 = X0 - X1, should be 1011
LSL  X2, X0,  X1    //X2 = X0 << X1, should be 110100
SLT  X2, X0,  X1    //Test is X0 < X1, should be 0
AND  X2, X0,  X1    //X2 = X0 & X1, should be 0000
OR   X2, X0,  X1    //X2 = X0 | X1, should be 1111
Not  X2, X0         //X2 = !X1, should be 0010 (leading 0s become 1s)
XOR  X2, X0,  X1    //X2 = X0 ^ X1, should be 1111
HALT                //Stops the program
```

#### Machine Code
```
0011110000001101
0011110010000010
0000000010100000
0000000010100001
0000000010100010
0000000010100011
0000000010100100
0000000010100101
0000001110100110
0000000010100111
1111111111111111
```

# time diagrams

