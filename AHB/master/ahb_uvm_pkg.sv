package ahb_uvm_pkg;

	import uvm_pkg::*;
	`timescale 1ns / 1ps
	`include "uvm_macros.svh"

	`define DELAY_ONE_STEP 1
	// `define DELAY_ONE_STEP 0.1

	`define NX__AHB__HBURST_SINGLE 3'b000
	`define NX__AHB__HBURST_INCR   3'b001
	`define NX__AHB__HBURST_WRAP4  3'b010
	`define NX__AHB__HBURST_INCR4  3'b011
	`define NX__AHB__HBURST_WRAP8  3'b100
	`define NX__AHB__HBURST_INCR8  3'b101
	`define NX__AHB__HBURST_WRAP16 3'b110
	`define NX__AHB__HBURST_INCR16 3'b111

	`define NX__AHB__HTRANS_IDLE   2'b00
	`define NX__AHB__HTRANS_BUSY   2'b01
	`define NX__AHB__HTRANS_NONSEQ 2'b10
	`define NX__AHB__HTRANS_SEQ    2'b11

	`include "ahb_sequence_item.sv"
	`include "ahb_regdef_adapter.sv"
	`include "ahb_sequence_base.sv"
	`include "ahb_sequencer.sv"
	`include "ahb_driver.sv"
	`include "ahb_monitor.sv"
	`include "ahb_agent.sv"

	`undef NX__AHB__HBURST_SINGLE
	`undef NX__AHB__HBURST_INCR  
	`undef NX__AHB__HBURST_WRAP4 
	`undef NX__AHB__HBURST_INCR4 
	`undef NX__AHB__HBURST_WRAP8 
	`undef NX__AHB__HBURST_INCR8 
	`undef NX__AHB__HBURST_WRAP16
	`undef NX__AHB__HBURST_INCR16
	`undef NX__AHB__HTRANS_IDLE   
	`undef NX__AHB__HTRANS_BUSY   
	`undef NX__AHB__HTRANS_NONSEQ 
	`undef NX__AHB__HTRANS_SEQ    
	`undef DELAY_ONE_STEP

endpackage:ahb_uvm_pkg
