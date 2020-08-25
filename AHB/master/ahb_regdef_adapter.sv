class ahb_regdef_adapter extends uvm_reg_adapter;
	`uvm_object_utils(ahb_regdef_adapter)
	function new(string name="ahb_regdef_adapter");
		super.new(name);
	endfunction
	virtual function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
		ahb_sequence_item  item = ahb_sequence_item::type_id::create("item");
		item.TYPE = (rw.kind == UVM_READ) ? ahb_sequence_item::READ : ahb_sequence_item::WRITE;
		item.addr = rw.addr;
		item.BURST = ahb_sequence_item::SINGLE;
		item.SIZE = ahb_sequence_item::WORD;
		item.data = rw.data;
		return item;
	endfunction
	virtual function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
		ahb_sequence_item item;
		if (!$cast(item, bus_item)) begin
			`uvm_fatal("REG2BUG", "bus item is not a same type");
			return;
		end
		rw.kind = item.TYPE ? UVM_WRITE : UVM_READ;
		rw.addr = item.addr;
		rw.data = item.data;
		rw.status = UVM_IS_OK;
	endfunction

endclass: ahb_regdef_adapter
