`ifndef SV_AXI_DRVIER_DEF
`define SV_AXI_DRVIER_DEF

`define AXI_SEQ_ITEM axi_seq_item#(id_bits,addr_bits, data_bits)

class axi_driver # (
	 parameter id_bits   = 10
	,parameter addr_bits = 32
	,parameter data_bits = 32
) extends uvm_driver#(`AXI_SEQ_ITEM);

	virtual axi_interface#(id_bits, addr_bits, data_bits) vif ;
	`uvm_component_utils(axi_driver)
	`AXI_SEQ_ITEM item;
	`AXI_SEQ_ITEM item_buffer[$];

	function new(string name="axi_driver", uvm_component parent);
		super.new(name,parent);
	endfunction
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		// TODO :: virtual interface
		item = `AXI_SEQ_ITEM::type_id::create("item");
		//item = axi_seq_item::type_id::create("item");
	endfunction
	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
	endfunction
	// Algorithm
	// 1. byte-aligned checker
	// 2. 4 K boundary checker
	`include "axi_driver_func.sv"

	// TODO: add task file
	//`include "axi_driver_task.sv"
	virtual task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		phase.drop_objection(this);
	endtask

endclass: axi_driver

`undef AXI_SEQ_ITEM

`endif // SV_AXI_DRVIER_DEF
