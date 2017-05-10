module controller_tb();

  reg clk, rst_n, iocs, iorw, rxd, cs, rw, addr, enable;
  wire rda, tbr, txd;
  reg[1:0] ioaddr;
  reg[7:0] cpubus_reg;
  wire[7:0] databus, cpubus, rx_data_peek;

Controller ctrl( .clk(clk), .rst_n(rst_n), .cs(cs), .rw(rw), .addr(addr),  .cpubus(cpubus), .rxd(rxd), .txd(txd), .rx_data_peek(peek));
/*
  spart spart0(   .clk(clk),
                  .rst_n(rst_n),
                  .iocs(iocs),
                  .iorw(iorw),
                  .rda(rda),
                  .tbr(tbr),
                  .ioaddr(ioaddr),
                  .databus(databus),
                  .txd(txd),
                  .rxd(rxd)
              );

  driver driver0( .clk(clk),
                  .rst_n(rst_n),
                  .cs(cs),
                  .rw(rw),
                  .addr(addr),
                  .iocs(iocs),
                  .iorw(iorw),
                  .rda(rda),
                  .tbr(tbr),
                  .ioaddr(ioaddr),
                  .databus(databus),
                  .cpubus(cpubus)
              );// */

  baud_rate_gen baud(
  		.clk(clk),
  		.rst_n(rst_n),
  		.en(enable));

always
  #10 clk = ~clk;

assign cpubus = rw ? 8'hzz : cpubus_reg;

// rst_n, rxd, cs, rw, addr, cpubus
initial begin
  clk = 0;
  rst_n = 0;
  cs = 1;
  rw = 0;
  addr = 0;
  cpubus_reg = 8'hzz;
  rxd = 1;

  repeat(10) @(negedge clk);
  rst_n = 1;

  repeat (24) @(posedge enable);
  rxd = 0;
  repeat (16) @(posedge enable);
  repeat (4) begin
    repeat (32) @(posedge enable);
    rxd = ~rxd;
  end
  repeat (16) @(posedge enable);
  rxd = 1;

  repeat(10) @(posedge clk);
  cpubus_reg = 8'h01;
  cs = 0;

  repeat(2) @(negedge clk);
  cpubus_reg = 8'h00;

  @(negedge clk);
  cpubus_reg = 8'hzz;
  rw = 1;

  repeat(10) @(negedge clk);
  $stop;
  
end

endmodule
