module rgb_to_grayscale (
	input [7:0] in_pix_r,
	input [7:0] in_pix_g,
	input [7:0] in_pix_b,
	output [7:0] out_gray_pix);

	assign out_gray_pix = (in_pix_r >> 2) + (in_pix_r >> 5) +
							(in_pix_g >> 1) + (in_pix_g >> 4) +
							(in_pix_b >> 4) + (in_pix_b >> 5);  
endmodule
