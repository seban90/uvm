interface axi_interface # (
	 parameter id_bits   = 10
	,parameter addr_bits = 32
	,parameter data_bits = 128
)
(
	 input aclk
	,input arstn
);

	localparam strb_bits = data_bits/8;

	logic [  id_bits-1:0] awid       ;
	logic [addr_bits-1:0] awaddr     ;
	logic [        4-1:0] awlen      ;
	logic [        3-1:0] awsize     ;
	logic [        2-1:0] awburst    ;
	logic [        4-1:0] awcache    ;
	logic                 awvalid    ;
	logic                 awready    ;

	logic [  id_bits-1:0] wid        ;
	logic [data_bits-1:0] wdata      ;
	logic [strb_bits-1:0] wstrb      ;
	logic                 wvalid     ;
	logic                 wready     ;

	logic [  id_bits-1:0] bid        ;
	logic [        2-1:0] bresp      ;
	logic                 bvalid     ;
	logic                 bready     ;


	logic [  id_bits-1:0] arid       ;
	logic [addr_bits-1:0] araddr     ;
	logic [        4-1:0] arlen      ;
	logic [        3-1:0] arsize     ;
	logic [        2-1:0] arburst    ;
	logic [        4-1:0] arcache    ;
	logic                 arvalid    ;
	logic                 arready    ;

	logic [  id_bits-1:0] rid        ;
	logic [        2-1:0] rresp      ;
	logic [data_bits-1:0] rdata      ;
	logic                 rvalid     ;
	logic                 rready     ;

	clocking mck @ (posedge aclk);
		default input #1step output #0.1;
		output awid, awaddr, awlen, awsize, awburst, awcache, awvalid;
		input  awready;
		output arid, araddr, arlen, arsize, arburst, arcache, arvalid;
		input  arready;
		output wid, wdata, wstrb, wvalid;
		input  wready;
		input  bid, bresp, bvalid;
		output bready;
		input  rid, rresp, rdata, rvalid;
		output rready;
	endclocking

	clocking sck @ (posedge aclk);
		default input #1step output #0.1;
		input  awid, awaddr, awlen, awsize, awburst, awcache, awvalid;
		output awready;
		input  arid, araddr, arlen, arsize, arburst, arcache, arvalid;
		output arready;
		input  wid, wdata, wstrb, wvalid;
		output wready;
		output bid, bresp, bvalid;
		input  bready;
		output rid, rresp, rdata, rvalid;
		input  rready;
	endclocking

	clocking mon @ (posedge aclk);
		default input #1step output #0.1;
		input awid, awaddr, awlen, awsize, awburst, awcache, awvalid;
		input awready;
		input arid, araddr, arlen, arsize, arburst, arcache, arvalid;
		input arready;
		input wid, wdata, wstrb, wvalid;
		input wready;
		input bid, bresp, bvalid;
		input bready;
		input rid, rresp, rdata, rvalid;
		input rready;
	endclocking

	// Coverage
	covergroup cg_write_address @ (posedge awvalid);
		size  : coverpoint awsize {
			bins bytes_1   = {0};
			bins bytes_2   = {1};
			bins bytes_4   = {2};
			bins bytes_8   = {3};
			bins bytes_16  = {4};
			bins bytes_32  = {5};
			bins bytes_64  = {6};
			bins bytes_128 = {7};
		}
		burst : coverpoint awburst {
			bins fixed = {0}; // Fixed addressing
			bins incr  = {1}; // incremental addressing
			bins wrap  = {2}; // Wrapping Incremental addressing (4K)
		}
		cache : coverpoint awcache {
			bins non_cache_non_buffer         = {4'b0000};
			bins buffer                       = {4'b0001};
			bins cache_non_alloc              = {4'b0010};
			bins cache_buf_non_alloc          = {4'b0011};
			bins cache_write_through_alloc_RO = {4'b0110};
			bins cache_write_back_alloc_RO    = {4'b0111};
			bins cache_write_through_alloc_WO = {4'b1010};
			bins cache_write_back_alloc_WO    = {4'b1011};
			bins cache_write_through_alloc_RW = {4'b1110};
			bins cache_write_back_alloc_RW    = {4'b1111};
		}
	endgroup

	covergroup cg_read_address @ (posedge awvalid);
		size  : coverpoint arsize {
			bins bytes_1   = {0};
			bins bytes_2   = {1};
			bins bytes_4   = {2};
			bins bytes_8   = {3};
			bins bytes_16  = {4};
			bins bytes_32  = {5};
			bins bytes_64  = {6};
			bins bytes_128 = {7};
		}
		burst : coverpoint arburst {
			bins fixed = {0}; // Fixed addressing
			bins incr  = {1}; // incremental addressing
			bins wrap  = {2}; // Wrapping Incremental addressing (4K)
		}
		cache : coverpoint arcache {
			bins non_cache_non_buffer         = {4'b0000};
			bins buffer                       = {4'b0001};
			bins cache_non_alloc              = {4'b0010};
			bins cache_buf_non_alloc          = {4'b0011};
			bins cache_write_through_alloc_RO = {4'b0110};
			bins cache_write_back_alloc_RO    = {4'b0111};
			bins cache_write_through_alloc_WO = {4'b1010};
			bins cache_write_back_alloc_WO    = {4'b1011};
			bins cache_write_through_alloc_RW = {4'b1110};
			bins cache_write_back_alloc_RW    = {4'b1111};
		}
	endgroup

endinterface
