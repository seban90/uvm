`ifndef NX__SV__AHB_IF
`define NX__SV__AHB_IF
interface AHB_IF (
	 input HCLK
	,input HRSTN
);

	logic [31:0] HADDR  ;
	logic [ 1:0] HTRANS ;
	logic        HWRITE ;
	logic [ 2:0] HSIZE  ;
	logic        HLOCK  ;
	logic [ 2:0] HBURST ;
	logic [ 3:0] HPROT  ;
	logic [31:0] HWDATA ;
	logic [31:0] HRDATA ;
	logic [ 1:0] HRESP  ;
	logic        HREADY ;

	event debug__trigger_point0;
	event debug__trigger_point1;
	event debug__trigger_point2;
	event debug__trigger_point3;

	clocking ck_master @ (posedge HCLK);
		default input #1step output #0.01;
		output HADDR  ;
		output HTRANS ;
		output HWRITE ;
		output HSIZE  ;
		output HLOCK  ;
		output HBURST ;
		output HPROT  ;
		output HWDATA ;
		input  HRDATA ;
		input  HRESP  ;
		input  HREADY ;
	endclocking

	clocking ck_slave @ (posedge HCLK);
		default input #1step output #0.01;
		input  HADDR  ;
		input  HTRANS ;
		input  HWRITE ;
		input  HSIZE  ;
		input  HLOCK  ;
		input  HBURST ;
		input  HPROT  ;
		input  HWDATA ;
		output HRDATA ;
		output HRESP  ;
		output HREADY ;
	endclocking

	clocking ck_mon @ (posedge HCLK);
		default input #1step output #0.01;
		input HADDR  ;
		input HTRANS ;
		input HWRITE ;
		input HSIZE  ;
		input HLOCK  ;
		input HBURST ;
		input HPROT  ;
		input HWDATA ;
		input HRDATA ;
		input HRESP  ;
		input HREADY ;
	endclocking

endinterface
`endif // NX__SV__AHB_IF
