`ifndef NX__SV__AHB_DRIVER
`define NX__SV__AHB_DRIVER
class ahb_driver extends uvm_driver #(ahb_sequence_item);

	virtual AHB_IF  vif;
	uvm_analysis_port#(ahb_sequence_item) analysis_port;

	`uvm_component_utils(ahb_driver)

	function new(string name, uvm_component parent);
		super.new(name, parent);
		analysis_port = new("analysis_port",this);
	endfunction
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		if (!uvm_config_db#(virtual AHB_IF)::get(this, "", "ahb_vif", vif))
			`uvm_error("", "uvm_config_db::get failed")
	endfunction
	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
	endfunction

	task reset ();
		this.vif.HADDR  = 0;
		this.vif.HTRANS = 0;
		this.vif.HLOCK  = 0;
		this.vif.HPROT  = 0;
		this.vif.HWRITE = 0;
		this.vif.HSIZE  = 0;
		this.vif.HBURST = 0;
		this.vif.HWDATA = 0;
	endtask

	task write_single(ahb_sequence_item it);
		// Address Phase
		#`DELAY_ONE_STEP;
		this.vif.HADDR  = it.addr;
		this.vif.HTRANS = `NX__AHB__HTRANS_NONSEQ;
		this.vif.HLOCK  = 1'b0;
		this.vif.HPROT  = 4'b0;
		this.vif.HWRITE = 1'b1;
		this.vif.HSIZE  = it.SIZE;
		this.vif.HBURST = `NX__AHB__HBURST_SINGLE;
		@ (posedge this.vif.HCLK);
		while (this.vif.HREADY == 0) @ (posedge this.vif.HCLK);
		#`DELAY_ONE_STEP;
		// Data Phase
		this.vif.HTRANS = `NX__AHB__HTRANS_IDLE;
		//this.vif.HWRITE = 1'b0;
		this.vif.HWDATA = it.data;
		@ (posedge this.vif.HCLK);
		while (this.vif.HREADY == 0) @ (posedge this.vif.HCLK);
		#`DELAY_ONE_STEP;
		//this.vif.HTRANS = `NX__AHB__HTRANS_IDLE;
		this.vif.HWRITE = 1'b0;
		this.vif.HLOCK  = 1'b0;
		this.vif.HPROT  = 4'b0;
		this.vif.HWRITE = 1'b0;
		this.vif.HSIZE  = 3'b000;
	endtask

	task write_incr4(ahb_sequence_item it);
		`include "driver_decl/ahb_write_incr4.sv"
	endtask

	task write_wrap4(ahb_sequence_item it);
		`include "driver_decl/ahb_write_wrap4.sv"
	endtask

	task write_incr8(ahb_sequence_item it);
		`include "driver_decl/ahb_write_incr8.sv"
	endtask

	task write_wrap8(ahb_sequence_item it);
		`include "driver_decl/ahb_write_wrap8.sv"
	endtask

	task write_incr16(ahb_sequence_item it);
		`include "driver_decl/ahb_write_incr16.sv"
	endtask

	task write_wrap16(ahb_sequence_item it);
		`include "driver_decl/ahb_write_wrap16.sv"
	endtask

	task write_incr(ahb_sequence_item it);
		`include "driver_decl/ahb_write_incr.sv"
	endtask

	task write (ahb_sequence_item it);
		case(it.BURST)
			ahb_sequence_item::SINGLE : write_single(it);
			ahb_sequence_item::INCR   : write_incr(it);
			ahb_sequence_item::INCR4  : write_incr4(it);
			ahb_sequence_item::WRAP4  : write_wrap4(it);
			ahb_sequence_item::INCR8  : write_incr8(it);
			ahb_sequence_item::WRAP8  : write_wrap8(it);
			ahb_sequence_item::INCR16 : write_incr16(it);
			ahb_sequence_item::WRAP16 : write_wrap16(it);
		endcase
		@ (posedge this.vif.HCLK);
	endtask

	task read_single(ahb_sequence_item it);
		// Address Phase
		#`DELAY_ONE_STEP;
		this.vif.HADDR  = it.addr;
		this.vif.HTRANS = `NX__AHB__HTRANS_NONSEQ;
		this.vif.HLOCK  = 1'b0;
		this.vif.HPROT  = 4'b0;
		this.vif.HWRITE = 1'b0;
		//this.vif.HSIZE  = 3'b010;
		this.vif.HSIZE  = it.SIZE;
		this.vif.HBURST = `NX__AHB__HBURST_SINGLE;
		@ (posedge this.vif.HCLK);
		while (this.vif.HREADY == 0) @ (posedge this.vif.HCLK);
		#`DELAY_ONE_STEP;
		// Data Phase
		this.vif.HTRANS = `NX__AHB__HTRANS_IDLE;
		// this.vif.HWDATA = it.data;
		@ (posedge this.vif.HCLK);
		while (this.vif.HREADY == 0) @ (posedge this.vif.HCLK);
		it.data = this.vif.HRDATA;
		#`DELAY_ONE_STEP;
		//this.vif.HTRANS = `NX__AHB__HTRANS_IDLE;
		this.vif.HLOCK  = 1'b0;
		this.vif.HPROT  = 4'b0;
		this.vif.HWRITE = 1'b0;
		this.vif.HSIZE  = 3'b000;
	endtask

	task read_incr4(ahb_sequence_item it);
		`include "driver_decl/ahb_read_incr4.sv"
	endtask

	task read_wrap4(ahb_sequence_item it);
		`include "driver_decl/ahb_read_wrap4.sv"
	endtask

	task read_incr8(ahb_sequence_item it);
		`include "driver_decl/ahb_read_incr8.sv"
	endtask

	task read_wrap8(ahb_sequence_item it);
		`include "driver_decl/ahb_read_wrap8.sv"
	endtask

	task read_incr16(ahb_sequence_item it);
		`include "driver_decl/ahb_read_incr16.sv"
	endtask

	task read_wrap16(ahb_sequence_item it);
		`include "driver_decl/ahb_read_wrap16.sv"
	endtask

	task read (ahb_sequence_item it);
		case(it.BURST)
			ahb_sequence_item::SINGLE : read_single(it);
			ahb_sequence_item::INCR   : begin
				uvm_report_warning(get_type_name(), "undefined length of READ is not supported");
			end
			ahb_sequence_item::INCR4  : read_incr4(it);
			ahb_sequence_item::WRAP4  : read_wrap4(it);
			ahb_sequence_item::INCR8  : read_incr8(it);
			ahb_sequence_item::WRAP8  : read_wrap8(it);
			ahb_sequence_item::INCR16 : read_incr16(it);
			ahb_sequence_item::WRAP16 : read_wrap16(it);
		endcase
	endtask

	task run_phase (uvm_phase phase);
		ahb_sequence_item tmp;
		reset;
		`uvm_info(get_type_name(), "Driver VIF reset", UVM_LOW)
		//@ (posedge this.vif.HRSTN);
		forever begin
			tmp = new("item");
			seq_item_port.get_next_item(req);
			//tmp.deep_copy(req);
			phase.raise_objection(this, "ahb");
			case (req.TYPE)
				ahb_sequence_item::WRITE: begin tmp.deep_copy(req); write(req); end
				ahb_sequence_item::READ : begin read (req); tmp.deep_copy(req); end
			endcase
			analysis_port.write(tmp);
			seq_item_port.item_done();
			phase.drop_objection(this, "ahb");
		end
	endtask

endclass: ahb_driver
`endif // NX__SV__AHB_DRIVER
