
`ifndef SV_AXI_SEQUENCER_DEF
`define SV_AXI_SEQUENCER_DEF

class axi_sequencer # (
	 parameter id_bits   = 10
	,parameter addr_bits = 32
	,parameter data_bits = 32
) extends uvm_sequencer #(id_bits, addr_bits, data_bits);

	`uvm_component_utils(axi_sequencer)
	function new(name="axi_sequencer", uvm_component parent);
		super.new(name, parent);
	endfunction

endclass: axi_sequencer

`endif // SV_AXI_SEQUENCER_DEF
