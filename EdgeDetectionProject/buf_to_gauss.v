module buf_to_gauss #(
	parameter IMAGE_WIDTH = 512,
	parameter R = 2)(
	input clk,
	input write,
	input [7:0] serial_in,
	output [7:0] out0,
	output [7:0] out1,
	output [7:0] out2,
	output [7:0] out3,
	output [7:0] out4,
	output [7:0] out5,
	output [7:0] out6,
	output [7:0] out7,
	output [7:0] out8,
	output [7:0] out9,
	output [7:0] out10,
	output [7:0] out11,
	output [7:0] out12,
	output [7:0] out13,
	output [7:0] out14,
	output [7:0] out15,
	output [7:0] out16,
	output [7:0] out17,
	output [7:0] out18,
	output [7:0] out19,
	output [7:0] out20,
	output [7:0] out21,
	output [7:0] out22,
	output [7:0] out23,
	output [7:0] out24,
	output reg ready);
	
	parameter SHIFT_REGISTER_DEPTH = R*2*IMAGE_WIDTH+(2*R+1);
	
	reg [11:0] counter = 0;
	
	reg [7:0] q0, q1, q2, q3, q4, q5, q6, q7, q8,
	q9, q10, q11, q12,q13,q14,q15,q16,q17,q18,q19,q20,q21,q22,q23,q24;
	wire [7:0] qf0, qf1, qf2, qf3;
	wire full0, full1, full2, full3;
	wire read0, read1, read2, read3;
	reg signed [11:0] counter_edge = -1;
	
	fifo_memory506 fifo_0(
		clk,
		q20,
		read0,
		write,
		full0,
		qf0);
	
	fifo_memory506 fifo_1(
		clk,
		q15,
		read1,
		write,
		full1,
		qf1);
	
	fifo_memory506 fifo_2(
		clk,
		q10,
		read2,
		write,
		full2,
		qf2);
	fifo_memory506 fifo_3(
		clk,
		q5,
		read3,
		write,
		full3,
		qf3);
	
	always@(posedge clk) begin
		if(write) begin
			q0 = q1;
			q1 = q2;
			q2 = q3;
			q3 = q4;
			q4 = qf3;
			q5 = q6;
			q6 = q7;
			q7 = q8;
			q8 = q9;
			q9 = qf2;
			q10 = q11;
			q11 = q12;
			q12 = q13;
			q13 = q14;
			q14 = qf1;
			q15 = q16;
			q16 = q17;
			q17 = q18;
			q18 = q19;
			q19 = qf0;
			q20 = q21;
			q21 = q22;
			q22 = q23;
			q23 = q24;
			q24 = serial_in;
				
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
		end
		else
			ready = 1'b0;
	end
	
	assign read0 = full0 & write;
	assign read1 = full1 & write;
	assign read2 = full2 & write;
	assign read3 = full3 & write;
	
	assign out0 = q0;
	assign out1 = q1;
	assign out2 = q2;
	assign out3 = q3;
	assign out4 = q4;
	assign out5 = q5;
	assign out6 = q6;
	assign out7 = q7;
	assign out8 = q8;
	assign out9 = q9;
	assign out10 = q10;
	assign out11 = q11;
	assign out12 = q12;
	assign out13 = q13;
	assign out14 = q14;
	assign out15 = q15;
	assign out16 = q16;
	assign out17 = q17;
	assign out18 = q18;
	assign out19 = q19;
	assign out20 = q20;
	assign out21 = q21;
	assign out22 = q22;
	assign out23 = q23;
	assign out24 = q24;
	
endmodule
