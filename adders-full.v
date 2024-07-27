module yarim_toplayici(
    input x, y,
    output s, c
);
wire w1, w2;
and gate1(w1, x, ~y);
and gate2(w2, ~x, y);
and gate3(c, x, y); 

or gate4(s, w1, w2);

endmodule

module tam_toplayici(
    input x, y, z,
    output s, c
);
wire w1, w2, w3, w4;
wire w5, w6, w7;

and gate1(w1, ~x, ~y, z);
and gate2(w2, ~x, y, ~z);
and gate3(w3, x, ~y, ~z);
and gate4(w4, x, y, z);
or(s, w1, w2, w3, w4); // Sum biti hesaplama

and gate5(w5, x, y);
and gate6(w6, x, z);
and gate7(w7, y, z);
or(c, w5, w6, w7); // Carry biti hesaplama

endmodule

module ikili_toplayici(
    input a0, a1, a2, a3,
    input b0, b1, b2, b3,
    output c4, s0, s1, s2, s3
);
    
wire c1, c2, c3;
     
tam_toplayici t10 (
 .x(a0),
 .y(b0),
 .z(0),
 .s(s0),
 .c(c1)
);

tam_toplayici t11 (
 .x(a1),
 .y(b1),
 .z(c1),
 .s(s1),
 .c(c2)
);


tam_toplayici t12 (
 .x(a2),
 .y(b2),
 .z(c2),
 .s(s2),
 .c(c3)
);

tam_toplayici t13 (
 .x(a3),
 .y(b3),
 .z(c3),
 .s(s3),
 .c(c4)
);

endmodule

module tb_yarim_toplayici;
reg A, B;
wire sum, carry;

yarim_toplayici dut ( //veya genisletilmemis olacak
 .x(A),
 .y(B),
 .s(sum),
 .c(carry)
);

initial begin
 A = 0; B = 0; #10; 
 A = 0; B = 1; #10; 
 A = 1; B = 0; #10; 
 A = 1; B = 1; #10; 

end
endmodule

module tb_tam_toplayici;
reg A, B, C;
wire sum, carry;

tam_toplayici dut2 (
 .x(A),
 .y(B),
 .z(C),
 .s(sum),
 .c(carry)
);

initial begin
 A = 0; B = 0; C = 0; #10;
 A = 0; B = 0; C = 1; #10;
 A = 0; B = 1; C = 0; #10;
 A = 0; B = 1; C = 1; #10;
 A = 1; B = 0; C = 0; #10;
 A = 1; B = 0; C = 1; #10;
 A = 1; B = 1; C = 0; #10;
 A = 1; B = 1; C = 1; #10;
end
endmodule


module tb_ikili_toplayici;
reg A0, A1, A2, A3;
reg B0, B1, B2, B3;
wire s0, s1, s2, s3, carry;

ikili_toplayici dut3 (
 .a0(A0), .a1(A1), .a2(A2), .a3(A3),
 .b0(B0), .b1(B1), .b2(B2), .b3(B3),
 .c4(carry), .s0(s0), .s1(s1), .s2(s2),
 .s3(s3)
);

initial begin
    // A = 0000, B = 0000
    A0 = 0; A1 = 0; A2 = 0; A3 = 0; B0 = 0; B1 = 0; B2 = 0; B3 = 0;
    #10;

    // A = 0000, B = 0001
    A0 = 0; A1 = 0; A2 = 0; A3 = 0; B0 = 0; B1 = 0; B2 = 0; B3 = 1;
    #10;

    // A = 0000, B = 0010
    A0 = 0; A1 = 0; A2 = 0; A3 = 0; B0 = 0; B1 = 0; B2 = 1; B3 = 0;
    #10;

    // A = 0000, B = 0011
    A0 = 0; A1 = 0; A2 = 0; A3 = 0; B0 = 0; B1 = 0; B2 = 1; B3 = 1;
    #10;

    // A = 0000, B = 0100
    A0 = 0; A1 = 0; A2 = 0; A3 = 0; B0 = 0; B1 = 1; B2 = 0; B3 = 0;
    #10;

    // A = 0000, B = 0101
    A0 = 0; A1 = 0; A2 = 0; A3 = 0; B0 = 0; B1 = 1; B2 = 0; B3 = 1;
    #10;

    // A = 0000, B = 0110
    A0 = 0; A1 = 0; A2 = 0; A3 = 0; B0 = 0; B1 = 1; B2 = 1; B3 = 0;
    #10;

    // A = 0000, B = 0111
    A0 = 0; A1 = 0; A2 = 0; A3 = 0; B0 = 0; B1 = 1; B2 = 1; B3 = 1;
    #10;

    // A = 0000, B = 1000
    A0 = 0; A1 = 0; A2 = 0; A3 = 0; B0 = 1; B1 = 0; B2 = 0; B3 = 0;
    #10;

    // A = 0000, B = 1001
    A0 = 0; A1 = 0; A2 = 0; A3 = 0; B0 = 1; B1 = 0; B2 = 0; B3 = 1;
    #10;

    // A = 0000, B = 1010
    A0 = 0; A1 = 0; A2 = 0; A3 = 0; B0 = 1; B1 = 0; B2 = 1; B3 = 0;
    #10;

    // A = 1111, B = 1111
    A0 = 1; A1 = 1; A2 = 1; A3 = 1; B0 = 1; B1 = 1; B2 = 1; B3 = 1;
    #10;	
end

endmodule