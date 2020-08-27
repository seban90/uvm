`ifndef SV_DEF__SV__AHB_AGENT
`define SV_DEF__SV__AHB_AGENT
class ahb_agent extends uvm_agent;

	ahb_driver     drv    ;
	ahb_sequencer  sqr    ;
	ahb_monitor    monitor;
	virtual AHB_IF vif    ;

	uvm_analysis_port#(ahb_sequence_item) ahb_item_port;

	`uvm_component_utils(ahb_agent)
	function new(string name="ahb_agent", uvm_component parent);
		super.new(name, parent);
		ahb_item_port = new("ahb_item_port",this);
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		if (!uvm_config_db#(virtual AHB_IF)::get(this, "", "ahb_vif", vif))
			`uvm_error("", "uvm_config_db::get failed")

		drv     = ahb_driver::type_id::create("ahb_driver", this);
		sqr     = ahb_sequencer::type_id::create("ahb_sequencer", this);
		monitor = ahb_monitor::type_id::create("ahb_monitor", this);

		//uvm_config_db#(ahb_sequencer)::set(null, "uvm_test_top", "ahb_master_sequencer", sqr);
		uvm_config_db#(ahb_sequencer)::set(this, "", "ahb_sequencer", sqr);
		//uvm_config_db#(virtual AHB_IF)::set(this, "ahb_sequencer", "ahb_vif",vif);
		uvm_config_db#(virtual AHB_IF)::set(this, "ahb_driver", "ahb_vif",vif);
		uvm_config_db#(virtual AHB_IF)::set(this, "ahb_monitor", "ahb_vif",vif);
	endfunction
	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		monitor.ahb_item_port.connect(ahb_item_port);
		drv.seq_item_port.connect(sqr.seq_item_export);
	endfunction


endclass: ahb_agent
`endif // SV_DEF__SV__AHB_AGENT
