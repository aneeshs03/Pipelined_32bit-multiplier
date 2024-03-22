# Pipelined_32bit-multiplier
EE23E009 - Aneesh S 
The Bluespec Verilog code implements a pipelined 32-bit integer multiplier.

The code uses Wallace tree concept for multiplication of two numbers. It consists of three stages:

Stage 1: Partial product evaluation

Stage 2: Formation of intermediate products

Stage 3: Addition of intermediate products to get the final result

Registers are used to hold intermediate values and control signals for pipelining. There are functions defined to perform partial product generation and addition. The pipeline structure:

    Generates partial products by multiplying different portions of the two operands. Sets the sign bit for subsequent stages.

    Forming intermediate products by adding partial products appropriately.

    Adds intermediate products to obtain the final result. Sets the sign bit for the output.

The code was tested for different inputs and output was observed.

Bluespec Verilog (BSV) Commands used for compilation of the module/ testbench:

bsc -verilog pipelined_32bit_mul.bsv

bsc -o sim -e mkTestbench mkTestbench.v

./sim

These command are used to generate the synthesis file.

yosys –o output.blif –S mkTestbench.v

yosys> read_verilog mk_Multiply.v

yosys> synth_ecp5 -top mk_Multiply

yosys> write_verilog synthesis_result.v

