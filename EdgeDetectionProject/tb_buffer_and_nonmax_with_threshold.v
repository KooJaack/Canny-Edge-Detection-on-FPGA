`timescale 1 ps / 1 ps
module tb_buffer_and_nonmax_with_threshold
#(
	parameter INFILE = "../../../images/out_sobel.hex",
	parameter IN_DIRECTION_FILE = "../../../images/out_sobel_direction.hex",
	parameter OUTFILE = "../../../images/out_nonmax.hex",
	parameter OUT_THRESHOLD_FILE = "../../../images/out_threshold.hex",

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
	integer fd2 = 0;
	integer save_counter = 0;
	reg write = 1'b0;
	wire ready, ready2;
	reg clk = 1'b0;
	reg [10:0] total_memory [0:sizeOfLengthReal-1];
	reg [1:0] total_memory_direction [0:sizeOfLengthReal-1];
	
	wire [10:0] out0, out1, out2, out3, out4, out5, out6, out7, out8;
	
	reg[10:0] input_nonmax_magnitude;
	reg[1:0] input_nonmax_direction;
	wire[7:0] out_non_max, out_threshold;
	wire[1:0] buf_direction;

	buf_sobel_to_threshold buffor_value(
	clk,
	write,
	input_nonmax_magnitude,
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
	.serial_in(input_nonmax_direction),
	.out4(buf_direction),
	.ready(ready2));
	
	n_max_suppression suppression(
		out0,
		out1,
		out2,
		out3,
		out4,
		out5,
		out6,
		out7,
		out8,
		buf_direction,
		out_non_max);

	threshold thresholde(
		out_non_max,
		out_threshold);
		
	initial begin
		$readmemh(INFILE,total_memory,0,sizeOfLengthReal-1);
		$readmemh(IN_DIRECTION_FILE,total_memory_direction,0,sizeOfLengthReal-1);
		forever
			#1 clk = ~clk;
	end
	
	always@(posedge clk)begin
		if(j < HEIGHT) begin
			if(k < WIDTH)begin
					input_nonmax_magnitude <= total_memory[j*WIDTH+k];
					input_nonmax_direction <= total_memory_direction[j*WIDTH+k];
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
	end
	
	initial begin
		fd = $fopen(OUTFILE, "w");
		fd2 = $fopen(OUT_THRESHOLD_FILE, "w");
	end
	
	always@(posedge clk) begin
		if(ready && ready2) begin
			$fwrite(fd, "%H\n", out_non_max);
			$fwrite(fd2, "%H\n", out_threshold);
			save_counter = save_counter+1;
		end
		if(save_counter == OUTPUT_IMAGE_SIZE) begin
			$fclose(fd);
			$finish;
		end
	end
	
endmodule