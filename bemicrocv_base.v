module bemicrocv_base(CLK_24MHz, Tact1, 
                      USER_LED0, USER_LED1, USER_LED2);

input CLK_24MHz;
input Tact1;
output USER_LED0;
output USER_LED1;
output USER_LED2;

parameter TACT_ON  = 1'b0;
parameter TACT_OFF = 1'b1;
parameter LED_ON   = 1'b0;
parameter LED_OFF  = 1'b1;

parameter ST_IDLE  = 2'h0;
parameter ST_LED0  = 2'h1;
parameter ST_LED1  = 2'h2;
parameter ST_LED2  = 2'h3;


parameter W_CNT = 23;

reg             USER_LED0;
reg             USER_LED1;
reg             USER_LED2;

reg [1:0]       state;
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
    USER_LED0 <= LED_OFF;
    USER_LED1 <= LED_OFF;
    USER_LED2 <= LED_OFF;
    state <= ST_IDLE;
  end // if
  else if(~|cnt) begin
    case(state)
      ST_IDLE:
        state <= ST_LED0;
      ST_LED0: begin
        USER_LED2 <= LED_OFF;
        USER_LED0 <= LED_ON;
        state <= ST_LED1;
      end
      ST_LED1: begin
        USER_LED0 <= LED_OFF;
        USER_LED1 <= LED_ON;
        state <= ST_LED2;
      end
      ST_LED2: begin
        USER_LED1 <= LED_OFF;
        USER_LED2 <= LED_ON;
        state <= ST_IDLE;
      end
      default:
        state <= ST_IDLE;
    endcase       
  end // else if
end // always

endmodule

