`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////


module DSP_DATA_SWITCH
#(parameter DATA_WIDTH_IN_BYTES = 4)
(
input   wire ACLK,
input   wire ARESETn,
//setting
input   wire   [7:0]                    s_axis_tdata_sel,
input   wire                            s_axis_tvalid_sel,
output  wire                            s_axis_tready_sel,

//1
input  wire [8*DATA_WIDTH_IN_BYTES-1:0] s_axis_tdata_0,
input  wire                             s_axis_tvalid_0,
input  wire                             s_axis_tlast_0,
output wire                             s_axis_tready_0,
//2
input  wire [8*DATA_WIDTH_IN_BYTES-1:0] s_axis_tdata_1,
input  wire                             s_axis_tlast_1,
input  wire                             s_axis_tvalid_1,
output wire                             s_axis_tready_1,
//3
input  wire [8*DATA_WIDTH_IN_BYTES-1:0] s_axis_tdata_2,
input  wire                             s_axis_tvalid_2,
input  wire                             s_axis_tlast_2,
output wire                             s_axis_tready_2 ,

output wire [8*DATA_WIDTH_IN_BYTES-1:0] m_axis_tdata ,
output wire                             m_axis_tvalid,
output wire                             m_axis_tlast,
input  wire                             m_axis_tready,

output reg RDY = 1
    );
    
reg [7:0] select = 0;
reg [7:0] select_reg = 0;

reg       state_sel  = 0,  next_state_sel  = 0;
reg [1:0] state_f    = 0,  next_state_f    = 0;

reg  allow_state_selection = 0;

localparam [1:0] ST_W = 3'd0, 
ST_S0_go = 3'd1, ST_S1_go = 3'd2, ST_S2_go = 3'd3;//, 

   
reg                              m_axis_tvalid_int;
reg                              m_axis_tready_0_int;
reg                              m_axis_tready_1_int;
reg                              m_axis_tready_2_int;
reg  [8*DATA_WIDTH_IN_BYTES-1:0] m_axis_tdata_int; 
reg                              m_axis_tlast_int;

reg                              s_axis_tvalid_sel_int;
reg                              s_axis_tready_sel_int;

reg                              m_axis_tready_reg;

reg                              s_axis_tvalid_0_reg;
reg                              s_axis_tvalid_1_reg;
reg                              s_axis_tvalid_2_reg;

reg [8*DATA_WIDTH_IN_BYTES-1:0]  m_axis_tdata_reg; 
reg                              m_axis_tlast_reg;

reg [8*DATA_WIDTH_IN_BYTES-1:0]  temp_m_axis_tdata_reg ; 
reg                              temp_m_axis_tlast_reg ; 
 

assign  m_axis_tvalid   = m_axis_tvalid_int;
assign  s_axis_tready_0 = m_axis_tready_0_int;
assign  s_axis_tready_1 = m_axis_tready_1_int;
assign  s_axis_tready_2 = m_axis_tready_2_int;
assign  m_axis_tdata    = m_axis_tdata_reg;
assign  m_axis_tlast    = m_axis_tlast_reg;

assign  s_axis_tready_sel = s_axis_tready_sel_int;

always @(posedge ACLK) begin
    if (!ARESETn)
        RDY        <= 1;
    else begin  
        if (select > 8'd2) RDY <= 0;
        else               RDY <= 1;
    end
end

//sel interface
always @* begin
    case (state_sel)
        1'd0: begin
            if (!s_axis_tvalid_sel_int) begin   
                next_state_sel        = 1'd0;
            end else  begin 
                 next_state_sel = 1'd1;
                if (select > 8'd2 )
                next_state_sel = 1'd0;
            end    
        end
          
        1'd1:begin
            if (!m_axis_tlast_int) begin   
               // next_state_sel = 1'd1;
                if (select > 8'd2 )
                    next_state_sel = 1'd0; 
                else next_state_sel = 1'd1; 
            end else  begin 
                next_state_sel = 1'd0;
                
            end    
        end  
        default: begin
            if (!s_axis_tvalid_sel_int) begin   
                next_state_sel        = 1'd0;
            end else  begin 
            next_state_sel = 1'd1;
            end    
        end
    endcase 

end
 
always @( posedge ACLK ) begin
    if (!ARESETn) begin
        state_sel             <= 1'd0;
        s_axis_tvalid_sel_int <= 0;
        s_axis_tready_sel_int <= 0;
        allow_state_selection <= 1'b0; 
        select_reg            <= 0;
        select                <= 0;
    end else begin
    state_sel             <= next_state_sel;
    s_axis_tvalid_sel_int <= s_axis_tvalid_sel;
    
    case (state_sel) 
     1'd0: begin
        s_axis_tready_sel_int <= 1'b1;
        if (select > 8'd2) 
              select <= s_axis_tdata_sel ;//8'd0;
        else  select <= select ;//8'd0;
        allow_state_selection <= 1'b0;
     end
   
     
     1'd1:begin
        s_axis_tready_sel_int <= 1'b0;
        select_reg            <= s_axis_tdata_sel;
        allow_state_selection <= 1'b1;
        
        if (s_axis_tlast_0 || s_axis_tlast_1 || s_axis_tlast_2 ) begin
            select <= select_reg;
        end
        
     end
     default: begin
        s_axis_tready_sel_int <= 1'b1;
        select                <= select ;
        allow_state_selection <= 1'b0;
     end
    endcase
    
    end 
end 

//f
always @* begin
    case (state_f)
        ST_W: begin
           if (m_axis_tready  && allow_state_selection) begin 
                
                    case (select)
                    8'd0: begin 
                        if ( s_axis_tvalid_0)   
                             next_state_f = ST_S0_go;
                        else next_state_f = ST_W;
                    end
                    
                    8'd1: begin   
                        if (s_axis_tvalid_1_reg)   
                             next_state_f = ST_S1_go;
                        else next_state_f = ST_W;
                    end
                    
                    8'd2: begin   
                        if (s_axis_tvalid_2_reg)   
                             next_state_f = ST_S2_go;
                        else next_state_f = ST_W;
                    end
                    
                    default:begin      
                        next_state_f = ST_W;
                    end
                    endcase
                 
           end else begin
                next_state_f = ST_W;
           end
        end
        //-----------------------------------------------
        
        ST_S0_go:begin          
            if (!m_axis_tlast_int) begin
                next_state_f = ST_S0_go;
            end else begin
                next_state_f = ST_W;
            end 
              
        end
        
        //---------------------------------------------------
      
        ST_S1_go:begin           
            if (!m_axis_tlast_int) begin
                next_state_f = ST_S1_go;
            end else begin
                next_state_f = ST_W;
            end 
              
        end
        
        //--------------------------------------------------
        
        ST_S2_go:begin
        
            if (!m_axis_tlast_int) begin
                 next_state_f = ST_S2_go;
            end else begin
                 next_state_f = ST_W;
            end 
              
        end

        default: begin
            if (m_axis_tready_reg && allow_state_selection) begin 
                case (select)
                8'd0:    next_state_f = ST_S0_go;
                8'd1:    next_state_f = ST_S1_go;
                8'd2:    next_state_f = ST_S2_go;
                default: next_state_f = ST_W; 
                endcase 
           end else begin
                next_state_f = ST_W;
           end  
        end
    endcase 

end

always @(posedge ACLK) begin
    if(!ARESETn) begin
        state_f               <= ST_W;
        m_axis_tready_reg     <= 0;
        s_axis_tvalid_0_reg   <= 0;
        s_axis_tvalid_1_reg   <= 0;
        s_axis_tvalid_2_reg   <= 0;
        m_axis_tready_0_int   <= 0;
        m_axis_tready_1_int   <= 0;
        m_axis_tready_2_int   <= 0;
        m_axis_tvalid_int     <= 0;
        m_axis_tlast_int      <= 0;
        m_axis_tdata_int      <= 0;
        m_axis_tdata_reg      <= 0;
        temp_m_axis_tdata_reg <= 0;    
        temp_m_axis_tlast_reg <= 0;    
        m_axis_tlast_reg      <= 0;    
       
    end else begin
    
            state_f             <= next_state_f;
            m_axis_tready_reg   <= m_axis_tready; 
            s_axis_tvalid_0_reg <= s_axis_tvalid_0;
            s_axis_tvalid_1_reg <= s_axis_tvalid_1; 
            s_axis_tvalid_2_reg <= s_axis_tvalid_2;
        
            case (select)
                8'd0:begin
                    m_axis_tdata_int    <= s_axis_tdata_0;
                    m_axis_tlast_int    <= s_axis_tlast_0;
                      if (m_axis_tlast_int || (m_axis_tready_0_int && !(m_axis_tready || !s_axis_tvalid_0_reg)))
                    m_axis_tready_0_int <= 0;
                     else m_axis_tready_0_int <= m_axis_tready_reg;
                    m_axis_tready_1_int <= 0;
                    m_axis_tready_2_int <= 0;
                end
                8'd1:begin
                     m_axis_tdata_int    <= s_axis_tdata_1;
                    m_axis_tlast_int    <= s_axis_tlast_1;
                      if (m_axis_tlast_int || (m_axis_tready_1_int && !(m_axis_tready || !s_axis_tvalid_1_reg)))
                    m_axis_tready_1_int <= 0;
                     else m_axis_tready_1_int <= m_axis_tready_reg;
                    m_axis_tready_0_int <= 0;
                    m_axis_tready_2_int <= 0;
                end
               8'd2:begin
                    m_axis_tdata_int    <= s_axis_tdata_2;
                    m_axis_tlast_int    <= s_axis_tlast_2;
                      if (m_axis_tlast_int || (m_axis_tready_2_int && !(m_axis_tready || !s_axis_tvalid_2_reg)))
                    m_axis_tready_2_int <= 0;
                     else m_axis_tready_2_int <= m_axis_tready_reg;
                    m_axis_tready_1_int <= 0;
                    m_axis_tready_0_int <= 0;
                end
                default:begin
                    m_axis_tdata_int    <= s_axis_tdata_0; 
                    m_axis_tready_0_int <= 0;
                    m_axis_tready_1_int <= 0;
                    m_axis_tready_2_int <= 0;
                end
            endcase
        case (state_f)
            ST_W: begin 
            m_axis_tlast_int    <= 0; 
              case (select)
                8'd0:    m_axis_tvalid_int   <= s_axis_tvalid_0; 
                8'd1:    m_axis_tvalid_int   <= s_axis_tvalid_1; 
                8'd2:    m_axis_tvalid_int   <= s_axis_tvalid_2; 
                default: m_axis_tvalid_int   <= 0;
              endcase 
                  
            end 
           
            ST_S0_go:begin
                if (m_axis_tready_0_int) begin
               
                       if (m_axis_tready || !s_axis_tvalid_0_reg) begin
                           m_axis_tlast_reg  <= m_axis_tlast_int;
                           m_axis_tdata_reg  <= m_axis_tdata_int;
                           if (RDY)
                                m_axis_tvalid_int <= s_axis_tvalid_0;//;
                           else m_axis_tvalid_int <= 0;

                       end else begin
                            temp_m_axis_tdata_reg  <=  m_axis_tdata_int;     
                            temp_m_axis_tlast_reg <=  m_axis_tlast_int;
                            if (RDY)
                                 m_axis_tvalid_int <= s_axis_tvalid_0_reg;//;
                            else m_axis_tvalid_int <= 0;
                       end 
                 end else if (m_axis_tready) begin
                   
                      m_axis_tdata_reg     <= temp_m_axis_tdata_reg;
                      m_axis_tlast_reg     <= temp_m_axis_tlast_reg;
                      if (!s_axis_tlast_0)
                          if (RDY)
                               m_axis_tvalid_int <= s_axis_tvalid_0_reg;
                          else m_axis_tvalid_int <= 0;
                      else m_axis_tvalid_int <= s_axis_tvalid_0;      
                      
                 end
                            
                   
            end
          
            ST_S1_go: begin
                 if (m_axis_tready_1_int) begin
               
                       if (m_axis_tready || !s_axis_tvalid_1_reg) begin
                           m_axis_tlast_reg  <= m_axis_tlast_int;
                           m_axis_tdata_reg  <= m_axis_tdata_int;
                           
                           if (RDY)                  
                              m_axis_tvalid_int <= s_axis_tvalid_1;//;
                           else   m_axis_tvalid_int <= 0; 
                                    
                       end else begin
                            temp_m_axis_tdata_reg  <=  m_axis_tdata_int;     
                            temp_m_axis_tlast_reg <=  m_axis_tlast_int;
                            if (RDY)                      
                             m_axis_tvalid_int <= s_axis_tvalid_1_reg;//;
                            else   m_axis_tvalid_int <= 0; 
                       end 
                 end else if (m_axis_tready) begin
                      m_axis_tdata_reg     <= temp_m_axis_tdata_reg;
                      m_axis_tlast_reg     <= temp_m_axis_tlast_reg;
                      if (!s_axis_tlast_1)
                            if (RDY)                      
                                 m_axis_tvalid_int      <= s_axis_tvalid_1_reg;
                            else m_axis_tvalid_int <= 0;
                      else m_axis_tvalid_int <= s_axis_tvalid_1;           
                 end
            end
           
            ST_S2_go: begin
                 if (m_axis_tready_2_int) begin
               
                       if (m_axis_tready || !s_axis_tvalid_2_reg) begin
                           m_axis_tlast_reg  <= m_axis_tlast_int;
                           m_axis_tdata_reg  <= m_axis_tdata_int;
                           if (RDY)                      
                                  m_axis_tvalid_int <= s_axis_tvalid_2;//;
                           else   m_axis_tvalid_int <= 0;
                       end else begin
                            temp_m_axis_tdata_reg  <=  m_axis_tdata_int;     
                            temp_m_axis_tlast_reg <=  m_axis_tlast_int;
                            if (RDY)                      
                                   m_axis_tvalid_int <= s_axis_tvalid_2_reg;//;
                            else   m_axis_tvalid_int <= 0; 
                       end 
                 end else if (m_axis_tready) begin
                      m_axis_tdata_reg     <= temp_m_axis_tdata_reg;
                      m_axis_tlast_reg     <= temp_m_axis_tlast_reg;
                      if (!s_axis_tlast_2)
                             if (RDY)                      
                                  m_axis_tvalid_int      <= s_axis_tvalid_2_reg;
                             else   m_axis_tvalid_int <= 0;
                      else m_axis_tvalid_int <= s_axis_tvalid_2;                      
                 end
            end
            default: begin
              m_axis_tlast_int    <= 0; 
              case (select)
                8'd0:    m_axis_tvalid_int   <= s_axis_tvalid_0; 
                8'd1:    m_axis_tvalid_int   <= s_axis_tvalid_1; 
                8'd2:    m_axis_tvalid_int   <= s_axis_tvalid_2; 
                default: m_axis_tvalid_int   <= 0;
              endcase 
            end 
         
        
        endcase
    end
end
  
endmodule
