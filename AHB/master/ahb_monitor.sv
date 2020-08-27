`ifndef SV_DEF__SV__AHB_MONITOR
`define SV_DEF__SV__AHB_MONITOR
class ahb_monitor extends uvm_monitor;
	typedef enum{READ = 0, WRITE = 1} __trans_type;
	virtual AHB_IF vif;
	int     is_ahb_get;
	ahb_sequence_item item;
	uvm_analysis_port#(ahb_sequence_item) ahb_item_port;

	bit [31:0] prev_haddr  ;
	bit [ 1:0] prev_htrans ;
	bit        prev_hwrite ;
	bit [ 2:0] prev_hsize  ;
	bit        prev_hlock  ;
	bit [ 2:0] prev_hburst ;
	bit [ 3:0] prev_hprot  ;
	bit [31:0] prev_hwdata ;
	bit [31:0] prev_hrdata ;
	bit [ 1:0] prev_hresp  ;
	__trans_type trans_type;

	`uvm_component_utils(ahb_monitor)

	function new(string name="ahb_monitor", uvm_component parent);
		super.new(name, parent);
		ahb_item_port = new("ahb_item_port", this);
		this.is_ahb_get = 0;
		this.prev_haddr  = 0;
		this.prev_htrans = 0;
		this.prev_hwrite = 0;
		this.prev_hsize  = 0;
		this.prev_hlock  = 0;
		this.prev_hburst = 0;
		this.prev_hprot  = 0;
		this.prev_hwdata = 0;
		this.prev_hrdata = 0;
		this.prev_hresp  = 0;
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		// item = ahb_sequence_item::type_id::create("item", this);
		if (!uvm_config_db#(virtual AHB_IF)::get(this, "", "ahb_vif", vif))
			`uvm_error("", "uvm_config_db::get failed")
	endfunction


	task run_phase (uvm_phase phase);
		super.run_phase(phase);
		@ (posedge this.vif.HRSTN);
		forever begin
			item = new("item");
			@ (this.vif.ck_mon);
			// TODO
		end
	endtask

endclass: ahb_monitor
`endif // SV_DEF__SV__AHB_MONITOR
