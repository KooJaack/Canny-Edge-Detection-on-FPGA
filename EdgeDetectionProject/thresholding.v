//Step four - double threshold, 
//				  pixels > high treshold means edge, 
//				  high threshold < pixels > low threshold means edge when adjacent pixel is strong edge
// 			  On output: 0 = no edge
//								 1 = weak pixel
//								 2 = strong pixel
module threshold(
	input[7:0] in_pix,
	output [7:0] out_pix
);

	parameter LOW_THRESHOLD = 40;
	parameter HIGH_THRESHOLD = 120;

	reg [1:0] temp_output;
	
	always@(in_pix) begin
		if(in_pix < LOW_THRESHOLD)
			temp_output = 2'd0;
		else if(in_pix >= LOW_THRESHOLD && in_pix < HIGH_THRESHOLD)
			temp_output = 2'd1;
		else
			temp_output = 2'd2;
	end	

assign out_pix = {6'd0, temp_output};
	
endmodule
