module jk_flip_flop (
    input wire J,
    input wire K,
    input wire clk,
    input wire reset,
    output reg Q,
    output wire Qnot
);

    assign Qnot = ~Q;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            Q <= 1'b0;
        end else begin
            case ({J, K})
                2'b00: Q <= Q;      // Degisim Yok
                2'b01: Q <= 1'b0;   // Reset
                2'b10: Q <= 1'b1;   // Set
                2'b11: Q <= ~Q;     // Degistir
                default: Q <= Q;    // Degisim Yok
            endcase
        end
    end

endmodule


module sync_counter_4bit (
    input wire clk,
    input wire reset,
    output wire [3:0] count
);

    wire [3:0] Q;
    wire [3:0] Qnot;
    wire reset_internal;

    // JK Flip Floplar instantiate ediliyor.
    jk_flip_flop jk_ff0 (
        .J(1'b1), 
        .K(1'b1), 
        .clk(clk), 
        .reset(reset_internal), 
        .Q(Q[0]), 
        .Qnot(Qnot[0])
    );

    jk_flip_flop jk_ff1 (
        .J(Q[0]), 
        .K(Q[0]), 
        .clk(clk), 
        .reset(reset_internal), 
        .Q(Q[1]), 
        .Qnot(Qnot[1])
    );

    jk_flip_flop jk_ff2 (
        .J(Q[0] & Q[1]), 
        .K(Q[0] & Q[1]), 
        .clk(clk), 
        .reset(reset_internal), 
        .Q(Q[2]), 
        .Qnot(Qnot[2])
    );

    jk_flip_flop jk_ff3 (
        .J(Q[0] & Q[1] & Q[2]), 
        .K(Q[0] & Q[1] & Q[2]), 
        .clk(clk), 
        .reset(reset_internal), 
        .Q(Q[3]), 
        .Qnot(Qnot[3])
    );

    assign count = Q;
    assign reset_internal = reset | (count == 4'd14);

endmodule



module tb_jk_flip_flop;

    reg J;
    reg K;
    reg clk;
    reg reset;
    wire Q;
    wire Qnot;

    jk_flip_flop uut (
        .J(J),
        .K(K),
        .clk(clk),
        .reset(reset),
        .Q(Q),
        .Qnot(Qnot)
    );

    initial begin
        // Initialize inputs
        J = 0;
        K = 0;
        clk = 0;
        reset = 0;

        // Apply reset
        #10 reset = 1;
        #10 reset = 0;

        // Test all cases
        // Case 00: No change
        #20 J = 0; K = 0;

        // Case 01: Reset
        #20 J = 0; K = 1;

        // Case 10: Set
        #20 J = 1; K = 0;

        // Case 11: Toggle
        #20 J = 1; K = 1;

        // Case 11: Toggle again
        #20 J = 1; K = 1;

        // Case 00: No change
        #20 J = 0; K = 0;

        // Finish the simulation
    
    end

    // Clock generation
    always #5 clk = ~clk;

    // Monitor changes
    initial begin
        $monitor("At time %t, J = %b, K = %b, reset = %b, Q = %b, Qnot = %b", 
                  $time, J, K, reset, Q, Qnot);
    end

endmodule

module tb_sync_counter_4bit;

    reg clk;
    reg reset;
    wire [3:0] count;

    sync_counter_4bit uut (
        .clk(clk),
        .reset(reset),
        .count(count)
    );

    initial begin
        // Initialize inputs
        clk = 0;
        reset = 1;

        // Remove reset after a while
        #15 reset = 0;

        // Run simulation for enough time to observe multiple cycles
      
    end

    // Clock generation
    always #5 clk = ~clk;

    // Monitor changes
    initial begin
        $monitor("At time %t, count = %b", $time, count);
    end

endmodule

