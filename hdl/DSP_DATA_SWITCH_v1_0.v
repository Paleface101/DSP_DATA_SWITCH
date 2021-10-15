
`timescale 1 ns / 1 ps

	module DSP_DATA_SWITCH_v1_0 #
	(
		// Users to add parameters here
    parameter integer DATA_WIDTH_IN_BYTES	= 4
		// User parameters ends
		// Do not modify the parameters beyond this line


		// Parameters of Axi Slave Bus Interface S00_AXIS
//		parameter integer C_S00_AXIS_TDATA_WIDTH	= 32,
//
		// Parameters of Axi Slave Bus Interface S01_AXIS
	//	parameter integer C_S01_AXIS_TDATA_WIDTH	= 32,

		// Parameters of Axi Slave Bus Interface S02_AXIS
	//	parameter integer C_S02_AXIS_TDATA_WIDTH	= 32,

		// Parameters of Axi Slave Bus Interface S03_SEL_AXIS
	//	parameter integer C_S03_SEL_AXIS_TDATA_WIDTH	= 32,

		// Parameters of Axi Master Bus Interface M00_AXIS
	//	parameter integer C_M00_AXIS_TDATA_WIDTH	= 32,
	//	parameter integer C_M00_AXIS_START_COUNT	= 32
	)
	(
		// Users to add ports here
        output wire  RDY,
        input  wire  ACLK,
        input  wire  ARESETn,
		// User ports ends
		// Do not modify the ports beyond this line


		// Ports of Axi Slave Bus Interface S00_AXIS
	//	input wire  s00_axis_aclk ,
	//	input wire  s00_axis_aresetn,
		output wire  s00_axis_tready,
		input wire [8*DATA_WIDTH_IN_BYTES-1 : 0] s00_axis_tdata,
		//input wire [(C_S00_AXIS_TDATA_WIDTH/8)-1 : 0] s00_axis_tstrb,
		input wire  s00_axis_tlast,
		input wire  s00_axis_tvalid,

		// Ports of Axi Slave Bus Interface S01_AXIS
//		input wire  s01_axis_aclk,
//		input wire  s01_axis_aresetn,
		output wire  s01_axis_tready,
		input wire [8*DATA_WIDTH_IN_BYTES-1 : 0] s01_axis_tdata,
	//	input wire [(C_S01_AXIS_TDATA_WIDTH/8)-1 : 0] s01_axis_tstrb,
		input wire  s01_axis_tlast,
		input wire  s01_axis_tvalid,

		// Ports of Axi Slave Bus Interface S02_AXIS
//	input wire  s02_axis_aclk,
//		input wire  s02_axis_aresetn,
		output wire  s02_axis_tready,
		input wire [8*DATA_WIDTH_IN_BYTES-1 : 0] s02_axis_tdata,
	//	input wire [(C_S02_AXIS_TDATA_WIDTH/8)-1 : 0] s02_axis_tstrb,
		input wire  s02_axis_tlast,
		input wire  s02_axis_tvalid,

		// Ports of Axi Slave Bus Interface S03_SEL_AXIS
//	    input wire  s03_sel_axis_aclk,
//		input wire  s03_sel_axis_aresetn,
		output wire  s03_sel_axis_tready,
		input wire [7:0] s03_sel_axis_tdata,
	//	input wire [(C_S03_SEL_AXIS_TDATA_WIDTH/8)-1 : 0] s03_sel_axis_tstrb,
	//	input wire  s03_sel_axis_tlast,
		input wire  s03_sel_axis_tvalid,

		// Ports of Axi Master Bus Interface M00_AXIS
//	    input wire  m00_axis_aclk,
//		input wire  m00_axis_aresetn,
		output wire  m00_axis_tvalid,
		output wire [8*DATA_WIDTH_IN_BYTES-1 : 0] m00_axis_tdata,
		//output wire [(C_M00_AXIS_TDATA_WIDTH/8)-1 : 0] m00_axis_tstrb,
		output wire  m00_axis_tlast,
		input wire  m00_axis_tready
	);
	//assign 
	DSP_DATA_SWITCH 
	#(
	.DATA_WIDTH_IN_BYTES(DATA_WIDTH_IN_BYTES)
	)
	DSP_DATA_SWITCH
	(	
	//sel
	.s_axis_tdata_sel (s03_sel_axis_tdata ), 
	.s_axis_tvalid_sel(s03_sel_axis_tvalid),
	.s_axis_tready_sel(s03_sel_axis_tready),
	//                 
	
	//0
	.s_axis_tdata_0 (s00_axis_tdata),
	.s_axis_tvalid_0(s00_axis_tvalid),
	.s_axis_tready_0(s00_axis_tready),
	.s_axis_tlast_0 (s00_axis_tlast),
	//
	
	//1
	.s_axis_tdata_1 (s01_axis_tdata ),
	.s_axis_tvalid_1(s01_axis_tvalid),
	.s_axis_tready_1(s01_axis_tready),
	.s_axis_tlast_1 (s01_axis_tlast ),
	
	//
	
	//2
	.s_axis_tdata_2 (s02_axis_tdata ),
	.s_axis_tvalid_2(s02_axis_tvalid),
	.s_axis_tready_2(s02_axis_tready),
	.s_axis_tlast_2 (s02_axis_tlast ),
	
	//master
	.m_axis_tdata  (m00_axis_tdata ),
	.m_axis_tvalid (m00_axis_tvalid),
	.m_axis_tready (m00_axis_tready),
    .m_axis_tlast  (m00_axis_tlast ),
    //
    .RDY(RDY),
    .ACLK(ACLK),
    .ARESETn(ARESETn)
	);
	
// Instantiation of Axi Bus Interface S00_AXIS
/*
  	DSP_DATA_SWITCH_v1_0_S00_AXIS # ( 
				.C_S_AXIS_TDATA_WIDTH(C_S00_AXIS_TDATA_WIDTH)
			) DSP_DATA_SWITCH_v1_0_S00_AXIS_inst (
	)		.S_AXIS_ACLK(s00_axis_aclk),
				.S_AXIS_ARESETN(s00_axis_aresetn),
				.S_AXIS_TREADY(s00_axis_tready),
				.S_AXIS_TDATA(s00_axis_tdata),
				.S_AXIS_TSTRB(s00_axis_tstrb),
				.S_AXIS_TLAST(s00_axis_tlast),
				.S_AXIS_TVALID(s00_axis_tvalid)
			);
	)
*/// Instantiation of Axi Bus Interface S01_AXIS
/*
  	DSP_DATA_SWITCH_v1_0_S01_AXIS # ( 
				.C_S_AXIS_TDATA_WIDTH(C_S01_AXIS_TDATA_WIDTH)
			) DSP_DATA_SWITCH_v1_0_S01_AXIS_inst (
	)		.S_AXIS_ACLK(s01_axis_aclk),
				.S_AXIS_ARESETN(s01_axis_aresetn),
				.S_AXIS_TREADY(s01_axis_tready),
				.S_AXIS_TDATA(s01_axis_tdata),
				.S_AXIS_TSTRB(s01_axis_tstrb),
				.S_AXIS_TLAST(s01_axis_tlast),
				.S_AXIS_TVALID(s01_axis_tvalid)
			);
	)
*/// Instantiation of Axi Bus Interface S02_AXIS
/*
  	DSP_DATA_SWITCH_v1_0_S02_AXIS # ( 
				.C_S_AXIS_TDATA_WIDTH(C_S02_AXIS_TDATA_WIDTH)
			) DSP_DATA_SWITCH_v1_0_S02_AXIS_inst (
	)		.S_AXIS_ACLK(s02_axis_aclk),
				.S_AXIS_ARESETN(s02_axis_aresetn),
				.S_AXIS_TREADY(s02_axis_tready),
				.S_AXIS_TDATA(s02_axis_tdata),
				.S_AXIS_TSTRB(s02_axis_tstrb),
				.S_AXIS_TLAST(s02_axis_tlast),
				.S_AXIS_TVALID(s02_axis_tvalid)
			);
	)
*/// Instantiation of Axi Bus Interface S03_SEL_AXIS
/*
  	DSP_DATA_SWITCH_v1_0_S03_SEL_AXIS # ( 
				.C_S_AXIS_TDATA_WIDTH(C_S03_SEL_AXIS_TDATA_WIDTH)
			) DSP_DATA_SWITCH_v1_0_S03_SEL_AXIS_inst (
	)		.S_AXIS_ACLK(s03_sel_axis_aclk),
				.S_AXIS_ARESETN(s03_sel_axis_aresetn),
				.S_AXIS_TREADY(s03_sel_axis_tready),
				.S_AXIS_TDATA(s03_sel_axis_tdata),
				.S_AXIS_TSTRB(s03_sel_axis_tstrb),
				.S_AXIS_TLAST(s03_sel_axis_tlast),
				.S_AXIS_TVALID(s03_sel_axis_tvalid)
			);
	)
*/
// Instantiation of Axi Bus Interface M00_AXIS
/*    
    DSP_DATA_SWITCH_v1_0_M00_AXIS # ( 
		.C_M_AXIS_TDATA_WIDTH(C_M00_AXIS_TDATA_WIDTH),
		.C_M_START_COUNT(C_M00_AXIS_START_COUNT)
	) DSP_DATA_SWITCH_v1_0_M00_AXIS_inst (
		.M_AXIS_ACLK(m00_axis_aclk),
		.M_AXIS_ARESETN(m00_axis_aresetn),
		.M_AXIS_TVALID(m00_axis_tvalid),
		.M_AXIS_TDATA(m00_axis_tdata),
		.M_AXIS_TSTRB(m00_axis_tstrb),
		.M_AXIS_TLAST(m00_axis_tlast),
		.M_AXIS_TREADY(m00_axis_tready)
	);
*/

	// Add user logic here

	// User logic ends

	endmodule
