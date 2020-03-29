`timescale 1 ps / 1 ps
module tb_gray_image
#(
	parameter INFILE = "../../../images/lenaim82.hex",
	parameter OUTFILE = "../../images/out_gray.hex",

	parameter integer WIDTH = 512,
	parameter integer HEIGHT = 512
	);
	parameter sizeOfWidth = 8;
	parameter sizeOfLengthReal = WIDTH*HEIGHT;
	integer j = 0;
	integer k = 0;
	integer fd = 0;
	integer save_counter = 0;
	reg clk = 1'b1;
	reg write;
	reg [7:0] total_memory [0:sizeOfLengthReal*3-1];
	
	reg [7:0] 	r, g, b;	
	wire[7:0] gray_pixel;
		
	rgb_to_grayscale test_convert_to_gray(r, g, b, gray_pixel);
	
	initial begin
		$readmemh("./lenaim82.hex",total_memory,0,sizeOfLengthReal*3-1);
		forever
			#1 clk = ~clk;
	end
	
	always@(posedge clk)begin
		if(j < HEIGHT) begin
			if(k < WIDTH*3)begin
					r <= total_memory[j*WIDTH*3+k];
					g <= total_memory[j*WIDTH*3+k+1];
					b <= total_memory[j*WIDTH*3+k+2];
					write <= 1'b1;
			end
		end
		else
			write = 1'b0;
			
		if(k == WIDTH*3-3)begin
			k = 0;
			j=j+1;
		end else
			k = k+3;
	end
	
	initial begin
		fd = $fopen(OUTFILE, "w");
	end
	
	always@(posedge clk) begin
		if(write == 1'b1) begin
			$fwrite(fd, "%H\n", gray_pixel);
			save_counter = save_counter+1;
		end
		if(save_counter == sizeOfLengthReal) begin
			$fclose(fd);
			$finish;
		end
	end
	
endmodule
