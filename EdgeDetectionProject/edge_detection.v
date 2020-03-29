module edge_detection(
	input clk,
	input write,
	input [7:0] input_0,
	input [7:0] input_1,
	input [7:0] input_2,
	output ready,
	output [1:0] out_pix);

	wire [7:0] out_angle, gauss_pix, buf_angle;
	wire [10:0] out_sobel_pix;
	wire [7:0] 	in_pix0,in_pix1,in_pix2,in_pix3,in_pix4,in_pix5,in_pix6,in_pix7,in_pix8,in_pix9,in_pix10,in_pix11,
	in_pix12,in_pix13,in_pix14,in_pix15,in_pix16,in_pix17,in_pix18,in_pix19,in_pix20,in_pix21,in_pix22,in_pix23,
	in_pix24;
	wire [7:0] out0, out1, out2, out3, out5, out6, out7, out8;
	wire [10:0] outf0, outf1, outf2, outf3, outf4, outf5, outf6, outf7, outf8;
	wire ready0,ready1, ready2, ready3;
	wire [7:0] out_non_max, output_gray;
	wire [1:0] out_threshold;
	wire[7:0] sss;
	assign ready = ready2 && ready3;
	
	rgb_to_grayscale rgb_to_gray(
	input_0,
	input_1,
	input_2,
	output_gray);
	
	
	buf_to_gauss gauss_buffer(
	clk,
	write,
	output_gray,
	in_pix0,
	in_pix1,
	in_pix2,
	in_pix3,
	in_pix4,
	in_pix5,
	in_pix6,
	in_pix7,
	in_pix8,
	in_pix9,
	in_pix10,
	in_pix11,
	in_pix12,
	in_pix13,
	in_pix14,
	in_pix15,
	in_pix16,
	in_pix17,
	in_pix18,
	in_pix19,
	in_pix20,
	in_pix21,
	in_pix22,
	in_pix23,
	in_pix24,
	ready0);
	
	gauss_filter gauss0 (
	in_pix0,
	in_pix1,
	in_pix2,
	in_pix3,
	in_pix4,
	in_pix5,
	in_pix6,
	in_pix7,
	in_pix8,
	in_pix9,
	in_pix10,
	in_pix11,
	in_pix12,
	in_pix13,
	in_pix14,
	in_pix15,
	in_pix16,
	in_pix17,
	in_pix18,
	in_pix19,
	in_pix20,
	in_pix21,
	in_pix22,
	in_pix23,
	in_pix24,
	gauss_pix);
	
	buf_gauss_to_sobel buffor(
	clk,
	ready0,
	gauss_pix,
	out0,
	out1,
	out2,
	out3,
	out5,
	out6,
	out7,
	out8,
	ready1);
	
	sobel_operator sobel(
	out0,
	out1,
	out2,
	out3,
	out5,
	out6,
	out7,
	out8,
	out_sobel_pix,
	out_angle);

	buf_sobel_to_threshold buffor_value(
	clk,
	ready1,
	out_sobel_pix,
	outf0,
	outf1,
	outf2,
	outf3,
	outf4,
	outf5,
	outf6,
	outf7,
	outf8,
	ready2);
	
	buf_sobel_to_threshold buffor_angle(
	.clk(clk),
	.write(ready1),
	.serial_in(out_angle),
	.out4(buf_angle),
	.ready(ready3));
	
	n_max_suppression suppression(
		outf0,
		outf1,
		outf2,
		outf3,
		outf4,
		outf5,
		outf6,
		outf7,
		outf8,
		buf_angle,
		out_non_max);

	threshold thresholde(
		out_non_max,
		out_pix);
	
endmodule
