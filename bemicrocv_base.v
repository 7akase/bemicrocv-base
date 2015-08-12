module bemicrocv_base(CLK_24MHz, Tact1, USER_LED1);

input CLK_24MHz;
input Tact1;
output USER_LED1;

parameter TACT_ON  = 1'b0;
parameter TACT_OFF = 1'b1;

parameter W_CNT = 23;

reg             USER_LED1;
reg [W_CNT-1:0] cnt;

always @(posedge CLK_24MHz) begin
   if(Tact1 == TACT_ON) begin
	  cnt <= {W_CNT{1'b1}};
	end else if(~|cnt) begin
	  cnt <= {W_CNT{1'b1}};
	  USER_LED1 <= ~USER_LED1;
	end else begin
	  cnt <= cnt - {{(W_CNT-1){1'b0}}, 1'b1};
	end
end
endmodule

