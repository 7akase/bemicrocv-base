module bemicrocv_base(clk_24mhz, user_led0);

input clk_24mhz;
output user_led0;

parameter W_CNT = 8;

reg             user_led0;
reg [W_CNT-1:0] cnt;

assign clk_i = clk_24mhz;

always @(posedge clk_i)
   if(~|cnt) begin
	  cnt <= {W_CNT{1'b1}};
	  user_led0 <= ~user_led0;
   end
	
endmodule

