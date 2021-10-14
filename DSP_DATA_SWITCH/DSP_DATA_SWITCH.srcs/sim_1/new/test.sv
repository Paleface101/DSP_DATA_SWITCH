`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.10.2021 14:36:50
// Design Name: 
// Module Name: test
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module test( );
parameter WIDTH_IN_BYTES = 4;
parameter PERIOD_CLK = 5;
reg ACLK;
reg ARESETn;
//setting
reg      [7:0]                  s_axis_tdata_sel;      // input 
reg                             s_axis_tvalid_sel;     // input 
wire                            s_axis_tready_sel ; // output                          

//1                                                      // //1   
reg      [8*WIDTH_IN_BYTES-1:0]  s_axis_tdata_0;        // input 
reg                              s_axis_tvalid_0;       // input 
reg                              s_axis_tready_0;       // output
reg                              s_axis_tlast_0;
//2   
reg      [8*WIDTH_IN_BYTES-1:0]  s_axis_tdata_1;        // input 
reg                              s_axis_tvalid_1;       // input 
reg                              s_axis_tready_1;       // output
reg                              s_axis_tlast_1;
//3   
reg     [8*WIDTH_IN_BYTES-1:0]   s_axis_tdata_2;        // input 
reg                              s_axis_tvalid_2;       // input 
reg                              s_axis_tready_2;       // output
reg                              s_axis_tlast_2;

// out 
wire [8*WIDTH_IN_BYTES-1:0]      m_axis_tdata;          // output
wire                             m_axis_tvalid;         // output
logic                            m_axis_tready;         // input
wire                             m_axis_tlast; 


logic [8*WIDTH_IN_BYTES-1:0] cnt0; 
logic [8*WIDTH_IN_BYTES-1:0] cnt1; 
logic [8*WIDTH_IN_BYTES-1:0] cnt2; 
logic [8*WIDTH_IN_BYTES-1:0] cnt; 

logic s_axis_tvalid_0_sim ;
 logic s_axis_tready_0_sim;
 
 logic s_axis_tvalid_1_sim ;
 logic s_axis_tready_1_sim;
 
  logic s_axis_tvalid_2_sim ;
 logic s_axis_tready_2_sim;
always #(PERIOD_CLK) ACLK = !ACLK;


DSP_DATA_SWITCH #(.WIDTH_IN_BYTES(WIDTH_IN_BYTES)) FSM (.*);


always @(posedge ACLK) begin

    if (s_axis_tvalid_0_sim &&  s_axis_tready_0_sim) begin
    if (s_axis_tdata_0 == 14) begin  
             s_axis_tlast_0 <= 1;
    end else s_axis_tlast_0 <= 0;
             if (s_axis_tdata_0 >= 15) begin  
                 
                 s_axis_tdata_0 <= 0; 
             end else  begin 
                s_axis_tdata_0 <= s_axis_tdata_0 + 1;
             end   
    end else s_axis_tdata_0 <= s_axis_tdata_0 ;
   end
 always @(posedge ACLK) begin 
    if (s_axis_tvalid_1_sim &&  s_axis_tready_1_sim) begin 
     if (s_axis_tdata_1 == 86) begin  
             s_axis_tlast_1 <= 1;
    end else s_axis_tlast_1 <= 0;
             if (s_axis_tdata_1 <= 85) begin  
                 
                 s_axis_tdata_1 <= 100; 
             end else  begin 
                s_axis_tdata_1 <= s_axis_tdata_1 - 1;
             end   
    end else s_axis_tdata_1 <= s_axis_tdata_1 ;
 end
 
 always @(posedge ACLK) begin  
       if (s_axis_tvalid_2_sim &&  s_axis_tready_2_sim) begin 
     if (s_axis_tdata_2 == 3000) begin  
             s_axis_tlast_2 <= 1;
    end else s_axis_tlast_2 <= 0;
             if (s_axis_tdata_2 >= 4000) begin  
                 
                 s_axis_tdata_2 <= 0; 
             end else  begin 
                s_axis_tdata_2 <= s_axis_tdata_2 + 1000;
             end   
    end else s_axis_tdata_2 <= s_axis_tdata_2 ;
 end

initial begin
fork 
        begin
ACLK    = 0;
ARESETn = 0;
cnt0 = 0;
cnt1 = 100;
cnt2 = 0;
s_axis_tdata_sel  = 0;

s_axis_tvalid_sel = 0;
m_axis_tready   = 0;

s_axis_tlast_0  = 0;
s_axis_tlast_1  = 0;
s_axis_tlast_2  = 0;

s_axis_tdata_1  = 100;
s_axis_tdata_0  = 0;
s_axis_tdata_2  = 0;

s_axis_tvalid_0 = 0;
s_axis_tvalid_1 = 0;
s_axis_tvalid_2 = 0;
        s_axis_tvalid_1_sim = 0;
        s_axis_tready_1_sim = 0;  
        //
        #(2*PERIOD_CLK)
        ARESETn = 1;
        //1
        #(10*PERIOD_CLK)
        @(posedge ACLK) ;cnt = 1;
        s_axis_tdata_sel  = 0;
        s_axis_tvalid_sel = 1;
        m_axis_tready <= 1;
        { s_axis_tvalid_0, s_axis_tvalid_1, s_axis_tvalid_2} 
        <={  1'b0, 1'b1, 1'b1};
        s_axis_tvalid_0_sim = 0 ;
         @(posedge ACLK) 
         @(posedge ACLK) 
        s_axis_tready_0_sim = 1;
        //2
        #(10*PERIOD_CLK)
        @(posedge ACLK) ;cnt = 2;
        s_axis_tdata_sel  = 0;
        s_axis_tvalid_sel = 1;
        m_axis_tready <= 1;
        { s_axis_tvalid_0, s_axis_tvalid_1, s_axis_tvalid_2} 
        <={  1'b1, 1'b1, 1'b1};
        
        s_axis_tvalid_0_sim = 1 ;
      @(posedge ACLK)    
       @(posedge ACLK) 
        s_axis_tready_0_sim = 1;
        //3
        #(10*PERIOD_CLK)
        @(posedge ACLK) ;cnt = 3;
        s_axis_tdata_sel  = 0;
        s_axis_tvalid_sel = 1;
        m_axis_tready <= 0;
        { s_axis_tvalid_0, s_axis_tvalid_1, s_axis_tvalid_2} 
        <={ 1'b1, 1'b1, 1'b1};
        s_axis_tvalid_0_sim = 1 ; 
        @(posedge ACLK) 
         
        s_axis_tready_0_sim = 0;
        //4
        #(10*PERIOD_CLK)
        @(posedge ACLK) ;cnt = 4;
        s_axis_tdata_sel  = 0;
        s_axis_tvalid_sel = 1;
        m_axis_tready    <= 1;
        { s_axis_tvalid_0, s_axis_tvalid_1, s_axis_tvalid_2} 
        <={ 1'b0, 1'b1, 1'b1};
        s_axis_tvalid_0_sim = 0 ;
         @(posedge ACLK) 
          @(posedge ACLK) 
        s_axis_tready_0_sim = 1;
        //5
        #(10*PERIOD_CLK)
        @(posedge ACLK) ;cnt = 5;
        s_axis_tdata_sel  = 0;
        s_axis_tvalid_sel = 1;
        {m_axis_tready, s_axis_tvalid_0, s_axis_tvalid_1, s_axis_tvalid_2} 
        <={ 1'b1, 1'b1, 1'b1, 1'b1};
        s_axis_tvalid_0_sim = 1 ;
        @(posedge ACLK) 
         @(posedge ACLK) 
        s_axis_tready_0_sim = 1;
        
                #(20*PERIOD_CLK)
        @(posedge ACLK) ;cnt = 6;
        s_axis_tdata_sel  = 0;
        s_axis_tvalid_sel = 1;
        {m_axis_tready, s_axis_tvalid_0, s_axis_tvalid_1, s_axis_tvalid_2} 
        <={ 1'b1, 1'b0, 1'b1, 1'b1};
        s_axis_tvalid_0_sim = 0 ;
        @(posedge ACLK) 
         @(posedge ACLK) 
        s_axis_tready_0_sim = 1;
        
     
        @(posedge ACLK) ;cnt = 7;
        s_axis_tdata_sel  = 0;
        s_axis_tvalid_sel = 1;
        {m_axis_tready, s_axis_tvalid_0, s_axis_tvalid_1, s_axis_tvalid_2} 
        <={ 1'b0, 1'b1, 1'b1, 1'b1};
        s_axis_tvalid_0_sim = 1 ;
        @(posedge ACLK) 
         @(posedge ACLK) 
        s_axis_tready_0_sim = 0;
        
          @(posedge ACLK) ;cnt = 8;
        s_axis_tdata_sel  = 0;
        s_axis_tvalid_sel = 1;
        {m_axis_tready, s_axis_tvalid_0, s_axis_tvalid_1, s_axis_tvalid_2} 
        <={ 1'b1, 1'b1, 1'b1, 1'b1};
        s_axis_tvalid_0_sim = 1 ;
        @(posedge ACLK) 
         @(posedge ACLK) 
        s_axis_tready_0_sim = 1;
        
            #(5*PERIOD_CLK)    @(posedge ACLK) ;cnt = 9;
        s_axis_tdata_sel  = 0;
        s_axis_tvalid_sel = 1;
        {m_axis_tready, s_axis_tvalid_0, s_axis_tvalid_1, s_axis_tvalid_2} 
        <={ 1'b1, 1'b0, 1'b1, 1'b1};
        s_axis_tvalid_0_sim = 0 ;
        @(posedge ACLK) 
         @(posedge ACLK) 
        s_axis_tready_0_sim = 1;
        
                    #(5*PERIOD_CLK)    @(posedge ACLK) ;cnt = 10;
        s_axis_tdata_sel  = 0;
        s_axis_tvalid_sel = 1;
        {m_axis_tready, s_axis_tvalid_0, s_axis_tvalid_1, s_axis_tvalid_2} 
        <={ 1'b1, 1'b1, 1'b1, 1'b1};
        s_axis_tvalid_0_sim = 1 ;
        @(posedge ACLK) 
        s_axis_tready_0_sim = 1;
        
                    #(5*PERIOD_CLK)    @(posedge ACLK) ;cnt = 11;
        s_axis_tdata_sel  = 0;
        s_axis_tvalid_sel = 1;
        {m_axis_tready, s_axis_tvalid_0, s_axis_tvalid_1, s_axis_tvalid_2} 
        <={ 1'b0, 1'b1, 1'b1, 1'b1};
        s_axis_tvalid_0_sim = 1 ;
        @(posedge ACLK) 
        s_axis_tready_0_sim = 0;
        
         #(5*PERIOD_CLK)    @(posedge ACLK) ;cnt = 12;
        s_axis_tdata_sel  = 0;
        s_axis_tvalid_sel = 1;
        {m_axis_tready, s_axis_tvalid_0, s_axis_tvalid_1, s_axis_tvalid_2} 
        <={ 1'b1, 1'b1, 1'b1, 1'b1};
        s_axis_tvalid_0_sim = 1 ;
        @(posedge ACLK) 
        @(posedge ACLK) 
        s_axis_tready_0_sim = 1;  
        
        #(3*PERIOD_CLK)    @(posedge ACLK) ;cnt = 13;
        s_axis_tdata_sel  = 0;
        s_axis_tvalid_sel = 1;
        {m_axis_tready, s_axis_tvalid_0, s_axis_tvalid_1, s_axis_tvalid_2} 
        <={ 1'b0, 1'b0, 1'b1, 1'b1};
        s_axis_tvalid_0_sim = 0 ;
        @(posedge ACLK) 
         
        s_axis_tready_0_sim = 0;
            
                #(3*PERIOD_CLK)    @(posedge ACLK) ;cnt = 14;
        s_axis_tdata_sel  = 0;
        s_axis_tvalid_sel = 1;
        {m_axis_tready, s_axis_tvalid_0, s_axis_tvalid_1, s_axis_tvalid_2} 
        <={ 1'b1, 1'b1, 1'b1, 1'b1};
        s_axis_tvalid_0_sim = 1 ;
        @(posedge ACLK) 
        @(posedge ACLK) 
        s_axis_tready_0_sim = 1;  
        
                   #(3*PERIOD_CLK)    @(posedge ACLK) ;cnt = 15;
        s_axis_tdata_sel  <= 1;
        s_axis_tvalid_sel <= 1;
        {m_axis_tready, s_axis_tvalid_0, s_axis_tvalid_1, s_axis_tvalid_2} 
        <={ 1'b1, 1'b1, 1'b1, 1'b1};
        s_axis_tvalid_0_sim = 1 ;
        s_axis_tready_0_sim = 1;
         @(posedge m_axis_tlast) 
          @(posedge  ACLK) 
            s_axis_tvalid_1_sim <= 1 ;
            s_axis_tready_1_sim = 1;  
            
     #(3*PERIOD_CLK)    @(posedge ACLK) ;cnt = 16;
        s_axis_tdata_sel  <= 3;
        s_axis_tvalid_sel <= 1;
        {m_axis_tready, s_axis_tvalid_0, s_axis_tvalid_1, s_axis_tvalid_2} 
        <={ 1'b1, 1'b1, 1'b1, 1'b1};
        s_axis_tvalid_0_sim = 0 ;
        s_axis_tready_0_sim = 0;
         @(posedge m_axis_tlast) 
          @(posedge  ACLK) 
            s_axis_tvalid_1_sim <= 1 ;
            s_axis_tready_1_sim = 1;  
            
        #(10*PERIOD_CLK)    @(posedge ACLK) ;cnt = 17;
        s_axis_tdata_sel  <= 2;
        s_axis_tvalid_sel <= 1;
        {m_axis_tready, s_axis_tvalid_0, s_axis_tvalid_1, s_axis_tvalid_2} 
        <={ 1'b1, 1'b1, 1'b1, 1'b1};
        s_axis_tvalid_0_sim = 0 ;
        s_axis_tready_0_sim = 0;
         @(posedge m_axis_tlast) 
          @(posedge  ACLK) 
            s_axis_tvalid_2_sim <= 1 ;
            s_axis_tready_2_sim = 1;       
            
            
            
        end
        
        
        
        begin
        #415 s_axis_tready_0_sim = 0 ; 
        #10 s_axis_tready_0_sim = 1 ; 
         //  #10 s_axis_tready_0_sim = 0 ; 
          //    #10 s_axis_tready_0_sim = 1 ; 
          #370 s_axis_tready_0_sim = 0 ; 
            #10 s_axis_tready_0_sim = 1 ;
            @(posedge  s_axis_tlast_0) 
            @(posedge  ACLK) @(posedge  ACLK) 
            s_axis_tready_0_sim = 0 ;
        end
        join
end 

endmodule
