`ifndef SV_AXI_AGENT_DEF
`define SV_AXI_AGENT_DEF

`define AXI_DEF_PARAM #(id_bits, addr_bits, data_bits)
`define AXI_INTERFACE virtual axi_interface`AXI_DEF_PARAM
`define AXI_DRIVER    axi_driver`AXI_DEF_PARAM
`define AXI_SEQR      axi_sequencer`AXI_DEF_PARAM

class axi_agent # (
	 parameter id_bits   = 10
	,parameter addr_bits = 32
	,parameter data_bits = 32
) extends uvm_agent;

	`AXI_INTERFACE vif ;
	`AXI_DRIVER    drv ;
	`AXI_SEQR      sqr ;

	`uvm_component_utils_begin(axi_agent)
		`uvm_field_object(drv, UVM_ALL_ON)
		`uvm_field_object(sqr, UVM_ALL_ON)
	`uvm_component_utils_end

	function new (string name="axi_agent", uvm_component parent);
		super.new(name, parent);
	endfunction
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		drv = `AXI_DRIVER::type_id::create("axi_driver",this);
		sqr = `AXI_SEQR::type_id::create("axi_sequencer",this);
		if (!uvm_config_db#(`AXI_INTERFACE)::get(this,"","vif",vif))
			`uvm_fatal("VIF MISS", "No VIF")
		uvm_config_db#(`AXI_INTERFACE)::set(this,"axi_driver","vif",vif);
		uvm_config_db#(`AXI_INTERFACE)::set(this,"axi_sequencer","vif",vif);
	endfunction
	virtual function void connect_phase(uvm_phase phase);
		drv.seq_item_port.connect(sqr.seq_item_export);
		uvm_report_info("axi_agent::","connect_phase, DRV<-->SEQR");
	endfunction

endclass: axi_agent

`undef AXI_DEF_PARAM
`undef AXI_INTERFACE
`undef AXI_DRIVER
`undef AXI_SEQR

`endif // SV_AXI_AGENT_DEF
