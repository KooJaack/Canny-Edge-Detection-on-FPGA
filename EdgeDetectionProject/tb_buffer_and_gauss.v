`timescale 1 ps / 1 ps
module tb_buffer_and_gauss
#(
	parameter INFILE = "../../../images/out_gray.hex",
	parameter OUTFILE = "../../images/out_gauss.hex",

	parameter integer WIDTH = 512,
	parameter integer HEIGHT = 512,
	parameter integer R_KERNEL = 2
	);
	parameter sizeOfWidth = 8;
	parameter sizeOfLengthReal = WIDTH*HEIGHT;
	parameter OUTPUT_IMAGE_SIZE = (WIDTH-(R_KERNEL*2))*(HEIGHT-(R_KERNEL*2));
	integer j = 0;
	integer k = 0;
	integer fd = 0;
	integer save_counter = 0;
	reg write = 1'b0;
	wire ready;
	reg clk = 1'b0;
	reg [7:0] total_memory [0:sizeOfLengthReal-1];
	wire [7:0] 	in_pix0,in_pix1,in_pix2,in_pix3,in_pix4,in_pix5,in_pix6,in_pix7,in_pix8,in_pix9,in_pix10,in_pix11,
	in_pix12,in_pix13,in_pix14,in_pix15,in_pix16,in_pix17,in_pix18,in_pix19,in_pix20,in_pix21,in_pix22,in_pix23,
	in_pix24;	
	reg[7:0] input_serial;
	wire[7:0] out_pixel;


	buf_to_gauss gauss_buffer(
	clk,
	write,
	input_serial,
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
	ready);
	
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
	out_pixel);
		
	initial begin
		$readmemh(INFILE,total_memory,0,sizeOfLengthReal-1);
		forever
			#1 clk = ~clk;
	end
	
	always@(posedge clk)begin
		if(j < HEIGHT) begin
			if(k < WIDTH)begin
					input_serial <= total_memory[j*WIDTH+k];
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
	end
	
	always@(posedge clk) begin
		if(ready == 1'b1) begin
			$fwrite(fd, "%H\n", out_pixel);
			save_counter = save_counter+1;
		end
		if(save_counter == OUTPUT_IMAGE_SIZE) begin
			$fclose(fd);
			$finish;
		end
	end
	
endmodule

