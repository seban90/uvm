import uvm_pkg::*;
import axi_pkg::*;

`define create_clock(clk, freq) \
	reg clk = 0;\
	always #((1.0/freq)*500) clk = ~clk;

`define create_reset(rstn, sync_clk) \
	reg rstn = 0; \
	initial begin \
		repeat (16) @ (posedge sync_clk); \
		#0.01; rstn = 1'b1; \
	end

import uvm_pkg::*;
import axi_pkg::*;
import constant_pkg::*;

module testbench;

	parameter IDBITS = 32 ; // bits_cfg.id;
	parameter ABITS  = 32 ; // bits_cfg.addr;
	parameter DBITS  = 32 ; // bits_cfg.data;
	`create_clock(ACLK, 600)
	`create_reset(ARSTN, ACLK)
	axi_driver #(IDBITS, ABITS, DBITS) drv;


	initial begin
		drv = axi_driver#(IDBITS, ABITS, DBITS)::type_id::create("drvier", null);
		$display("=====================================================");
		$display("== SIM START");
		$display("=====================================================");
		$finish;
	end

endmodule

