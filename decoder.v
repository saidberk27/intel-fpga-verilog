module decoder_4x16 (
    input wire [3:0] A, 
    output wire [15:0] Y 
);

    wire nA3, nA2, nA1, nA0;


    not (nA3, A[3]);
    not (nA2, A[2]);
    not (nA1, A[1]);
    not (nA0, A[0]);


    and (Y[0],  nA3, nA2, nA1, nA0);
    and (Y[1],  nA3, nA2, nA1, A[0]);
    and (Y[2],  nA3, nA2, A[1], nA0);
    and (Y[3],  nA3, nA2, A[1], A[0]);
    and (Y[4],  nA3, A[2], nA1, nA0);
    and (Y[5],  nA3, A[2], nA1, A[0]);
    and (Y[6],  nA3, A[2], A[1], nA0);
    and (Y[7],  nA3, A[2], A[1], A[0]);
    and (Y[8],  A[3], nA2, nA1, nA0);
    and (Y[9],  A[3], nA2, nA1, A[0]);
    and (Y[10], A[3], nA2, A[1], nA0);
    and (Y[11], A[3], nA2, A[1], A[0]);
    and (Y[12], A[3], A[2], nA1, nA0);
    and (Y[13], A[3], A[2], nA1, A[0]);
    and (Y[14], A[3], A[2], A[1], nA0);
    and (Y[15], A[3], A[2], A[1], A[0]);

endmodule


module bcd_to_7segment (
    input wire [3:0] A, // 4-bit BCD input
    output wire a, b, c, d, e, f, g // 7 segment outputs
);

    wire A3, A2, A1, A0;
    wire a_int, b_int, c_int, d_int, e_int, f_int, g_int;

    assign A3 = A[3];
    assign A2 = A[2];
    assign A1 = A[1];
    assign A0 = A[0];

    // Segment a
    or (a_int, 
        (A3 & ~A2 & A1 & ~A0), 
        (~A3 & ~A2 & ~A1 & A0), 
        (~A3 & A2 & ~A1 & ~A0), 
        (~A3 & A2 & A1 & A0)
    );

    // Segment b
    or (b_int, 
        (A3 & A2 & ~A1 & A0), 
        (~A3 & A2 & A1 & ~A0), 
        (A3 & A2 & A1 & ~A0), 
        (A3 & ~A2 & A1 & A0)
    );

    // Segment c
    or (c_int, 
        (~A3 & ~A2 & A1 & ~A0), 
        (A3 & A2 & A1 & ~A0), 
        (A3 & A2 & ~A1 & ~A0)
    );

    // Segment d
    or (d_int, 
        (~A3 & ~A2 & ~A1 & A0), 
        (~A3 & A2 & ~A1 & ~A0), 
        (~A3 & A2 & A1 & A0), 
        (A3 & ~A2 & A1 & ~A0)
    );

    // Segment e
    or (e_int, 
        (~A3 & ~A2 & ~A1 & A0), 
        (~A3 & ~A2 & A1 & A0), 
        (~A3 & A2 & ~A1 & ~A0)
    );

    // Segment f
    or (f_int, 
        (~A3 & ~A2 & ~A1 & A0), 
        (~A3 & ~A2 & A1 & ~A0), 
        (A3 & ~A2 & A1 & A0), 
        (~A3 & A2 & ~A1 & ~A0)
    );

    // Segment g
    or (g_int, 
        (~A3 & ~A2 & ~A1 & ~A0), 
        (A3 & A2 & A1 & ~A0), 
        (~A3 & A2 & A1 & A0)
    );

    not (a, a_int);
    not (b, b_int);
    not (c, c_int);
    not (d, d_int);
    not (e, e_int);
    not (f, f_int);
    not (g, g_int);

endmodule

module tb_decoder_4x16;
    reg [3:0] A; // 4-bit input
    wire [15:0] Y; // 16-bit output

    decoder_4x16 dut (
        .A(A),
        .Y(Y)
    );

    initial begin

        // A = 0000
        A = 4'b0000;
        #10;

        // A = 0001
        A = 4'b0001;
        #10;

        // A = 0010
        A = 4'b0010;
        #10;

        // A = 0011
        A = 4'b0011;
        #10;

        // A = 0100
        A = 4'b0100;
        #10;

        // A = 0101
        A = 4'b0101;
        #10;

        // A = 0110
        A = 4'b0110;
        #10;

        // A = 0111
        A = 4'b0111;
        #10;

        // A = 1000
        A = 4'b1000;
        #10;

        // A = 1001
        A = 4'b1001;
        #10;

        // A = 1010
        A = 4'b1010;
        #10;

        // A = 1011
        A = 4'b1011;
        #10;

        // A = 1100
        A = 4'b1100;
        #10;


        // A = 1101
        A = 4'b1101;
        #10;


        // A = 1110
        A = 4'b1110;
        #10;


        // A = 1111
        A = 4'b1111;
        #10;

    end
endmodule



module tb_bcd_to_7segment;
    reg [3:0] A;
    wire a, b, c, d, e, f, g; 

    bcd_to_7segment dut (
        .A(A),
        .a(a), .b(b), .c(c), .d(d), .e(e), .f(f), .g(g)
    );

    initial begin
        // A = 0000
        A = 4'b0000;
        #10;
        // A = 0001
        A = 4'b0001;
        #10;
        // A = 0010
        A = 4'b0010;
        #10;
        // A = 0011
        A = 4'b0011;
        #10;
        // A = 0100
        A = 4'b0100;
        #10;
        // A = 0101
        A = 4'b0101;
        #10;
        // A = 0110
        A = 4'b0110;
        #10;
        // A = 0111
        A = 4'b0111;
        #10;
        // A = 1000
        A = 4'b1000;
        #10;
        // A = 1001
        A = 4'b1001;
        #10;
        // A = 1010
        A = 4'b1010;
        #10;
        // A = 1111
        A = 4'b1111;
        #10;

        // A = 1010 (gecersiz BCD)
        A = 4'b1010;
        #10;

        // A = 1111 (gecersiz BCD)
        A = 4'b1111;
        #10;
    end

endmodule

