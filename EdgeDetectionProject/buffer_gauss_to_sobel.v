module buf_gauss_to_sobel#(
	parameter IMAGE_WIDTH = 508,
	parameter R = 1)(
	input clk,
	input write,
	input [7:0] serial_in,
	output [7:0] out0,
	output [7:0] out1,
	output [7:0] out2,
	output [7:0] out3,
	output [7:0] out5,
	output [7:0] out6,
	output [7:0] out7,
	output [7:0] out8,
	output reg ready);
	
	parameter SHIFT_REGISTER_DEPTH = R*2*IMAGE_WIDTH+(2*R+1);
	
	reg [10:0] counter = 0;
	
	reg [7:0] q0, q1, q2, q3, q4, q5, q6, q7, q8;
	wire [7:0] qf0, qf1;
	wire full0, full1;
	wire read0, read1;
	reg signed [11:0] counter_edge = -1;
	
	fifo_memory504 fifo_0(
		clk,
		q6,
		read0,
		write,
		full0,
		qf0);
	
	fifo_memory504 fifo_1(
		clk,
		q3,
		read1,
		write,
		full1,
		qf1);
	
	always@(posedge clk) begin
		if(write) begin
			q0 = q1;
			q1 = q2;
			q2 = qf1;
			q3 = q4;
			q4 = q5;
			q5 = qf0;
			q6 = q7;
			q7 = q8;
			q8 = serial_in;
			
			if(counter < SHIFT_REGISTER_DEPTH-1) begin
				counter = counter+1;
				ready = 1'b0;
			end else if (counter_edge < IMAGE_WIDTH-(2*R)) begin
				ready = 1'b1;
			end else
				ready = 1'b0;
				
			if(counter_edge == IMAGE_WIDTH) begin
				counter_edge = 0;
				ready = 1'b1;
			end
			
			if(counter == SHIFT_REGISTER_DEPTH-1)
				counter_edge = counter_edge+1;	
		end else
			ready = 1'b0;
		
	end
	
	assign read0 = full0 && write;
	assign read1 = full1 && write;
	
	assign out0 = q0;
	assign out1 = q1;
	assign out2 = q2;
	assign out3 = q3;
	assign out5 = q5;
	assign out6 = q6;
	assign out7 = q7;
	assign out8 = q8;
	
endmodule