/*
   This file was generated automatically by the Mojo IDE version B1.3.6.
   Do not edit this file directly. Instead edit the original Lucid source.
   This is a temporary file and any changes made to it will be destroyed.
*/

module boolean_8 (
    input [3:0] alufn,
    input [15:0] a,
    input [15:0] b,
    output reg [15:0] bool
  );
  
  
  
  always @* begin
    
    case (alufn[0+3-:4])
      4'h8: begin
        bool = a & b;
      end
      4'he: begin
        bool = a | b;
      end
      4'h6: begin
        bool = a ^ b;
      end
      4'ha: begin
        bool = a;
      end
      4'hf: begin
        bool = ~(a | b);
      end
      4'h9: begin
        bool = ~(a & b);
      end
      4'h7: begin
        bool = ~(a ^ b);
      end
      default: begin
        bool = a;
      end
    endcase
  end
endmodule