`timescale 1ns/1ps
module tb_traffic_light_4way;

    reg clk = 0;
    reg rst = 1;
    wire [1:0] r1, r2, r3, r4;

    traffic_light_4way #(
        .GREEN_TIME(5),
        .ALL_RED_TIME(2)
    ) dut (
        .clk(clk),
        .rst(rst),
        .r1(r1),
        .r2(r2),
        .r3(r3),
        .r4(r4)
    );

    always #5 clk = ~clk;

    initial begin
        #20 rst = 0;
        #800;
        $display("\nSimulation finished");
        $finish;
    end

    initial begin
        $monitor("T=%4t | state=%0d | timer=%2d | R1=%b R2=%b R3=%b R4=%b",
                 $time, dut.state, dut.timer, r1, r2, r3, r4);
    end

endmodule
