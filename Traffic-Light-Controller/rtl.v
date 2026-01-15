module traffic_light_4way #(
    parameter GREEN_TIME  = 5,
    parameter ALL_RED_TIME = 2
)(
    input  wire clk,
    input  wire rst,
    output reg [1:0] r1, r2, r3, r4
);

    localparam RED   = 2'b10;
    localparam GREEN = 2'b01;

    localparam S_R1_GREEN    = 3'd0,
               S_R1_ALL_RED  = 3'd1,
               S_R2_GREEN    = 3'd2,
               S_R2_ALL_RED  = 3'd3,
               S_R3_GREEN    = 3'd4,
               S_R3_ALL_RED  = 3'd5,
               S_R4_GREEN    = 3'd6,
               S_R4_ALL_RED  = 3'd7;

    reg [2:0] state, next_state;
    reg [$clog2(GREEN_TIME+ALL_RED_TIME+1)-1:0] timer;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= S_R1_GREEN;
            timer <= GREEN_TIME - 1;
        end else begin
            if (timer == 0) begin
                state <= next_state;
                if (next_state == S_R1_GREEN || next_state == S_R2_GREEN ||
                    next_state == S_R3_GREEN || next_state == S_R4_GREEN)
                    timer <= GREEN_TIME - 1;
                else
                    timer <= ALL_RED_TIME - 1;
            end else begin
                timer <= timer - 1;
            end
        end
    end

    always @(*) begin
        case (state)
            S_R1_GREEN:    next_state = S_R1_ALL_RED;
            S_R1_ALL_RED:  next_state = S_R2_GREEN;
            S_R2_GREEN:    next_state = S_R2_ALL_RED;
            S_R2_ALL_RED:  next_state = S_R3_GREEN;
            S_R3_GREEN:    next_state = S_R3_ALL_RED;
            S_R3_ALL_RED:  next_state = S_R4_GREEN;
            S_R4_GREEN:    next_state = S_R4_ALL_RED;
            S_R4_ALL_RED:  next_state = S_R1_GREEN;
            default:       next_state = S_R1_GREEN;
        endcase
    end

    always @(*) begin
        {r1,r2,r3,r4} = {RED, RED, RED, RED};
        case (state)
            S_R1_GREEN:    r1 = GREEN;
            S_R2_GREEN:    r2 = GREEN;
            S_R3_GREEN:    r3 = GREEN;
            S_R4_GREEN:    r4 = GREEN;
        endcase
    end

endmodule
