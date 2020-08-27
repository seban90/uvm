`ifndef SV_DEF__SV__AHB_SEQUENCE_BASE
`define SV_DEF__SV__AHB_SEQUENCE_BASE
class ahb_sequence_base extends uvm_sequence#(ahb_sequence_item);

	ahb_sequence_item item;
	`uvm_object_utils(ahb_sequence_base)
	function new(string name="ahb_sequence_base");
		super.new(name);
		item = ahb_sequence_item::type_id::create("test_item");
	endfunction
	task body();
		// override
	endtask

endclass: ahb_sequence_base
`endif // SV_DEF__SV__AHB_SEQUENCE_BASE
