// Second step - Sobel Operator calculate gradient magnitude and direction (45 degrees) 
// 				  of the intensity image function
module sobel_operator ( 
	input [7:0] in_pix0, input [7:0] in_pix1, input [7:0] in_pix2,
	input [7:0] in_pix3, input [7:0] in_pix5, input [7:0] in_pix6,
	input [7:0] in_pix7,input [7:0] in_pix8,
	output [10:0] out_pix, output [1:0] out_angle);
	
	reg [1:0] angle;
	wire signed[10:0] gradient[3:0];
	reg [10:0] abs_g [3:0];
	reg [10:0] out_value;
	integer i;
	//North 90
	assign gradient[0] = (in_pix0 - in_pix2) + (in_pix3 - in_pix5)*2 + (in_pix6 - in_pix8);
	//West 0
	assign gradient[2] = (in_pix6 - in_pix0) + (in_pix7 - in_pix1)*2 + (in_pix8 - in_pix2);
	//North-West 45
	assign gradient[1] = (in_pix3 - in_pix1) + (in_pix6 - in_pix2)*2 + (in_pix7 - in_pix5);
	//North-East 135
	assign gradient[3] = (in_pix3 - in_pix7) + (in_pix0 - in_pix8)*2 + (in_pix1 - in_pix5);
	//Gradient magnitude and direction
	always@(*) begin
		out_value = 0;
		angle = 0;
		for(i = 0; i < 4; i=i+1) begin
			abs_g[i] = gradient[i][10] ? -gradient[i] : gradient[i];
			if(abs_g[i] > out_value) begin
				out_value = abs_g[i];
				angle = i;
			end
		end
	end
	assign out_pix = out_value;
	assign out_angle = angle;
endmodule
