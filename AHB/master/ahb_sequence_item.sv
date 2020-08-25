`ifndef NX__SV__AHB_SEQUENCE_ITEM
`define NX__SV__AHB_SEQUENCE_ITEM
class ahb_sequence_item extends uvm_sequence_item;
	typedef enum {READ, WRITE} _type;
	typedef enum {
		 SINGLE
		,INCR
		,WRAP4
		,INCR4
		,WRAP8
		,INCR8
		,WRAP16
		,INCR16
	} _burst_type;

	typedef enum {
		 BYTE     = 0
		,HALFWORD = 1
		,WORD     = 2
	} _trans_size;

	typedef bit [31:0] _DATA[$];

	rand bit [32-1:0] addr;
	rand bit [32-1:0] data;

	_DATA        DATA;

	rand _type        TYPE;
	rand _burst_type  BURST;
	rand _trans_size  SIZE;
	rand bit          is_delay_trans;

	`uvm_object_utils(ahb_sequence_item)
	function new(string name="ahb_sequence_item");
		super.new(name);
		this.is_delay_trans = 0;
	endfunction

	task set_write(
	                 input bit [32-1:0] addr, 
	                 input bit [32-1:0] data  
	               );
		this.TYPE = ahb_sequence_item::WRITE;
		this.SIZE = WORD;
		this.TYPE = SINGLE;
		this.addr = addr;
		this.data = data;
		this.is_delay_trans = 0;

	endtask
	function void deep_copy(ahb_sequence_item it);
		this.addr = it.addr;
		this.data = it.data;
		this.TYPE = it.TYPE;
		this.BURST = it.BURST;
		this.SIZE = it.SIZE;
		this.is_delay_trans = it.is_delay_trans;

		if (it.DATA.size != 0)
			for (int i=0;i<it.DATA.size;i++) 
				this.DATA.push_back(it.DATA[i]);

	endfunction

endclass: ahb_sequence_item
`endif // NX__SV__AHB_SEQUENCE_ITEM
