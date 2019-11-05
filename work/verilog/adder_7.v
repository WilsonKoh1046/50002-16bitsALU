/*
   This file was generated automatically by the Mojo IDE version B1.3.6.
   Do not edit this file directly. Instead edit the original Lucid source.
   This is a temporary file and any changes made to it will be destroyed.
*/

module adder_7 (
    input [15:0] a,
    input [15:0] b,
    input [5:0] alufn,
    output reg [15:0] sum,
    output reg z,
    output reg v,
    output reg n
  );
  
  
  
  reg [15:0] holder;
  
  always @* begin
    
    case (alufn[0+0-:1])
      1'h0: begin
        holder = a + b;
        v = ((a[15+0-:1] & b[15+0-:1] & (~holder[15+0-:1])) | (~a[15+0-:1] & ~b[15+0-:1] & (holder[15+0-:1])));
      end
      1'h1: begin
        holder = a - b;
        v = ((a[15+0-:1] & ~b[15+0-:1] & (~holder[15+0-:1])) | (~a[15+0-:1] & b[15+0-:1] & (holder[15+0-:1])));
      end
      default: begin
        holder = a + b;
        v = ((a[15+0-:1] & b[15+0-:1] & (~holder[15+0-:1])) | (~a[15+0-:1] & ~b[15+0-:1] & (holder[15+0-:1])));
      end
    endcase
    sum = holder[0+15-:16];
    z = (~|holder);
    n = ~holder[15+0-:1];
  end
endmodule
