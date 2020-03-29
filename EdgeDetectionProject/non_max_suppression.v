//Third step - non maximum suppression, edge thinning technique

module n_max_suppression(input [10:0] in_pix0, input [10:0] in_pix1, input [10:0] in_pix2, input [10:0] in_pix3, 
	input [10:0] in_pix4, input [10:0] in_pix5, input [10:0] in_pix6, input [10:0] in_pix7, input [10:0] in_pix8,
	input [1:0] in_angle, output [7:0] out_pix);

	localparam NORTH = 2'b00,
					NORTH_WEST = 2'b01,
					WEST = 2'b10,
					NORTH_EAST = 2'b11;
	reg[7:0] temp_result;
	reg is_max;
	always@(*) begin
		is_max = 1'b0;
		case(in_angle)
			WEST: 		if((in_pix4 >= in_pix3) && (in_pix4 >= in_pix5))
								is_max = 1'b1;
					
			NORTH_WEST: if((in_pix4 >= in_pix2) && (in_pix4 >= in_pix6))
								is_max = 1'b1;
					
			NORTH: 		if((in_pix4 >= in_pix1) && (in_pix4 >= in_pix7))
								is_max = 1'b1;
					
			NORTH_EAST: if((in_pix4 >= in_pix0) && (in_pix4 >= in_pix8))
								is_max = 1'b1;
		endcase
		if(is_max)
			temp_result = in_pix4 > 8'd255 ? 8'd255 : in_pix4;
		else
			temp_result = 8'd0;
	end
	assign out_pix = temp_result;
endmodule
