transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+E:/intelFPGA_lite/18.1/Projects/EdgeDetectionProject {E:/intelFPGA_lite/18.1/Projects/EdgeDetectionProject/edge_detection.v}
vlog -vlog01compat -work work +incdir+E:/intelFPGA_lite/18.1/Projects/EdgeDetectionProject {E:/intelFPGA_lite/18.1/Projects/EdgeDetectionProject/buffer_gauss_to_sobel.v}
vlog -vlog01compat -work work +incdir+E:/intelFPGA_lite/18.1/Projects/EdgeDetectionProject {E:/intelFPGA_lite/18.1/Projects/EdgeDetectionProject/buffer_sobel_to_nonmaxsupression.v}
vlog -vlog01compat -work work +incdir+E:/intelFPGA_lite/18.1/Projects/EdgeDetectionProject {E:/intelFPGA_lite/18.1/Projects/EdgeDetectionProject/fifo_memory504.v}
vlog -vlog01compat -work work +incdir+E:/intelFPGA_lite/18.1/Projects/EdgeDetectionProject {E:/intelFPGA_lite/18.1/Projects/EdgeDetectionProject/fifo_memory502.v}
vlog -vlog01compat -work work +incdir+E:/intelFPGA_lite/18.1/Projects/EdgeDetectionProject {E:/intelFPGA_lite/18.1/Projects/EdgeDetectionProject/non_max_suppression.v}
vlog -vlog01compat -work work +incdir+E:/intelFPGA_lite/18.1/Projects/EdgeDetectionProject {E:/intelFPGA_lite/18.1/Projects/EdgeDetectionProject/thresholding.v}
vlog -vlog01compat -work work +incdir+E:/intelFPGA_lite/18.1/Projects/EdgeDetectionProject {E:/intelFPGA_lite/18.1/Projects/EdgeDetectionProject/sobel_operator.v}
vlog -vlog01compat -work work +incdir+E:/intelFPGA_lite/18.1/Projects/EdgeDetectionProject {E:/intelFPGA_lite/18.1/Projects/EdgeDetectionProject/buf_to_gauss.v}
vlog -vlog01compat -work work +incdir+E:/intelFPGA_lite/18.1/Projects/EdgeDetectionProject {E:/intelFPGA_lite/18.1/Projects/EdgeDetectionProject/fifo_memory506.v}
vlog -vlog01compat -work work +incdir+E:/intelFPGA_lite/18.1/Projects/EdgeDetectionProject {E:/intelFPGA_lite/18.1/Projects/EdgeDetectionProject/rgb_to_grayscale.v}
vlog -sv -work work +incdir+E:/intelFPGA_lite/18.1/Projects/EdgeDetectionProject {E:/intelFPGA_lite/18.1/Projects/EdgeDetectionProject/gauss_filter.sv}

vlog -vlog01compat -work work +incdir+E:/intelFPGA_lite/18.1/Projects/EdgeDetectionProject {E:/intelFPGA_lite/18.1/Projects/EdgeDetectionProject/tb_buffer_and_gauss2.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneiv_hssi_ver -L cycloneiv_pcie_hip_ver -L cycloneiv_ver -L rtl_work -L work -voptargs="+acc"  tb_buffer_and_gauss2

add wave *
view structure
view signals
run -all
