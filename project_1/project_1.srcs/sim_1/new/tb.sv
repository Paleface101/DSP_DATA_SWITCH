`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////



module tb( );

SWITCH sw (.*);
///-------------------------------------------
parameter WIDTH_IN_BYTES = 4;
parameter PERIOD_CLK = 5;
reg ACLK;
reg  ARESETn;
//setting
reg      [7:0]                  s_axis_tdata_sel;      // input 
reg                             s_axis_tvalid_sel;     // input 
reg                             s_axis_tready_sel ; // output                          

//1                                                      // //1   
wire      [8*WIDTH_IN_BYTES-1:0] s_axis_tdata_0;        // input 
reg                             s_axis_tvalid_0;       // input 
reg                             s_axis_tready_0;       // output
reg                             s_axis_tlast_0;
//2   
wire      [8*WIDTH_IN_BYTES-1:0] s_axis_tdata_1;        // input 
reg                            s_axis_tvalid_1;       // input 
reg                            s_axis_tready_1;       // output
reg                             s_axis_tlast_1;
//3   
wire     [8*WIDTH_IN_BYTES-1:0]  s_axis_tdata_2;        // input 
reg                            s_axis_tvalid_2;       // input 
reg                             s_axis_tready_2;       // output
reg                             s_axis_tlast_2;

// out 
wire  [8*WIDTH_IN_BYTES-1:0]     m_axis_tdata;          // output
reg                              m_axis_tvalid;         // output
reg                              m_axis_tready;         // input
reg                             m_axis_tlast; 
                                                         //
logic  RDY = 1;                                          // output

logic [8*WIDTH_IN_BYTES-1:0] s_axis_tdata_0_reg;
logic [8*WIDTH_IN_BYTES-1:0] s_axis_tdata_1_reg;
logic [8*WIDTH_IN_BYTES-1:0] s_axis_tdata_2_reg;

logic  s_axis_tready_0_reg ;  
logic  s_axis_tvalid_0_reg;

logic  s_axis_tready_1_reg ;  
logic  s_axis_tvalid_1_reg;

logic  s_axis_tready_2_reg ;  
logic  s_axis_tvalid_2_reg;
bit [8*WIDTH_IN_BYTES-1:0] reg_value [16:0] ;

int  cnt;

initial begin 

ACLK    = 0;
ARESETn = 0;
s_axis_tdata_sel  = 0;
s_axis_tvalid_sel = 0;
cnt =0;
m_axis_tready   = 0;

s_axis_tdata_0_reg  = 0;  
s_axis_tvalid_0 = 0;
s_axis_tready_0_reg=0;
s_axis_tvalid_0_reg=0;
s_axis_tdata_1_reg  = 100; 
s_axis_tvalid_1 = 0;

s_axis_tdata_2_reg  = 0; 
s_axis_tvalid_2 = 0;
// 1
#(5*PERIOD_CLK)
@(posedge ACLK )ARESETn <= 1;
cnt = 1;
s_axis_tdata_sel  <= 0;
s_axis_tvalid_sel <= 1;

{s_axis_tready_0_reg , s_axis_tvalid_0_reg , s_axis_tvalid_1_reg , s_axis_tvalid_0_reg } =
{ 1'b1, 1'b1, 1'b1, 1'b1};
{m_axis_tready, s_axis_tvalid_0, s_axis_tvalid_1, s_axis_tvalid_2} <={ 1'b1, 1'b1, 1'b1, 1'b1};
// 2
#(5*PERIOD_CLK)
@(posedge ACLK )s_axis_tdata_sel  <= 0;
cnt = 2;
s_axis_tvalid_sel <= 0;
{m_axis_tready,s_axis_tvalid_0,s_axis_tvalid_1,s_axis_tvalid_2} <={ 1'b1, 1'b1, 1'b1, 1'b1};
{s_axis_tready_0_reg , s_axis_tvalid_0_reg , s_axis_tvalid_1_reg , s_axis_tvalid_0_reg } =
{ 1'b1, 1'b1, 1'b1, 1'b1};
// 3
#(5*PERIOD_CLK)
@(posedge ACLK )s_axis_tdata_sel  <= 0;
cnt = 3;
s_axis_tvalid_sel <= 1;
{m_axis_tready,s_axis_tvalid_0,s_axis_tvalid_1,s_axis_tvalid_2}<={ 1'b1, 1'b1, 1'b1, 1'b1};
{s_axis_tready_0_reg , s_axis_tvalid_0_reg , s_axis_tvalid_1_reg , s_axis_tvalid_0_reg } =
{ 1'b1, 1'b1, 1'b1, 1'b1};
#(PERIOD_CLK)
@(posedge ACLK )s_axis_tdata_sel  <= 0;
cnt = 4;
s_axis_tvalid_sel <= 1;
{m_axis_tready,s_axis_tvalid_0,s_axis_tvalid_1,s_axis_tvalid_2}<={ 1'b1, 1'b1, 1'b1, 1'b1};
{s_axis_tready_0_reg , s_axis_tvalid_0_reg , s_axis_tvalid_1_reg , s_axis_tvalid_0_reg } =
{ 1'b1, 1'b1, 1'b1, 1'b1};
#(PERIOD_CLK)
@(posedge ACLK )s_axis_tdata_sel  <= 0;
cnt = 5;
s_axis_tvalid_sel <= 1;
//s_axis_tvalid_0 <= 1'b0;

{m_axis_tready,s_axis_tvalid_0,s_axis_tvalid_1,s_axis_tvalid_2}<={ 1'b1,1'b0, 1'b1, 1'b1};
{s_axis_tready_0_reg , s_axis_tvalid_0_reg , s_axis_tvalid_1_reg , s_axis_tvalid_0_reg } =
{ 1'b1, 1'b0, 1'b1, 1'b1};
#(PERIOD_CLK)
@(posedge ACLK )s_axis_tdata_sel  <= 1;
cnt = 6;
s_axis_tvalid_sel <= 1;
//s_axis_tvalid_0 <= 0;

{m_axis_tready,s_axis_tvalid_0,s_axis_tvalid_1,s_axis_tvalid_2}<={ 1'b1,1'b0, 1'b1, 1'b1};
{s_axis_tready_0_reg , s_axis_tvalid_0_reg , s_axis_tvalid_1_reg , s_axis_tvalid_0_reg } =
{ 1'b1, 1'b0, 1'b1, 1'b1};
#(15*PERIOD_CLK)
$stop;
end
   assign   s_axis_tdata_0  =  s_axis_tdata_0_reg ;
   assign   s_axis_tdata_1  =  s_axis_tdata_1_reg ;
   assign   s_axis_tdata_2  =  s_axis_tdata_2_reg ;
 
   
 reg   m_axis_tready_reg;
 reg   m_axis_tvalid_reg;
 assign  m_axis_tvalid_reg = m_axis_tvalid;
 assign  m_axis_tready_reg = m_axis_tready;
 
  always
 #(PERIOD_CLK) ACLK = ~ACLK;


always @(posedge ACLK ) 
 begin

          if ( s_axis_tready_0_reg &&  s_axis_tvalid_0_reg) begin 
          s_axis_tdata_0_reg <= s_axis_tdata_0_reg + 1;
          end 
          else begin 
          s_axis_tdata_0_reg <= s_axis_tdata_0_reg;
          end
  end

 
 always @(posedge ACLK )  begin 
    
        if (s_axis_tready_1_reg  && s_axis_tvalid_1_reg ) begin
         s_axis_tdata_1_reg  <= s_axis_tdata_1_reg - 1;
         
         end
         else s_axis_tdata_1_reg <= s_axis_tdata_1_reg;
    
end
 
 always @(posedge ACLK )  begin
       
        if (s_axis_tready_2_reg  && s_axis_tvalid_2_reg ) begin
         s_axis_tdata_2_reg <= s_axis_tdata_2_reg + 500 ;
         end
        else s_axis_tdata_2_reg <= s_axis_tdata_2_reg;
    
 end
 
  always @(posedge ACLK) begin


    if (m_axis_tready && m_axis_tvalid) begin
        for (integer i = 16;i > 0;i--) begin
            reg_value[i] <= reg_value[i-1];
        end
        reg_value[0] <= m_axis_tdata;
    end
   end
                      
                     
endmodule
