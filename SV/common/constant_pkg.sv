`ifndef SV_UVM_CONSTANT_PKG
`define SV_UVM_CONSTANT_PKG
package constant_pkg;

	typedef struct {
		int id   ;
		int addr ;
		int data ;
	} bitwidth_config;

	parameter bitwidth_config bits_cfg = '{
		 id  : 10
		,addr: 32
		,data: 128
	};

endpackage: constant_pkg
`endif // SV_UVM_CONSTANT_PKG
