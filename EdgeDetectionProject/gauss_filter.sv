//First step - Gauss Blur remove noises from image

module gauss_filter ( input [7:0] in_pix0, input [7:0] in_pix1, input [7:0] in_pix2,
input [7:0] in_pix3, input [7:0] in_pix4, input [7:0] in_pix5, input [7:0] in_pix6,
input [7:0] in_pix7, input [7:0] in_pix8, input [7:0] in_pix9, input [7:0] in_pix10, 
input [7:0] in_pix11, input [7:0] in_pix12, input [7:0] in_pix13, input [7:0] in_pix14,
input [7:0] in_pix15, input [7:0] in_pix16, input [7:0] in_pix17, input [7:0] in_pix18,
input [7:0] in_pix19, input [7:0] in_pix20, input [7:0] in_pix21, input [7:0] in_pix22,
input [7:0] in_pix23, input [7:0] in_pix24,

output [7:0] out_pix);

parameter logic [7:0] GAUSS_KERNEL [5:0]	= '{8'd1, 8'd4, 8'd7, 8'd20, 8'd33, 8'd54};
localparam KERNEL_SUM = GAUSS_KERNEL[0] * 4 + 
								GAUSS_KERNEL[1] * 8 +
								GAUSS_KERNEL[2] * 4 +
								GAUSS_KERNEL[3] * 4 +
								GAUSS_KERNEL[4] * 4 +
								GAUSS_KERNEL[5];

assign out_pix = ((in_pix0 + in_pix4 + in_pix20 + in_pix24) * GAUSS_KERNEL[0] + 
	(in_pix5 + in_pix1 + in_pix3 + in_pix9 + in_pix15 + in_pix21 + in_pix23 + in_pix19) * GAUSS_KERNEL[1] + 
	(in_pix2 + in_pix10 + in_pix22 + in_pix14) * GAUSS_KERNEL[2] +  
	(in_pix6 + in_pix8 + in_pix16 + in_pix18) * GAUSS_KERNEL[3] + 
	(in_pix7 + in_pix11 + in_pix13 + in_pix17) * GAUSS_KERNEL[4] + 
	in_pix12 * GAUSS_KERNEL[5]) / KERNEL_SUM;

endmodule
