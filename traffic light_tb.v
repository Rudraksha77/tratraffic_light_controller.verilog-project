`timescale 1ns/1ns
module traffic_light_controller_tb;
reg clk;
reg rst;

wire A_red;
wire A_yellow;
wire A_green;

wire B_red;
wire B_yellow;
wire B_green;

//====================================================
// DUT (design under test)
    
traffic_light_controller #(    //#(...) ka use parameter values override karne ke liye hua hai.
    .CLK_FREQ(5),             //"Is particular instance ke liye default parameter values use mat karo; meri di hui values use karo."
    .GREEN_TIME(3),
    .YELLOW_TIME(1)
 
 )inst_traffic_light_controller (
    .clk(clk),
    .rst(rst),

    .A_red(A_red),
    .A_yellow(A_yellow),
    .A_green(A_green),

    .B_red(B_red),
    .B_yellow(B_yellow),
    .B_green(B_green)
  );

//====================================================
// 50 MHz Clock
// Period = 20 ns
    
always #10 clk = ~clk;
  initial begin
     clk = 1'b0;
     rst = 1'b1;

 
#100;

     rst = 1'b0;
#1000;
    $finish;
  end

//====================================================
    
initial begin
  $monitor("TIME=%0t ns | STATE=%b | COUNT=%0d | A_RED=%b | A_YELLOW=%b | A_GREEN=%b | B_RED=%b | B_YELLOW=%b | B_GREEN=%b",
            $time,
            inst_traffic_light_controller.state,
            inst_traffic_light_controller.count,
            A_red,
            A_yellow,
            A_green,
            B_red,
            B_yellow,
            B_green
        );
    end
endmodule