module reg_file (
    input  logic [7:0] din,
    input  logic [2:0] addr,
    input  logic       wr,
    input  logic       rd,
    input  logic       clk,
    input  logic       resetn,
    output logic [7:0] dout,
    output logic       error
);

  logic [7:0] mem [0:7];

  typedef enum logic [1:0]{
    WRITE = 2'b01,
    READ  = 2'b10,
    ERROR = 2'b11 
  } state_t;

  logic [1:0] state;
  assign state = {rd,wr};

  always_ff @(posedge clk) begin
    if(!resetn) begin
      error <= 0;
      dout <= 8'b0;
      mem <= '{default : 0};
    end
    else begin
      error <= 1'b0;  
      case (state)
        WRITE: mem[addr] <= din;
        READ: dout <= mem[addr];
        ERROR: error <= 1;
        default: dout <= 8'b0;
      endcase
    end
  end

endmodule
