`ifndef SV_UVM_AXI_PKG
`define SV_UVM_AXI_PKG
package axi_pkg;
	import constant_pkg::*;
	import uvm_pkg::*;

	`include "Axi.svh"
	`include "axi_seq_item.sv"
	`include "axi_seq_base.sv"
	`include "axi_driver.sv"
	`include "axi_sequencer.sv"

endpackage
`endif
