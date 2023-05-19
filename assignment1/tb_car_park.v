module car_park_tb;

  
  reg clk;
  reg rst;
  reg front_s;
  reg back_s;
  reg [1:0] pass1;
  reg [1:0] pass2;

 
  wire GREEN_LED;
  wire RED_LED;
  wire [6:0] HEX_1;
  wire [6:0] HEX_2;
initial begin
 clk = 0;
 forever #10 clk = ~clk;
 end
 initial begin
 
 rst = 0;
 front_s = 0;
 back_s= 0;
 pass1 = 0;
 pass2 = 0;
 
 #100;
 rst = 1;
 #20;
 sensor1= 1;
 #1000;
 sensor1= 0;
 pass1 = 1;
 pass2 = 2;
 #2000;
 back_s=1;
 end
 endmodule


