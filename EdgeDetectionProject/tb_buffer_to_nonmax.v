`timescale 1 ps / 1 ps
module tb_buffer_to_nonmax
#(
	parameter integer WIDTH = 506,
	parameter integer HEIGHT = 506,
	parameter integer R_KERNEL = 1
	);
	parameter sizeOfWidth = 8;
	parameter sizeOfLengthReal = WIDTH*HEIGHT;
	parameter OUTPUT_IMAGE_SIZE = (WIDTH-(R_KERNEL*2))*(HEIGHT-(R_KERNEL*2));
	integer j = 0;
	integer k = 0;
	integer fd = 0;
	integer row_gen = 0;
	reg write = 1'b0;
	wire ready, read_direction;
	reg clk = 1'b0;
	reg[10:0] input_serial;
	wire [10:0] out0, out1, out2, out3, out4, out5, out6, out7, out8;
	wire[1:0] buf_direction;

	buf_sobel_to_threshold buffor_value(
	clk,
	write,
	input_nonmax_serial,
	out0,
	out1,
	out2,
	out3,
	out4,
	out5,
	out6,
	out7,
	out8,
	ready);
	
	buf_sobel_to_threshold buffor_direction(
	.clk(clk),
	.write(write),
	.serial_in(input_serial),
	.out4(buf_direction),
	.ready(ready_direction));
	
	initial begin
		forever
			#1 clk = ~clk;
	end
	
	always@(posedge clk)begin
		if(j < HEIGHT) begin
			if(k < WIDTH)begin
					input_serial = row_gen;
					write = 1'b1;
			end
		end
		else
			write = 1'b0;
			
		if(k == WIDTH-1)begin
			k = 0;
			j=j+1;
		end else
			k = k+1;
		if(row_gen == WIDTH/2-1)
			row_gen = 0;
		else
			row_gen = row_gen+1;
	end
endmodule