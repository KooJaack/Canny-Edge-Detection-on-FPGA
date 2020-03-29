`timescale 1 ps / 1 ps
module tb_edge_detection
#(
	parameter INFILE = "../../../images/lenaim82.hex",
	parameter OUTFILE = "../../images/out_edge_detection.hex",
	parameter integer HEIGHT = 512,
	parameter integer WIDTH = 512
	);
	parameter sizeOfWidth = 8;
	parameter sizeOfLengthReal = 262144*3;
	integer j = 0;
	integer k = 0;
	integer fd = 0;
	integer licznik = 0;
	integer global = 0;
	reg write = 1'b0;
	wire ready;
	reg clk = 1'b0;
	reg [7:0] total_memory [0:sizeOfLengthReal-1];
	
	reg [7:0] r;
	reg [7:0] g;
	reg [7:0] b;
	
	wire[1:0] out_pixel;

	edge_detection detect(	
		clk,
		write,
		r,
		g,
		b,
		ready,
		out_pixel);
		
	initial begin
		$readmemh(INFILE,total_memory,0,sizeOfLengthReal-1);
		forever
			#1 clk = ~clk;
	end
	
	always@(posedge clk)begin
	global <= global+1;
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
		if(ready == 1'b1) begin
			$fwrite(fd, "%H\n", out_pixel);
			licznik = licznik+1;
		end
		if(licznik == 254016) begin
			$fclose(fd);
			$finish;
		end
	end
	
endmodule
