`ifndef SV_AXI_SEQ_BASE_DEF
`define SV_AXI_SEQ_BASE_DEF

class axi_seq_base # (
	 parameter id_bits   = 10
	,parameter addr_bits = 32
	,parameter data_bits = 32
) extends uvm_sequence #(axi_seq_item#(id_bits,addr_bits,data_bits));

	axi_seq_item#(id_bits,addr_bits,data_bits) item;
	`uvm_object_utils(axi_seq_base)
	function new(string name="axi_seq_base");
		super.new(name);
		item = axi_seq_item#(id_bits,addr_bits,data_bits)::type_id::create("axi_seq_item");
	endfunction

	task body;
	endtask;

endclass: axi_seq_base
`endif // SV_AXI_SEQ_BASE_DEF
