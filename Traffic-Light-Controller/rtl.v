module traffic_light_4way #(
    parameter GREEN_TIME = 5
)(
    input  wire        clk,
    input  wire        rst,
    output reg  [1:0]  r1,
    output reg  [1:0]  r2,
    output reg  [1:0]  r3,
    output reg  [1:0]  r4
);

    localparam RED   = 2'b10;
    localparam GREEN = 2'b01;

    localparam S_R1 = 2'd0,
               S_R2 = 2'd1,
               S_R3 = 2'd2,
               S_R4 = 2'd3;

    reg [1:0] state, next_state;
    reg [$clog2(GREEN_TIME+1)-1:0] timer;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= S_R1;
            timer <= GREEN_TIME;
        end
        else if (timer == 0) begin
            state <= next_state;
            timer <= GREEN_TIME;
        end
        else begin
            timer <= timer - 1;
        end
    end

    always @(*) begin
        case (state)
            S_R1: next_state = S_R2;
            S_R2: next_state = S_R3;
            S_R3: next_state = S_R4;
            S_R4: next_state = S_R1;
            default: next_state = S_R1;
        endcase
    end

    always @(*) begin
        r1 = RED; r2 = RED; r3 = RED; r4 = RED;
        case (state)
            S_R1: r1 = GREEN;
            S_R2: r2 = GREEN;
            S_R3: r3 = GREEN;
            S_R4: r4 = GREEN;
        endcase
    end

endmodule
