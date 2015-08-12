module bemicrocv_base(clk_i, led0);

input clk_i;
output led0;

parameter W_CNT = 8;

reg             led0;
reg [W_CNT-1:0] cnt;

always @(posedge clk_i)
   if(~|cnt) begin
	  cnt <= {W_CNT{1'b1}};
	  led0 <= ~led0;
   end
	
endmodule

