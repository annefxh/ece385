/*---------------------------------------------------------------------------
  --      AES.sv                                                           --
  --      Joe Meng                                                         --
  --      Fall 2013                                                        --
  --                                                                       --
  --      Modified by Po-Han Huang 03/09/2017                              --
  --                                                                       --
  --      For use with ECE 385 Experiment 9                                --
  --      Spring 2017 Distribution                                         --
  --      UIUC ECE Department                                              --
  ---------------------------------------------------------------------------*/

// AES decryption core.

// AES module interface with all ports, commented for Week 1
 module  AES ( input                 clk, 
                                     reset_n,
                                     run,
               input        [127:0]  msg_en,
                                     key,
               output logic [127:0]  msg_de,
               output logic          ready);

// Partial interface for Week 1
// Splitting the signals into 32-bit ones for compatibility with ModelSim
/*module  AES ( input                clk,
              input        [31:0]  key_0, key_1, key_2, key_3,
              output logic [31:0]  keyschedule_out_0, keyschedule_out_1, keyschedule_out_2, keyschedule_out_3 );      
*/     
logic [1407:0] keyschedule;  
      
KeyExpansion keyexpansion_0(.clk(clk), 
                            .Cipherkey(key),
                            .KeySchedule(keyschedule)
                            );
 
//assign {keyschedule_out_0, keyschedule_out_1, keyschedule_out_2, keyschedule_out_3} = keyschedule[127:0];

logic [127:0] addroundkey_in, addroundkey_out, rkey;
logic [127:0] invshiftrows_in, invshiftrows_out;
logic [127:0] invsubytes_in, invsubytes_out;
logic [127:0] roundkey, msg_de_in, rkey_in, addroundkey_in_in, invshiftrows_in_in, invsubytes_in_in;
logic [31:0] invmixcolumns_in, invmixcolumns_out, invmixcolumns_in_in;

Addroundkey addroundkey(.in(addroundkey_in),
								.rkey,
								.out(addroundkey_out));
								
Invshiftrows invshiftrows(.in(invshiftrows_in),
								  .out(invshiftrows_out));
								  
Invsubytes invsubytes(.clk,
							 .in(invsubytes_in),
							 .out(invsubytes_out));
							 
InvMixColumns invmixcolumns(.in(invmixcolumns_in),
									 .out(invmixcolumns_out));



// For week 2, write your own state machine here for AES decryption process.
enum logic [8:0] {RESET, WAIT, READY, ADDROUNDKEY_1, INVSHIFTROWS_2, INVSUBYTES_2, INVSUBYTES_2_2,ADDROUNDKEY_2,
						INVMIXCOLUMNS_2_1, INVMIXCOLUMNS_2_2, INVMIXCOLUMNS_2_3, INVMIXCOLUMNS_2_4,
						INVSHIFTROWS_3, INVSUBYTES_3, INVSUBYTES_3_2,ADDROUNDKEY_3,
						INVMIXCOLUMNS_3_1, INVMIXCOLUMNS_3_2, INVMIXCOLUMNS_3_3, INVMIXCOLUMNS_3_4,
						INVSHIFTROWS_4, INVSUBYTES_4, INVSUBYTES_4_2,ADDROUNDKEY_4,
						INVMIXCOLUMNS_4_1, INVMIXCOLUMNS_4_2, INVMIXCOLUMNS_4_3, INVMIXCOLUMNS_4_4,
						INVSHIFTROWS_5, INVSUBYTES_5, INVSUBYTES_5_2,ADDROUNDKEY_5,
						INVMIXCOLUMNS_5_1, INVMIXCOLUMNS_5_2, INVMIXCOLUMNS_5_3, INVMIXCOLUMNS_5_4,
						INVSHIFTROWS_6, INVSUBYTES_6, INVSUBYTES_6_2,ADDROUNDKEY_6,
						INVMIXCOLUMNS_6_1, INVMIXCOLUMNS_6_2, INVMIXCOLUMNS_6_3, INVMIXCOLUMNS_6_4,
						INVSHIFTROWS_7, INVSUBYTES_7, INVSUBYTES_7_2,ADDROUNDKEY_7,
						INVMIXCOLUMNS_7_1, INVMIXCOLUMNS_7_2, INVMIXCOLUMNS_7_3, INVMIXCOLUMNS_7_4,
						INVSHIFTROWS_8, INVSUBYTES_8, INVSUBYTES_8_2,ADDROUNDKEY_8,
						INVMIXCOLUMNS_8_1, INVMIXCOLUMNS_8_2, INVMIXCOLUMNS_8_3, INVMIXCOLUMNS_8_4,
						INVSHIFTROWS_9, INVSUBYTES_9, INVSUBYTES_9_2,ADDROUNDKEY_9,
						INVMIXCOLUMNS_9_1, INVMIXCOLUMNS_9_2, INVMIXCOLUMNS_9_3, INVMIXCOLUMNS_9_4,
						INVSHIFTROWS_10, INVSUBYTES_10, INVSUBYTES_10_2,ADDROUNDKEY_10,
						INVMIXCOLUMNS_10_1, INVMIXCOLUMNS_10_2, INVMIXCOLUMNS_10_3, INVMIXCOLUMNS_10_4,
						INVSHIFTROWS_11, INVSUBYTES_11, INVSUBYTES_11_2,ADDROUNDKEY_11,
						HALT
						} state, next_state;

always_ff @ (posedge clk) begin
	if(reset_n)
		begin
			state <= RESET;
			//msg_de <= 128'b0;
		end
	else
		begin
			state <= next_state;
			unique case(state)
				INVSUBYTES_2:
					msg_de <= invsubytes_out;
			endcase
			/*unique case(state)
				WAIT:
					msg_de <= msg_en;
				ADDROUNDKEY_1:
					begin
						addroundkey_in <= msg_de;
						rkey <= keyschedule[127:0];
						msg_de <= addroundkey_out;
					end
				ADDROUNDKEY_1_2:
					begin
						msg_de <= addroundkey_out;
					end
				INVSHIFTROWS_2:
					invshiftrows_in <= msg_de;
				INVSHIFTROWS_2_2:
					msg_de <= invshiftrows_out;
			endcase*/
			msg_de <= msg_de_in;
			//rkey <= rkey_in;
			//addroundkey_in <= addroundkey_in_in;
			//invshiftrows_in <= invshiftrows_in_in;
			//invsubytes_in <= invsubytes_in_in;
			//invmixcolumns_in <= invmixcolumns_in_in;
		end
	end
           
always_comb
    begin 
		next_state = state;
		
			unique case (state)
				RESET:
					next_state <= WAIT;
				WAIT:
					begin
						if(run)
							next_state = ADDROUNDKEY_1;
						else
							next_state = WAIT;
					end
				ADDROUNDKEY_1:
					next_state <= INVSHIFTROWS_2;
				INVSHIFTROWS_2:
					next_state <= INVSUBYTES_2;
				INVSUBYTES_2:
					next_state <= INVSUBYTES_2_2;
				INVSUBYTES_2_2:
					next_state <= ADDROUNDKEY_2;
				ADDROUNDKEY_2:
					next_state <= INVMIXCOLUMNS_2_1;
				INVMIXCOLUMNS_2_1:
					next_state <= INVMIXCOLUMNS_2_2;
				INVMIXCOLUMNS_2_2:
					next_state <= INVMIXCOLUMNS_2_3;
				INVMIXCOLUMNS_2_3:
					next_state <= INVMIXCOLUMNS_2_4;
				INVMIXCOLUMNS_2_4:
					next_state <= INVSHIFTROWS_3;
				INVSHIFTROWS_3:
					next_state <= INVSUBYTES_3;
				INVSUBYTES_3:
					next_state <= INVSUBYTES_3_2;
				INVSUBYTES_3_2:
					next_state <= ADDROUNDKEY_3;
				ADDROUNDKEY_3:
					next_state <= INVMIXCOLUMNS_3_1;
				INVMIXCOLUMNS_3_1:
					next_state <= INVMIXCOLUMNS_3_2;
				INVMIXCOLUMNS_3_2:
					next_state <= INVMIXCOLUMNS_3_3;
				INVMIXCOLUMNS_3_3:
					next_state <= INVMIXCOLUMNS_3_4;
				INVMIXCOLUMNS_3_4:
					next_state <= INVSHIFTROWS_4;
				INVSHIFTROWS_4:
					next_state <= INVSUBYTES_4;
				INVSUBYTES_4:
					next_state <= INVSUBYTES_4_2;
				INVSUBYTES_4_2:
					next_state <= ADDROUNDKEY_4;
				ADDROUNDKEY_4:
					next_state <= INVMIXCOLUMNS_4_1;
				INVMIXCOLUMNS_4_1:
					next_state <= INVMIXCOLUMNS_4_2;
				INVMIXCOLUMNS_4_2:
					next_state <= INVMIXCOLUMNS_4_3;
				INVMIXCOLUMNS_4_3:
					next_state <= INVMIXCOLUMNS_4_4;
				INVMIXCOLUMNS_4_4:
					next_state <= INVSHIFTROWS_5;
				INVSHIFTROWS_5:
					next_state <= INVSUBYTES_5;
				INVSUBYTES_5:
					next_state <= INVSUBYTES_5_2;
				INVSUBYTES_5_2:
					next_state <= ADDROUNDKEY_5;
				ADDROUNDKEY_5:
					next_state <= INVMIXCOLUMNS_5_1;
				INVMIXCOLUMNS_5_1:
					next_state <= INVMIXCOLUMNS_5_2;
				INVMIXCOLUMNS_5_2:
					next_state <= INVMIXCOLUMNS_5_3;
				INVMIXCOLUMNS_5_3:
					next_state <= INVMIXCOLUMNS_5_4;
				INVMIXCOLUMNS_5_4:
					next_state <= INVSHIFTROWS_6;
				INVSHIFTROWS_6:
					next_state <= INVSUBYTES_6;
				INVSUBYTES_6:
					next_state <= INVSUBYTES_6_2;
				INVSUBYTES_6_2:
					next_state <= ADDROUNDKEY_6;
				ADDROUNDKEY_6:
					next_state <= INVMIXCOLUMNS_6_1;
				INVMIXCOLUMNS_6_1:
					next_state <= INVMIXCOLUMNS_6_2;
				INVMIXCOLUMNS_6_2:
					next_state <= INVMIXCOLUMNS_6_3;
				INVMIXCOLUMNS_6_3:
					next_state <= INVMIXCOLUMNS_6_4;
				INVMIXCOLUMNS_6_4:
					next_state <= INVSHIFTROWS_7;
				INVSHIFTROWS_7:
					next_state <= INVSUBYTES_7;
				INVSUBYTES_7:
					next_state <= INVSUBYTES_7_2;
				INVSUBYTES_7_2:
					next_state <= ADDROUNDKEY_7;
				ADDROUNDKEY_7:
					next_state <= INVMIXCOLUMNS_7_1;
				INVMIXCOLUMNS_7_1:
					next_state <= INVMIXCOLUMNS_7_2;
				INVMIXCOLUMNS_7_2:
					next_state <= INVMIXCOLUMNS_7_3;
				INVMIXCOLUMNS_7_3:
					next_state <= INVMIXCOLUMNS_7_4;
				INVMIXCOLUMNS_7_4:
					next_state <= INVSHIFTROWS_8;		
				INVSHIFTROWS_8:
					next_state <= INVSUBYTES_8;
				INVSUBYTES_8:
					next_state <= INVSUBYTES_8_2;
				INVSUBYTES_8_2:
					next_state <= ADDROUNDKEY_8;
				ADDROUNDKEY_8:
					next_state <= INVMIXCOLUMNS_8_1;
				INVMIXCOLUMNS_8_1:
					next_state <= INVMIXCOLUMNS_8_2;
				INVMIXCOLUMNS_8_2:
					next_state <= INVMIXCOLUMNS_8_3;
				INVMIXCOLUMNS_8_3:
					next_state <= INVMIXCOLUMNS_8_4;
				INVMIXCOLUMNS_8_4:
					next_state <= INVSHIFTROWS_9;
				INVSHIFTROWS_9:
					next_state <= INVSUBYTES_9;
				INVSUBYTES_9:
					next_state <= INVSUBYTES_9_2;
				INVSUBYTES_9_2:
					next_state <= ADDROUNDKEY_9;
				ADDROUNDKEY_9:
					next_state <= INVMIXCOLUMNS_9_1;
				INVMIXCOLUMNS_9_1:
					next_state <= INVMIXCOLUMNS_9_2;
				INVMIXCOLUMNS_9_2:
					next_state <= INVMIXCOLUMNS_9_3;
				INVMIXCOLUMNS_9_3:
					next_state <= INVMIXCOLUMNS_9_4;
				INVMIXCOLUMNS_9_4:
					next_state <= INVSHIFTROWS_10;
				INVSHIFTROWS_10:
					next_state <= INVSUBYTES_10;
				INVSUBYTES_10:
					next_state <= INVSUBYTES_10_2;
				INVSUBYTES_10_2:
					next_state <= ADDROUNDKEY_10;
				ADDROUNDKEY_10:
					next_state <= INVMIXCOLUMNS_10_1;
				INVMIXCOLUMNS_10_1:
					next_state <= INVMIXCOLUMNS_10_2;
				INVMIXCOLUMNS_10_2:
					next_state <= INVMIXCOLUMNS_10_3;
				INVMIXCOLUMNS_10_3:
					next_state <= INVMIXCOLUMNS_10_4;
				INVMIXCOLUMNS_10_4:
					next_state <= INVSHIFTROWS_11;	
				INVSHIFTROWS_11:
					next_state <= INVSUBYTES_11;
				INVSUBYTES_11:
					next_state <= INVSUBYTES_11_2;
				INVSUBYTES_11_2:
					next_state <= ADDROUNDKEY_11;
				ADDROUNDKEY_11:
					next_state <= HALT;
			endcase
	end
	
always_comb
	begin
	msg_de_in = msg_de;
	rkey = 128'b0;
	addroundkey_in = 128'b0;
	invshiftrows_in = 128'b0;
	invsubytes_in = 128'b0;
	invmixcolumns_in = 32'b0;
	ready = 1'b0;
		case (state)
			RESET:
				msg_de_in = 128'b0;
			WAIT:
				msg_de_in = msg_en;
			ADDROUNDKEY_1:
				begin 
					addroundkey_in= msg_de;
					rkey = keyschedule[127:0];
					msg_de_in = addroundkey_out;
				end
			INVSHIFTROWS_2:
				begin
					invshiftrows_in = msg_de;
					msg_de_in = invshiftrows_out;
				end
			INVSUBYTES_2:
				invsubytes_in = msg_de;
			INVSUBYTES_2_2:
				begin
					invsubytes_in = msg_de;
					msg_de_in = invsubytes_out;
				end
			ADDROUNDKEY_2:
				begin
					addroundkey_in = msg_de;
					rkey = keyschedule[255:128];
					msg_de_in = addroundkey_out;
				end
			INVMIXCOLUMNS_2_1:
				begin
					invmixcolumns_in = msg_de[31:0];
					msg_de_in[31:0] = invmixcolumns_out;
				end
			INVMIXCOLUMNS_2_2:
				begin
					invmixcolumns_in = msg_de[63:32];
					msg_de_in[63:32] = invmixcolumns_out;
				end
			INVMIXCOLUMNS_2_3:
				begin
					invmixcolumns_in = msg_de[95:64];
					msg_de_in[95:64] = invmixcolumns_out;
				end
			INVMIXCOLUMNS_2_4:
				begin
					invmixcolumns_in = msg_de[127:96];
					msg_de_in[127:96] = invmixcolumns_out;
				end
			INVSHIFTROWS_3:
				begin
					invshiftrows_in = msg_de;
					msg_de_in = invshiftrows_out;
				end
			INVSUBYTES_3:
				invsubytes_in = msg_de;
			INVSUBYTES_3_2:
				begin
					invsubytes_in = msg_de;
					msg_de_in = invsubytes_out;
				end
			ADDROUNDKEY_3:
				begin
					addroundkey_in = msg_de;
					rkey = keyschedule[383:256];
					msg_de_in = addroundkey_out;
				end
			INVMIXCOLUMNS_3_1:
				begin
					invmixcolumns_in = msg_de[31:0];
					msg_de_in[31:0] = invmixcolumns_out;
				end
			INVMIXCOLUMNS_3_2:
				begin
					invmixcolumns_in = msg_de[63:32];
					msg_de_in[63:32] = invmixcolumns_out;
				end
			INVMIXCOLUMNS_3_3:
				begin
					invmixcolumns_in = msg_de[95:64];
					msg_de_in[95:64] = invmixcolumns_out;
				end
			INVMIXCOLUMNS_3_4:
				begin
					invmixcolumns_in = msg_de[127:96];
					msg_de_in[127:96] = invmixcolumns_out;
				end
			INVSHIFTROWS_4:
				begin
					invshiftrows_in = msg_de;
					msg_de_in = invshiftrows_out;
				end
			INVSUBYTES_4:
				invsubytes_in = msg_de;
			INVSUBYTES_4_2:
				begin
					invsubytes_in = msg_de;
					msg_de_in = invsubytes_out;
				end
			ADDROUNDKEY_4:
				begin
					addroundkey_in = msg_de;
					rkey = keyschedule[511:384];
					msg_de_in = addroundkey_out;
				end
			INVMIXCOLUMNS_4_1:
				begin
					invmixcolumns_in = msg_de[31:0];
					msg_de_in[31:0] = invmixcolumns_out;
				end
			INVMIXCOLUMNS_4_2:
				begin
					invmixcolumns_in = msg_de[63:32];
					msg_de_in[63:32] = invmixcolumns_out;
				end
			INVMIXCOLUMNS_4_3:
				begin
					invmixcolumns_in = msg_de[95:64];
					msg_de_in[95:64] = invmixcolumns_out;
				end
			INVMIXCOLUMNS_4_4:
				begin
					invmixcolumns_in = msg_de[127:96];
					msg_de_in[127:96] = invmixcolumns_out;
				end
			INVSHIFTROWS_5:
				begin
					invshiftrows_in = msg_de;
					msg_de_in = invshiftrows_out;
				end
			INVSUBYTES_5:
				invsubytes_in = msg_de;
			INVSUBYTES_5_2:
				begin
					invsubytes_in = msg_de;
					msg_de_in = invsubytes_out;
				end
			ADDROUNDKEY_5:
				begin
					addroundkey_in = msg_de;
					rkey = keyschedule[639:512];
					msg_de_in = addroundkey_out;
				end
			INVMIXCOLUMNS_5_1:
				begin
					invmixcolumns_in = msg_de[31:0];
					msg_de_in[31:0] = invmixcolumns_out;
				end
			INVMIXCOLUMNS_5_2:
				begin
					invmixcolumns_in = msg_de[63:32];
					msg_de_in[63:32] = invmixcolumns_out;
				end
			INVMIXCOLUMNS_5_3:
				begin
					invmixcolumns_in = msg_de[95:64];
					msg_de_in[95:64] = invmixcolumns_out;
				end
			INVMIXCOLUMNS_5_4:
				begin
					invmixcolumns_in = msg_de[127:96];
					msg_de_in[127:96] = invmixcolumns_out;
				end
			INVSHIFTROWS_6:
				begin
					invshiftrows_in = msg_de;
					msg_de_in = invshiftrows_out;
				end
			INVSUBYTES_6:
				invsubytes_in = msg_de;
			INVSUBYTES_6_2:
				begin
					invsubytes_in = msg_de;
					msg_de_in = invsubytes_out;
				end
			ADDROUNDKEY_6:
				begin
					addroundkey_in = msg_de;
					rkey = keyschedule[767:640];
					msg_de_in = addroundkey_out;
				end
			INVMIXCOLUMNS_6_1:
				begin
					invmixcolumns_in = msg_de[31:0];
					msg_de_in[31:0] = invmixcolumns_out;
				end
			INVMIXCOLUMNS_6_2:
				begin
					invmixcolumns_in = msg_de[63:32];
					msg_de_in[63:32] = invmixcolumns_out;
				end
			INVMIXCOLUMNS_6_3:
				begin
					invmixcolumns_in = msg_de[95:64];
					msg_de_in[95:64] = invmixcolumns_out;
				end
			INVMIXCOLUMNS_6_4:
				begin
					invmixcolumns_in = msg_de[127:96];
					msg_de_in[127:96] = invmixcolumns_out;
				end
			INVSHIFTROWS_7:
				begin
					invshiftrows_in = msg_de;
					msg_de_in = invshiftrows_out;
				end
			INVSUBYTES_7:
				invsubytes_in = msg_de;
			INVSUBYTES_7_2:
				begin
					invsubytes_in = msg_de;
					msg_de_in = invsubytes_out;
				end
			ADDROUNDKEY_7:
				begin
					addroundkey_in = msg_de;
					rkey = keyschedule[895:768];
					msg_de_in = addroundkey_out;
				end
			INVMIXCOLUMNS_7_1:
				begin
					invmixcolumns_in = msg_de[31:0];
					msg_de_in[31:0] = invmixcolumns_out;
				end
			INVMIXCOLUMNS_7_2:
				begin
					invmixcolumns_in = msg_de[63:32];
					msg_de_in[63:32] = invmixcolumns_out;
				end
			INVMIXCOLUMNS_7_3:
				begin
					invmixcolumns_in = msg_de[95:64];
					msg_de_in[95:64] = invmixcolumns_out;
				end
			INVMIXCOLUMNS_7_4:
				begin
					invmixcolumns_in = msg_de[127:96];
					msg_de_in[127:96] = invmixcolumns_out;
				end
			INVSHIFTROWS_8:
				begin
					invshiftrows_in = msg_de;
					msg_de_in = invshiftrows_out;
				end
			INVSUBYTES_8:
				invsubytes_in = msg_de;
			INVSUBYTES_8_2:
				begin
					invsubytes_in = msg_de;
					msg_de_in = invsubytes_out;
				end
			ADDROUNDKEY_8:
				begin
					addroundkey_in = msg_de;
					rkey = keyschedule[1023:896];
					msg_de_in = addroundkey_out;
				end
			INVMIXCOLUMNS_8_1:
				begin
					invmixcolumns_in = msg_de[31:0];
					msg_de_in[31:0] = invmixcolumns_out;
				end
			INVMIXCOLUMNS_8_2:
				begin
					invmixcolumns_in = msg_de[63:32];
					msg_de_in[63:32] = invmixcolumns_out;
				end
			INVMIXCOLUMNS_8_3:
				begin
					invmixcolumns_in = msg_de[95:64];
					msg_de_in[95:64] = invmixcolumns_out;
				end
			INVMIXCOLUMNS_8_4:
				begin
					invmixcolumns_in = msg_de[127:96];
					msg_de_in[127:96] = invmixcolumns_out;
				end
			INVSHIFTROWS_9:
				begin
					invshiftrows_in = msg_de;
					msg_de_in = invshiftrows_out;
				end
			INVSUBYTES_9:
				invsubytes_in = msg_de;
			INVSUBYTES_9_2:
				begin
					invsubytes_in = msg_de;
					msg_de_in = invsubytes_out;
				end
			ADDROUNDKEY_9:
				begin
					addroundkey_in = msg_de;
					rkey = keyschedule[1151:1024];
					msg_de_in = addroundkey_out;
				end
			INVMIXCOLUMNS_9_1:
				begin
					invmixcolumns_in = msg_de[31:0];
					msg_de_in[31:0] = invmixcolumns_out;
				end
			INVMIXCOLUMNS_9_2:
				begin
					invmixcolumns_in = msg_de[63:32];
					msg_de_in[63:32] = invmixcolumns_out;
				end
			INVMIXCOLUMNS_9_3:
				begin
					invmixcolumns_in = msg_de[95:64];
					msg_de_in[95:64] = invmixcolumns_out;
				end
			INVMIXCOLUMNS_9_4:
				begin
					invmixcolumns_in = msg_de[127:96];
					msg_de_in[127:96] = invmixcolumns_out;
				end
			INVSHIFTROWS_10:
				begin
					invshiftrows_in = msg_de;
					msg_de_in = invshiftrows_out;
				end
			INVSUBYTES_10:
				invsubytes_in = msg_de;
			INVSUBYTES_10_2:
				begin
					invsubytes_in = msg_de;
					msg_de_in = invsubytes_out;
				end
			ADDROUNDKEY_10:
				begin
					addroundkey_in = msg_de;
					rkey = keyschedule[1279:1152];
					msg_de_in = addroundkey_out;
				end
			INVMIXCOLUMNS_10_1:
				begin
					invmixcolumns_in = msg_de[31:0];
					msg_de_in[31:0] = invmixcolumns_out;
				end
			INVMIXCOLUMNS_10_2:
				begin
					invmixcolumns_in = msg_de[63:32];
					msg_de_in[63:32] = invmixcolumns_out;
				end
			INVMIXCOLUMNS_10_3:
				begin
					invmixcolumns_in = msg_de[95:64];
					msg_de_in[95:64] = invmixcolumns_out;
				end
			INVMIXCOLUMNS_10_4:
				begin
					invmixcolumns_in = msg_de[127:96];
					msg_de_in[127:96] = invmixcolumns_out;
				end
			INVSHIFTROWS_11:
				begin
					invshiftrows_in = msg_de;
					msg_de_in = invshiftrows_out;
				end
			INVSUBYTES_11:
				invsubytes_in = msg_de;
			INVSUBYTES_11_2:
				begin
					invsubytes_in = msg_de;
					msg_de_in = invsubytes_out;
				end
			ADDROUNDKEY_11:
				begin
					addroundkey_in = msg_de;
					rkey = keyschedule[1407:1280];
					msg_de_in = addroundkey_out;
				end
			HALT:
				ready = 1'b1;
		endcase
	end
endmodule