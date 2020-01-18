//import constant_pkg::*;

`ifndef SV_AXI_SEQ_ITEM_DEF
`define SV_AXI_SEQ_ITEM_DEF

class axi_seq_item # (
	 parameter id_bits   = 10
	,parameter addr_bits = 32
	,parameter data_bits = 32
) extends uvm_sequence_item;

	typedef enum {fixed, incr, wrap} burst;

	bit [      id_bits-1:0] id                     ;
	bit [    addr_bits-1:0] addr                   ;
	bit [            4-1:0] len                    ;
	bit [            3-1:0] size                   ;
	bit [    data_bits-1:0] data[16]               ;
	bit [(data_bits/8)-1:0] strb[16]               ;
	burst                   burst_type             ;
	bit                     is_previleged          ;
	bit                     is_secure              ;
	bit                     is_instruction         ;

	`uvm_object_utils(axi_seq_item)
	function new(string name="axi_seq_item");
		super.new(name);
		this.id             = {id_bits{1'b0}}     ;
		this.addr           = {addr_bits{1'b0}}   ;
		this.len            = 4'b0                ;
		this.size           = 3'b0                ;
		this.burst_type     = axi_seq_item::incr  ;
		this.is_previleged  = 0                   ;
		this.is_secure      = 0                   ;
		this.is_instruction = 0                   ;

		for(int i=0;i<16;i++) this.data[i] = {data_bits{1'b0}};
		this.strb = '{default: {(data_bits/8){1'b0}}};

	endfunction
	function void deep_copy_with_data(axi_seq_item#(id_bits, addr_bits, data_bits) it);
		this.id               = it.id                 ;
		this.addr             = it.addr               ;
		this.len              = it.len                ;
		this.size             = it.size               ;
		this.burst_type       = it.burst_type         ;
		this.is_previleged    = it.is_previleged      ;
		this.is_secure        = it.is_secure          ;
		this.is_instruction   = it.is_instruction     ;

		for (int i=0;i<16;i++) this.data[i] = it.data[i];
		for (int i=0;i<16;i++) this.strb[i] = it.strb[i];

	endfunction

	function void deep_copy(axi_seq_item#(id_bits, addr_bits, data_bits) it);
		this.id               = it.id                 ;
		this.addr             = it.addr               ;
		this.len              = it.len                ;
		this.size             = it.size               ;
		this.burst_type       = it.burst_type         ;
		this.is_previleged    = it.is_previleged      ;
		this.is_secure        = it.is_secure          ;
		this.is_instruction   = it.is_instruction     ;
	endfunction

	function set_previlege();
		this.is_previleged = 1;
	endfunction
	function set_secure();
		this.is_secure = 1;
	endfunction
	function set_instruction();
		this.is_instruction = 1;
	endfunction


endclass: axi_seq_item

`endif // SV_AXI_SEQ_ITEM_DEF
