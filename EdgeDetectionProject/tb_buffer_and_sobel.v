`timescale 1 ps / 1 ps
module tb_buffer_and_sobel
#(
	parameter INFILE = "../../../images/out_gauss.hex",
	parameter OUTFILE = "../../images/out_sobel.hex",
	parameter OUTANGLEFILE = "../../images/out_sobel_direction.hex",
	parameter integer WIDTH = 508,
	parameter integer HEIGHT = 508,
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
	wire ready, ready1;
	reg clk = 1'b0;
	reg [7:0] total_memory [0:sizeOfLengthReal-1];
	
	wire [7:0] out0, out1, out2, out3, out5, out6, out7, out8;
	
	reg[7:0] input_serial;
	reg[7:0] out_pixel;
	wire[10:0] out_sobel_pix;
	wire[1:0] out_sobel_angle;


	buf_gauss_to_sobel buffor(
	clk,
	write,
	out_pixel,
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
	out_sobel_angle);	
		
	initial begin
		$readmemh(INFILE,total_memory,0,sizeOfLengthReal-1);
		forever
			#1 clk = ~clk;
	end
	
	always@(posedge clk)begin
		if(j < HEIGHT) begin
			if(k < WIDTH)begin
					out_pixel <= total_memory[j*WIDTH+k];
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
		fd2 = $fopen(OUTANGLEFILE, "w");
	end
	
	always@(posedge clk) begin
		if(ready1 == 1'b1) begin
			$fwrite(fd, "%H\n", out_sobel_pix);
			$fwrite(fd2, "%H\n", out_sobel_angle);
			save_counter = save_counter+1;
		end
		if(save_counter == OUTPUT_IMAGE_SIZE) begin
			$fclose(fd);
			$finish;
		end
	end
	
endmodule
