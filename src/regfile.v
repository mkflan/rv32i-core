module regfile(
  input          clk,       // Clock
  input  [4:0]   rs1,       // First source register index
  output [31:0]  rs1_data,  // Data read from rs1
  input  [4:0]   rs2,       // Second source register index
  output [31:0]  rs2_data,  // Data read from rs2
  input          we,        // Write-enable  
  input  [4:0]   rd,        // Destination register index
  input  [31:0]  rd_data    // Data to write to destination register
);
  reg [31:0] registers [0:31];

  // Sequential logic: write to rd only on positive clock edge
  always @(posedge clk) begin
    if (we && rd != 5'd0) registers[rd] <= rd_data;
  end

  // Combinational logic: for either, if the index is zero read out zero, otherwise the data in that register
  // Both synthesize to 2-to-1 multiplexers.
  assign rs1_data = (rs1 == 5'd0) ? 32'd0 : registers[rs1];
  assign rs2_data = (rs2 == 5'd0) ? 32'd0 : registers[rs2];
endmodule
