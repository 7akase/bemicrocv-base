module bemicrocv_base(CLK_24MHz, Tact1, 
<<<<<<< HEAD
<<<<<<< master
                      USER_LED0, USER_LED1, USER_LED2);
=======
                      USER_LED0, USER_LED1, USER_LED2, USER_LED3,
                      USER_LED4, USER_LED5, USER_LED6, USER_LED7);
>>>>>>> 1ede4818dad4cc3bbb2c6c0aaed453ba0930e5ce

input CLK_24MHz;
input Tact1;
output USER_LED0;
output USER_LED1;
output USER_LED2;
<<<<<<< HEAD
=======
                      USER_LED_D4, USER_LED_D5, USER_LED_D6, USER_LED_D7,
                      USER_LED_D8, USER_LED_D9, USER_LED_D10, USER_LED_D11);

input CLK_24MHz;
input Tact1;
output USER_LED_D4;
output USER_LED_D5;
output USER_LED_D6;
output USER_LED_D7;
output USER_LED_D8;
output USER_LED_D9;
output USER_LED_D10;
output USER_LED_D11;
>>>>>>> local
=======
output USER_LED3;
output USER_LED4;
output USER_LED5;
output USER_LED6;
output USER_LED7;
>>>>>>> 1ede4818dad4cc3bbb2c6c0aaed453ba0930e5ce

parameter TACT_ON  = 1'b0;
parameter TACT_OFF = 1'b1;
parameter LED_ON   = 1'b0;
parameter LED_OFF  = 1'b1;

// state definition
reg [3:0] state;
parameter ST_IDLE  = 4'h0;
parameter ST_LED0  = 4'h1;
parameter ST_LED1  = 4'h2;
parameter ST_LED2  = 4'h3;
parameter ST_LED3  = 4'h4;
parameter ST_LED4  = 4'h5;
parameter ST_LED5  = 4'h6;
parameter ST_LED6  = 4'h7;
parameter ST_LED7  = 4'h8;

<<<<<<< HEAD
<<<<<<< master
=======
// LED reassign
reg [4:11] LED;
assign     USER_LED_D4  = LED[4];
assign     USER_LED_D5  = LED[5];
assign     USER_LED_D6  = LED[6];
assign     USER_LED_D7  = LED[7];
assign     USER_LED_D8  = LED[8];
assign     USER_LED_D9  = LED[9];
assign     USER_LED_D10 = LED[10];
assign     USER_LED_D11 = LED[11];
>>>>>>> local
=======
// LED reassign
reg [4:11] LED;
assign     USER_LED4 = LED[6];
assign     USER_LED5 = LED[4];
assign     USER_LED6 = LED[5];
assign     USER_LED7 = LED[11];
assign     USER_LED0 = LED[9];
assign     USER_LED1 = LED[10];
assign     USER_LED2 = LED[8];
assign     USER_LED3 = LED[7];
>>>>>>> 1ede4818dad4cc3bbb2c6c0aaed453ba0930e5ce

// counter
parameter       W_CNT = 23;
reg [W_CNT-1:0] cnt;

always @(posedge CLK_24MHz) begin
  if(Tact1 == TACT_ON)
	  cnt <= {W_CNT{1'b1}};
	else if(~|cnt)
	  cnt <= {W_CNT{1'b1}};
  else
	  cnt <= cnt - {{(W_CNT-1){1'b0}}, 1'b1};
end

always @(posedge CLK_24MHz) begin
// state machine
  if(Tact1 == TACT_ON) begin
    LED[4:11] <= {8{LED_OFF}};
    state <= ST_IDLE;
  end // if
  else if(~|cnt) begin
    case(state)
      ST_IDLE: begin
        LED[4:11] = {8{LED_OFF}};
        state   <= ST_LED0;
      end // ST_IDLE
      ST_LED0: begin
        LED[11] <= LED_OFF;
        LED[4]  <= LED_ON;
        state   <= ST_LED1;
      end // ST_LED0
      ST_LED1: begin
        LED[4]  <= LED_OFF;
        LED[5]  <= LED_ON;
        state   <= ST_LED2;
      end // ST_LED1
      ST_LED2: begin
        LED[5]  <= LED_OFF;
        LED[6]  <= LED_ON;
        state   <= ST_LED3;
      end // ST_LED2
      ST_LED3: begin
        LED[6]  <= LED_OFF;
        LED[7]  <= LED_ON;
        state   <= ST_LED4;
      end // ST_LED3
      ST_LED4: begin
        LED[7]  <= LED_OFF;
        LED[8]  <= LED_ON;
        state   <= ST_LED5;
      end // ST_LED4
      ST_LED5: begin
        LED[8]  <= LED_OFF;
        LED[9]  <= LED_ON;
        state   <= ST_LED6;
      end // ST_LED5
      ST_LED6: begin
        LED[9]  <= LED_OFF;
        LED[10] <= LED_ON;
        state   <= ST_LED7;
      end // ST_LED6
      ST_LED7: begin
        LED[10] <= LED_OFF;
        LED[11] <= LED_ON;
        state   <= ST_IDLE;
      end // ST_LED7
      default:
        state <= ST_IDLE;
    endcase       
  end // else if
end // always

endmodule

