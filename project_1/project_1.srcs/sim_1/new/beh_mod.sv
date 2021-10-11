`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.10.2021 19:11:38
// Design Name: 
// Module Name: beh_mod
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


module beh_mod(
input ACLK,
input s_axis_tready_0,
input s_axis_tvalid_0,
output reg [31:0] s_axis_tdata_0 = 0,
output  reg       s_axis_tlast_0 = 0
    );
    
always @(posedge ACLK) begin

    if (s_axis_tvalid_0 &&  s_axis_tready_0) begin
    if (s_axis_tdata_0 == 14) begin  
             s_axis_tlast_0 <= 1;
    end else s_axis_tlast_0 <= 0;
             if (s_axis_tdata_0 >= 15) begin  
                 
                 s_axis_tdata_0 <= 0; 
             end else  begin 
                s_axis_tdata_0 <= s_axis_tdata_0 + 1;
             end    //    s_axis_tdata_0 <= cnt0;   
    end else s_axis_tdata_0 <= s_axis_tdata_0 ;
    
 
end
   
    
    
endmodule
