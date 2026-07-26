// A special module for connecting two nets bidirectionally
module net_connect #(parameter int WIDTH=1) (w0, w1);
inout wire [WIDTH-1:0] w0;
inout wire [WIDTH-1:0] w1;
assign w0 = w1;
assign w1 = w0;
endmodule
