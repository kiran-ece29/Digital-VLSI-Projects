`timescale 1ns/1ps

module tb_traffic_light_4way;

    reg clk;
    reg rst;
    wire [1:0] r1, r2, r3, r4;

    traffic_light_4way dut (
        .clk(clk),
        .rst(rst),
        .r1(r1),
        .r2(r2),
        .r3(r3),
        .r4(r4)
    );

    always #5 clk = ~clk;

    initial begin
        mclk = 0;
        rst  = 1;

        #20 rst = 0;
        #300;

        rst = 1;
        #15 rst = 0;
        #300;

        rst = 1;
        #10 rst = 0;
        #300;

        $finish;
    end

    initial begin
        $monitor("Time=%0t | R1=%b R2=%b R3=%b R4=%b",
                 $time, r1, r2, r3, r4);
    end

endmodule
