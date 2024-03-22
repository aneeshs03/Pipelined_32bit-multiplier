//
// Generated by Bluespec Compiler, version 2021.12.1 (build fd501401)
//
// On Fri Mar 22 11:32:22 IST 2024
//
//
// Ports:
// Name                         I/O  size props
// RDY_get_inp                    O     1
// get_out_fst                    O     1 reg
// RDY_get_out_fst                O     1
// get_out_snd                    O    64
// RDY_get_out_snd                O     1
// CLK                            I     1 clock
// RST_N                          I     1 reset
// get_inp_multiplicand           I    32
// get_inp_multiplier             I    32
// EN_get_inp                     I     1
//
// No combinational paths from inputs to outputs
//
//

`ifdef BSV_ASSIGNMENT_DELAY
`else
  `define BSV_ASSIGNMENT_DELAY
`endif

`ifdef BSV_POSITIVE_RESET
  `define BSV_RESET_VALUE 1'b1
  `define BSV_RESET_EDGE posedge
`else
  `define BSV_RESET_VALUE 1'b0
  `define BSV_RESET_EDGE negedge
`endif

module mk_Multiply(CLK,
		   RST_N,

		   get_inp_multiplicand,
		   get_inp_multiplier,
		   EN_get_inp,
		   RDY_get_inp,

		   get_out_fst,
		   RDY_get_out_fst,

		   get_out_snd,
		   RDY_get_out_snd);
  input  CLK;
  input  RST_N;

  // action method get_inp
  input  [31 : 0] get_inp_multiplicand;
  input  [31 : 0] get_inp_multiplier;
  input  EN_get_inp;
  output RDY_get_inp;

  // value method get_out_fst
  output get_out_fst;
  output RDY_get_out_fst;

  // value method get_out_snd
  output [63 : 0] get_out_snd;
  output RDY_get_out_snd;

  // signals for module outputs
  wire [63 : 0] get_out_snd;
  wire RDY_get_inp, RDY_get_out_fst, RDY_get_out_snd, get_out_fst;

  // register intermed_prod1
  reg [65 : 0] intermed_prod1;
  wire [65 : 0] intermed_prod1$D_IN;
  wire intermed_prod1$EN;

  // register intermed_prod2
  reg [65 : 0] intermed_prod2;
  wire [65 : 0] intermed_prod2$D_IN;
  wire intermed_prod2$EN;

  // register number1
  reg [31 : 0] number1;
  wire [31 : 0] number1$D_IN;
  wire number1$EN;

  // register number2
  reg [31 : 0] number2;
  wire [31 : 0] number2$D_IN;
  wire number2$EN;

  // register partial_prod0
  reg [79 : 0] partial_prod0;
  wire [79 : 0] partial_prod0$D_IN;
  wire partial_prod0$EN;

  // register partial_prod1
  reg [79 : 0] partial_prod1;
  wire [79 : 0] partial_prod1$D_IN;
  wire partial_prod1$EN;

  // register partial_prod2
  reg [79 : 0] partial_prod2;
  wire [79 : 0] partial_prod2$D_IN;
  wire partial_prod2$EN;

  // register partial_prod3
  reg [79 : 0] partial_prod3;
  wire [79 : 0] partial_prod3$D_IN;
  wire partial_prod3$EN;

  // register result
  reg [65 : 0] result;
  wire [65 : 0] result$D_IN;
  wire result$EN;

  // register sign
  reg sign;
  wire sign$D_IN, sign$EN;

  // register sign_rule1
  reg sign_rule1;
  wire sign_rule1$D_IN, sign_rule1$EN;

  // register sign_rule2
  reg sign_rule2;
  wire sign_rule2$D_IN, sign_rule2$EN;

  // register sign_rule3
  reg sign_rule3;
  wire sign_rule3$D_IN, sign_rule3$EN;

  // register status_stage1
  reg status_stage1;
  wire status_stage1$D_IN, status_stage1$EN;

  // register status_stage2
  reg status_stage2;
  wire status_stage2$D_IN, status_stage2$EN;

  // register status_stage3
  reg status_stage3;
  wire status_stage3$D_IN, status_stage3$EN;

  // register status_stage4
  reg status_stage4;
  wire status_stage4$D_IN, status_stage4$EN;

  // remaining internal signals
  wire [65 : 0] x__h1922,
		x__h1924,
		x__h1926,
		x__h2049,
		x__h2051,
		x__h2053,
		y__h1923,
		y__h1925,
		y__h1927,
		y__h2050,
		y__h2052,
		y__h2054;
  wire [63 : 0] out__h2457;
  wire [39 : 0] r__h1559,
		sm1__h1266,
		sm1__h1571,
		sm1__h641,
		sm1__h961,
		sm2__h1267,
		sm2__h1572,
		sm2__h642,
		sm2__h962,
		sm3__h1268,
		sm3__h1573,
		sm3__h643,
		sm3__h963,
		sm4__h1269,
		sm4__h1574,
		sm4__h644,
		sm4__h964,
		sm5__h1270,
		sm5__h1575,
		sm5__h645,
		sm5__h965,
		sm6__h1271,
		sm6__h1576,
		sm6__h646,
		sm6__h966,
		sm7__h1272,
		sm7__h1577,
		sm7__h647,
		sm7__h967,
		sm8__h1273,
		sm8__h1578,
		sm8__h648,
		sm8__h968,
		sum1_prime__h1274,
		sum1_prime__h1579,
		sum1_prime__h649,
		sum1_prime__h969,
		sum2_prime__h1275,
		sum2_prime__h1580,
		sum2_prime__h650,
		sum2_prime__h970,
		x__h1122,
		x__h1123,
		x__h1293,
		x__h1294,
		x__h1427,
		x__h1428,
		x__h1598,
		x__h1599,
		x__h1732,
		x__h1733,
		x__h668,
		x__h669,
		x__h819,
		x__h820,
		x__h988,
		x__h989;
  wire [31 : 0] op_partial_prod1__h2350, op_partial_prod2__h2405;

  // action method get_inp
  assign RDY_get_inp = !status_stage1 ;

  // value method get_out_fst
  assign get_out_fst = sign_rule3 ;
  assign RDY_get_out_fst = status_stage1 && status_stage4 ;

  // value method get_out_snd
  assign get_out_snd = sign_rule3 ? out__h2457 : result[63:0] ;
  assign RDY_get_out_snd = status_stage1 && status_stage4 ;

  // register intermed_prod1
  assign intermed_prod1$D_IN = x__h1922 + y__h1923 ;
  assign intermed_prod1$EN = status_stage2 ;

  // register intermed_prod2
  assign intermed_prod2$D_IN = x__h2049 + y__h2050 ;
  assign intermed_prod2$EN = status_stage2 ;

  // register number1
  assign number1$D_IN =
	     get_inp_multiplicand[31] ?
	       op_partial_prod1__h2350 :
	       get_inp_multiplicand ;
  assign number1$EN = EN_get_inp ;

  // register number2
  assign number2$D_IN =
	     get_inp_multiplier[31] ?
	       op_partial_prod2__h2405 :
	       get_inp_multiplier ;
  assign number2$EN = EN_get_inp ;

  // register partial_prod0
  assign partial_prod0$D_IN = { sum1_prime__h649, sum2_prime__h650 } ;
  assign partial_prod0$EN = status_stage1 ;

  // register partial_prod1
  assign partial_prod1$D_IN = { sum1_prime__h969, sum2_prime__h970 } ;
  assign partial_prod1$EN = status_stage1 ;

  // register partial_prod2
  assign partial_prod2$D_IN = { sum1_prime__h1274, sum2_prime__h1275 } ;
  assign partial_prod2$EN = status_stage1 ;

  // register partial_prod3
  assign partial_prod3$D_IN = { sum1_prime__h1579, sum2_prime__h1580 } ;
  assign partial_prod3$EN = status_stage1 ;

  // register result
  assign result$D_IN = intermed_prod1 + intermed_prod2 ;
  assign result$EN = status_stage3 ;

  // register sign
  assign sign$D_IN = get_inp_multiplier[31] ^ get_inp_multiplicand[31] ;
  assign sign$EN = EN_get_inp ;

  // register sign_rule1
  assign sign_rule1$D_IN = sign ;
  assign sign_rule1$EN = status_stage1 ;

  // register sign_rule2
  assign sign_rule2$D_IN = sign_rule1 ;
  assign sign_rule2$EN = status_stage2 ;

  // register sign_rule3
  assign sign_rule3$D_IN = sign_rule2 ;
  assign sign_rule3$EN = status_stage3 ;

  // register status_stage1
  assign status_stage1$D_IN = 1'd1 ;
  assign status_stage1$EN = EN_get_inp ;

  // register status_stage2
  assign status_stage2$D_IN = 1'd1 ;
  assign status_stage2$EN = status_stage1 ;

  // register status_stage3
  assign status_stage3$D_IN = 1'd1 ;
  assign status_stage3$EN = status_stage2 ;

  // register status_stage4
  assign status_stage4$D_IN = 1'd1 ;
  assign status_stage4$EN = status_stage3 ;

  // remaining internal signals
  assign op_partial_prod1__h2350 = ~get_inp_multiplicand + 32'd1 ;
  assign op_partial_prod2__h2405 = ~get_inp_multiplier + 32'd1 ;
  assign out__h2457 = ~result[63:0] + 64'd1 ;
  assign r__h1559 = { 8'd0, number1 } ;
  assign sm1__h1266 = number2[16] ? r__h1559 : 40'd0 ;
  assign sm1__h1571 = number2[24] ? r__h1559 : 40'd0 ;
  assign sm1__h641 = number2[0] ? r__h1559 : 40'd0 ;
  assign sm1__h961 = number2[8] ? r__h1559 : 40'd0 ;
  assign sm2__h1267 = number2[17] ? { 7'd0, number1, 1'd0 } : 40'd0 ;
  assign sm2__h1572 = number2[25] ? { 7'd0, number1, 1'd0 } : 40'd0 ;
  assign sm2__h642 = number2[1] ? { 7'd0, number1, 1'd0 } : 40'd0 ;
  assign sm2__h962 = number2[9] ? { 7'd0, number1, 1'd0 } : 40'd0 ;
  assign sm3__h1268 = number2[18] ? { 6'd0, number1, 2'd0 } : 40'd0 ;
  assign sm3__h1573 = number2[26] ? { 6'd0, number1, 2'd0 } : 40'd0 ;
  assign sm3__h643 = number2[2] ? { 6'd0, number1, 2'd0 } : 40'd0 ;
  assign sm3__h963 = number2[10] ? { 6'd0, number1, 2'd0 } : 40'd0 ;
  assign sm4__h1269 = number2[19] ? { 5'd0, number1, 3'd0 } : 40'd0 ;
  assign sm4__h1574 = number2[27] ? { 5'd0, number1, 3'd0 } : 40'd0 ;
  assign sm4__h644 = number2[3] ? { 5'd0, number1, 3'd0 } : 40'd0 ;
  assign sm4__h964 = number2[11] ? { 5'd0, number1, 3'd0 } : 40'd0 ;
  assign sm5__h1270 = number2[20] ? { 4'd0, number1, 4'd0 } : 40'd0 ;
  assign sm5__h1575 = number2[28] ? { 4'd0, number1, 4'd0 } : 40'd0 ;
  assign sm5__h645 = number2[4] ? { 4'd0, number1, 4'd0 } : 40'd0 ;
  assign sm5__h965 = number2[12] ? { 4'd0, number1, 4'd0 } : 40'd0 ;
  assign sm6__h1271 = number2[21] ? { 3'd0, number1, 5'd0 } : 40'd0 ;
  assign sm6__h1576 = number2[29] ? { 3'd0, number1, 5'd0 } : 40'd0 ;
  assign sm6__h646 = number2[5] ? { 3'd0, number1, 5'd0 } : 40'd0 ;
  assign sm6__h966 = number2[13] ? { 3'd0, number1, 5'd0 } : 40'd0 ;
  assign sm7__h1272 = number2[22] ? { 2'd0, number1, 6'd0 } : 40'd0 ;
  assign sm7__h1577 = number2[30] ? { 2'd0, number1, 6'd0 } : 40'd0 ;
  assign sm7__h647 = number2[6] ? { 2'd0, number1, 6'd0 } : 40'd0 ;
  assign sm7__h967 = number2[14] ? { 2'd0, number1, 6'd0 } : 40'd0 ;
  assign sm8__h1273 = number2[23] ? { 1'd0, number1, 7'd0 } : 40'd0 ;
  assign sm8__h1578 = number2[31] ? { 1'd0, number1, 7'd0 } : 40'd0 ;
  assign sm8__h648 = number2[7] ? { 1'd0, number1, 7'd0 } : 40'd0 ;
  assign sm8__h968 = number2[15] ? { 1'd0, number1, 7'd0 } : 40'd0 ;
  assign sum1_prime__h1274 = x__h1293 + sm4__h1269 ;
  assign sum1_prime__h1579 = x__h1598 + sm4__h1574 ;
  assign sum1_prime__h649 = x__h668 + sm4__h644 ;
  assign sum1_prime__h969 = x__h988 + sm4__h964 ;
  assign sum2_prime__h1275 = x__h1427 + sm8__h1273 ;
  assign sum2_prime__h1580 = x__h1732 + sm8__h1578 ;
  assign sum2_prime__h650 = x__h819 + sm8__h648 ;
  assign sum2_prime__h970 = x__h1122 + sm8__h968 ;
  assign x__h1122 = x__h1123 + sm7__h967 ;
  assign x__h1123 = sm5__h965 + sm6__h966 ;
  assign x__h1293 = x__h1294 + sm3__h1268 ;
  assign x__h1294 = sm1__h1266 + sm2__h1267 ;
  assign x__h1427 = x__h1428 + sm7__h1272 ;
  assign x__h1428 = sm5__h1270 + sm6__h1271 ;
  assign x__h1598 = x__h1599 + sm3__h1573 ;
  assign x__h1599 = sm1__h1571 + sm2__h1572 ;
  assign x__h1732 = x__h1733 + sm7__h1577 ;
  assign x__h1733 = sm5__h1575 + sm6__h1576 ;
  assign x__h1922 = x__h1924 + y__h1925 ;
  assign x__h1924 = x__h1926 + y__h1927 ;
  assign x__h1926 = { 26'd0, partial_prod0[39:0] } ;
  assign x__h2049 = x__h2051 + y__h2052 ;
  assign x__h2051 = x__h2053 + y__h2054 ;
  assign x__h2053 = { 10'd0, partial_prod2[39:0], 16'd0 } ;
  assign x__h668 = x__h669 + sm3__h643 ;
  assign x__h669 = sm1__h641 + sm2__h642 ;
  assign x__h819 = x__h820 + sm7__h647 ;
  assign x__h820 = sm5__h645 + sm6__h646 ;
  assign x__h988 = x__h989 + sm3__h963 ;
  assign x__h989 = sm1__h961 + sm2__h962 ;
  assign y__h1923 = { 18'd0, partial_prod1[79:40], 8'd0 } ;
  assign y__h1925 = { 18'd0, partial_prod1[39:0], 8'd0 } ;
  assign y__h1927 = { 26'd0, partial_prod0[79:40] } ;
  assign y__h2050 = { 2'd0, partial_prod3[79:40], 24'd0 } ;
  assign y__h2052 = { 2'd0, partial_prod3[39:0], 24'd0 } ;
  assign y__h2054 = { 10'd0, partial_prod2[79:40], 16'd0 } ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        intermed_prod1 <= `BSV_ASSIGNMENT_DELAY 66'd0;
	intermed_prod2 <= `BSV_ASSIGNMENT_DELAY 66'd0;
	number1 <= `BSV_ASSIGNMENT_DELAY 32'd0;
	number2 <= `BSV_ASSIGNMENT_DELAY 32'd0;
	partial_prod0 <= `BSV_ASSIGNMENT_DELAY 80'd0;
	partial_prod1 <= `BSV_ASSIGNMENT_DELAY 80'd0;
	partial_prod2 <= `BSV_ASSIGNMENT_DELAY 80'd0;
	partial_prod3 <= `BSV_ASSIGNMENT_DELAY 80'd0;
	result <= `BSV_ASSIGNMENT_DELAY 66'd0;
	sign <= `BSV_ASSIGNMENT_DELAY 1'd0;
	sign_rule1 <= `BSV_ASSIGNMENT_DELAY 1'd0;
	sign_rule2 <= `BSV_ASSIGNMENT_DELAY 1'd0;
	sign_rule3 <= `BSV_ASSIGNMENT_DELAY 1'd0;
	status_stage1 <= `BSV_ASSIGNMENT_DELAY 1'd0;
	status_stage2 <= `BSV_ASSIGNMENT_DELAY 1'd0;
	status_stage3 <= `BSV_ASSIGNMENT_DELAY 1'd0;
	status_stage4 <= `BSV_ASSIGNMENT_DELAY 1'd0;
      end
    else
      begin
        if (intermed_prod1$EN)
	  intermed_prod1 <= `BSV_ASSIGNMENT_DELAY intermed_prod1$D_IN;
	if (intermed_prod2$EN)
	  intermed_prod2 <= `BSV_ASSIGNMENT_DELAY intermed_prod2$D_IN;
	if (number1$EN) number1 <= `BSV_ASSIGNMENT_DELAY number1$D_IN;
	if (number2$EN) number2 <= `BSV_ASSIGNMENT_DELAY number2$D_IN;
	if (partial_prod0$EN)
	  partial_prod0 <= `BSV_ASSIGNMENT_DELAY partial_prod0$D_IN;
	if (partial_prod1$EN)
	  partial_prod1 <= `BSV_ASSIGNMENT_DELAY partial_prod1$D_IN;
	if (partial_prod2$EN)
	  partial_prod2 <= `BSV_ASSIGNMENT_DELAY partial_prod2$D_IN;
	if (partial_prod3$EN)
	  partial_prod3 <= `BSV_ASSIGNMENT_DELAY partial_prod3$D_IN;
	if (result$EN) result <= `BSV_ASSIGNMENT_DELAY result$D_IN;
	if (sign$EN) sign <= `BSV_ASSIGNMENT_DELAY sign$D_IN;
	if (sign_rule1$EN)
	  sign_rule1 <= `BSV_ASSIGNMENT_DELAY sign_rule1$D_IN;
	if (sign_rule2$EN)
	  sign_rule2 <= `BSV_ASSIGNMENT_DELAY sign_rule2$D_IN;
	if (sign_rule3$EN)
	  sign_rule3 <= `BSV_ASSIGNMENT_DELAY sign_rule3$D_IN;
	if (status_stage1$EN)
	  status_stage1 <= `BSV_ASSIGNMENT_DELAY status_stage1$D_IN;
	if (status_stage2$EN)
	  status_stage2 <= `BSV_ASSIGNMENT_DELAY status_stage2$D_IN;
	if (status_stage3$EN)
	  status_stage3 <= `BSV_ASSIGNMENT_DELAY status_stage3$D_IN;
	if (status_stage4$EN)
	  status_stage4 <= `BSV_ASSIGNMENT_DELAY status_stage4$D_IN;
      end
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    intermed_prod1 = 66'h2AAAAAAAAAAAAAAAA;
    intermed_prod2 = 66'h2AAAAAAAAAAAAAAAA;
    number1 = 32'hAAAAAAAA;
    number2 = 32'hAAAAAAAA;
    partial_prod0 = 80'hAAAAAAAAAAAAAAAAAAAA;
    partial_prod1 = 80'hAAAAAAAAAAAAAAAAAAAA;
    partial_prod2 = 80'hAAAAAAAAAAAAAAAAAAAA;
    partial_prod3 = 80'hAAAAAAAAAAAAAAAAAAAA;
    result = 66'h2AAAAAAAAAAAAAAAA;
    sign = 1'h0;
    sign_rule1 = 1'h0;
    sign_rule2 = 1'h0;
    sign_rule3 = 1'h0;
    status_stage1 = 1'h0;
    status_stage2 = 1'h0;
    status_stage3 = 1'h0;
    status_stage4 = 1'h0;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on
endmodule  // mk_Multiply

