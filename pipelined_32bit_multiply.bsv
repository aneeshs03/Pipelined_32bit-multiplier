// Pipe-lined 32-bit integer multiplier.

package pipelined_32bit_multiply;

   import Vector :: * ;
  import DReg :: *;
  `define bitsize 32 
  
 interface Ifc_multiplier_prod;
		method Action get_inp(Bit#(`bitsize) multiplicand, Bit#(`bitsize) multiplier);
		method Tuple2#(Bit#(1),Bit#(TMul#(2, `bitsize))) get_out;
 endinterface: Ifc_multiplier_prod
 
  (* synthesize *)
  module mk_Testbench (Empty);
    Ifc_multiplier_prod a <- mk_Multiply;
    rule rl_input;    
        a.get_inp(32'd17,32'd2);    //Input
    endrule
    rule rl_output;
        match {.sign_fin,.mul_product} = a.get_out();
        $display ("\nProduct of Multiplicand and multiplier : %b", mul_product);
        
        $finish ();      
    endrule
 endmodule
  
  (*synthesize*)
  module mk_Multiply(Ifc_multiplier_prod);
     
	    Reg#(Bit#(80)) partial_prod0 <- mkReg(0); 
	    Reg#(Bit#(80)) partial_prod1 <- mkReg(0);
	    Reg#(Bit#(80)) partial_prod2 <- mkReg(0);
	    Reg#(Bit#(80)) partial_prod3 <- mkReg(0);
	    Reg#(Bit#(66)) intermed_prod1 <- mkReg(0);
	    Reg#(Bit#(66)) intermed_prod2 <- mkReg(0);
	    Reg#(Bit#(66)) result <- mkReg(0);
	    Reg#(Bit#(`bitsize)) number1 <- mkReg(0);
	    Reg#(Bit#(`bitsize)) number2 <- mkReg(0);
	    Reg#(Bit#(1)) sign <- mkReg(0);
	    Reg#(Bit#(1)) sign_rule1 <- mkReg(0);
	    Reg#(Bit#(1)) sign_rule2 <- mkReg(0);
	    Reg#(Bit#(1)) sign_rule3 <- mkReg(0);
	    
	    Reg#(Bool) status_stage1 <- mkReg (False);
	    Reg#(Bool) status_stage2 <- mkReg (False);
	    Reg#(Bool) status_stage3 <- mkReg (False);
	    Reg#(Bool) status_stage4 <- mkReg (False);

   //Partial products of multiplication & Shifting of bits
 	  function Bit#(80) fn_partial_prod(Bit#(32) p,Bit#(8) q);                   

	      Bit#(40) r=zeroExtend(p);
	      Bit#(40) sm1=0;
	      Bit#(40) sm2=0;
	      Bit#(40) sm3=0;
	      Bit#(40) sm4=0;
	      Bit#(40) sm5=0;
	      Bit#(40) sm6=0;
	      Bit#(40) sm7=0;
	      Bit#(40) sm8=0;
	      Bit#(40) sum1_prime=0;
	      Bit#(40) sum2_prime=0;
	      Bit#(80) sum=0;
     //shifting of reqd. # of bits
	      sm1 = (q[0]==1'b0)?40'd0:(r);
	      sm2 = (q[1]==1'b0)?40'd0:(r<<1);
	      sm3 = (q[2]==1'b0)?40'd0:(r<<2);
	      sm4 = (q[3]==1'b0)?40'd0:(r<<3);
	      sm5 = (q[4]==1'b0)?40'd0:(r<<4);
	      sm6 = (q[5]==1'b0)?40'd0:(r<<5);
	      sm7 = (q[6]==1'b0)?40'd0:(r<<6);
	      sm8 = (q[7]==1'b0)?40'd0:(r<<7);
	      sum1_prime =  sm1+sm2+sm3+sm4;
	      sum2_prime =  sm5+sm6+sm7+sm8;
	      sum= {sum1_prime,sum2_prime};
	      return sum;        
    endfunction
    
    // Stage 1: Partial products Evaluation
 	  rule rlstg1_partial_prod(status_stage1);
              partial_prod0<=fn_partial_prod(number1,number2[7:0]);
	      partial_prod1<= fn_partial_prod(number1,number2[15:8]);
	      partial_prod2<=fn_partial_prod(number1,number2[23:16]);
	      partial_prod3<=fn_partial_prod(number1,number2[31:24]);
	      sign_rule1 <= sign;
	      status_stage2 <= True;
  	 endrule
    
    // stage 2:Formation of the intermediate products
    rule rlstg2_partial_prod(status_stage2);
	  intermed_prod1<= {26'd0,(partial_prod0[39:0])}+{26'd0,partial_prod0[79:40]}+{18'd0,(partial_prod1[39:0]),8'd0}+{18'd0,(partial_prod1[79:40]),8'd0};     
	  intermed_prod2 <= {10'd0,(partial_prod2[39:0]),16'd0}+{10'd0,(partial_prod2[79:40]),16'd0}+{2'd0,(partial_prod3[39:0]),24'd0}+{2'd0,(partial_prod3[79:40]),24'd0};  
	      sign_rule2 <= sign_rule1;
	      status_stage3 <= True;
    endrule
    
    //Stage 3: Final Product 
   rule rlstg3_partial_prod(status_stage3); 
	      result<= intermed_prod1+intermed_prod2; 
	      sign_rule3 <= sign_rule2;
	      status_stage4 <= True;
    endrule
    
    // For negative inputs
    method Action get_inp(Bit#(`bitsize) multiplicand, Bit#(`bitsize) multiplier) if (!status_stage1);
      Bit#(1) signp = multiplicand[valueOf(`bitsize) - 1];
      Bit#(1) signq = multiplier[valueOf(`bitsize) - 1];
      Bit#(`bitsize) op_partial_prod1 =0;
      Bit#(`bitsize) op_partial_prod2 =0;
      
      if ((signp)==0) 
      begin op_partial_prod1 = multiplicand; 
      end
      else 
      begin op_partial_prod1 = (~multiplicand)+ 32'd1; 
      end
      if ((signq)==0) 
      begin op_partial_prod2 = multiplier; 
      end
      else 
      begin op_partial_prod2 = (~multiplier)+ 32'd1; 
      end
      number1 <= op_partial_prod1;
      number2 <= op_partial_prod2;
      
      sign <= (signq)^(signp);
      status_stage1 <= True;
    
    endmethod
    
    //Sign check and output
    method Tuple2#(Bit#(1),Bit#(TMul#(2, `bitsize))) get_out if(status_stage1 && status_stage4);
	     Bit#(TMul#(2, `bitsize)) out=0;
	      if (sign_rule3==1)
			out =~(result[63:0])+ 64'd1; 
	      else
			out = result[63:0]; 
	      
	      return tuple2(sign_rule3,out);
	    endmethod

   endmodule
endpackage
//************************//
