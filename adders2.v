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

module bcd_toplayici(
    input a0, a1, a2, a3,
    input b0, b1, b2, b3,
    input c_in,
    output c_4, s8, s4, s2, s1
);
wire z1, z2, z4, z8, carry_out, a_out1, a_out2;
 

ikili_toplayici dut_it1 (
 .a0(a0), .a1(a1), .a2(a2), .a3(a3),
 .b0(b0), .b1(b1), .b2(b2), .b3(b3),
 .c4(carry_out), .s0(z1), .s1(z2), .s2(z4),
 .s3(z8)
);

and gate1(a_out1, z8, z4);
and gate2(a_out2, z8, z2);
or gate3(c_4, carry_out, a_out1, a_out2);

ikili_toplayici dut_it2 (
 .a0(z1), .a1(z2), .a2(z4), .a3(z8),
 .b0(0), .b1(c_4), .b2(c_4), .b3(0),
 .c4(carry_out), .s0(s1), .s1(s2), .s2(s4),
 .s3(s8)
);

endmodule

module bcd_toplayici_soru_2(
    input a0, a1, a2, a3,
    input b0, b1, b2, b3,
    input c_in,
    output c_4, s8, s4, s2, s1
);
wire z1, z2, z4, z8, carry_out, a_out1, a_out2;
 

ikili_toplayici dut_it1 (
 .a0(a0), .a1(a1), .a2(a2), .a3(a3),
 .b0(b0), .b1(b1), .b2(b2), .b3(b3),
 .c4(carry_out), .s0(z1), .s1(z2), .s2(z4),
 .s3(z8)
);

and gate1(a_out1, z8, z4);
and gate2(a_out2, z8, z2);
or gate3(c_4, carry_out, a_out1, a_out2);

ikili_toplayici dut_it2 (
 .a0(z1), .a1(z2), .a2(z4), .a3(z8),
 .b0(c_4), .b1(0), .b2(c_4), .b3(c_4),
 .c4(carry_out), .s0(s1), .s1(s2), .s2(s4),
 .s3(s8)
);

endmodule

module tb_bcd_toplayici;
reg A0, A1, A2, A3;
reg B0, B1, B2, B3;
reg c_in;
wire s1, s2, s4, s8, c_4;

bcd_toplayici dut4(
.a0(A0), .a1(A1), .a2(A2), .a3(A3),
.b0(B0), .b1(B1), .b2(B2), .b3(B3),
.c_in(c_in),
.c_4(c_4), .s8(s8), .s4(s4), .s2(s2), .s1(s1)
);

initial begin
    // A = 1111, B = 1111
    A0 = 1; A1 = 1; A2 = 1; A3 = 1; B0 = 1; B1 = 1; B2 = 1; B3 = 1; // a = 0; b = 13
    #10;

    // A = 0000, B = 0000
    A0 = 0; A1 = 0; A2 = 0; A3 = 0; B0 = 0; B1 = 0; B2 = 0; B3 = 0; // a = 0; b = 13
    #10;

    // A = 1010, B = 1001
    A0 = 0; A1 = 1; A2 = 0; A3 = 1; B0 = 1; B1 = 0; B2 = 0; B3 = 1; // a = 0; b = 13
    #10;

    // A = 1100, B = 0011
    A0 = 0; A1 = 0; A2 = 1; A3 = 1; B0 = 0; B1 = 0; B2 = 1; B3 = 1; // a = 0; b = 13
    #10;
end
endmodule

module soru_b;
//Ögrenci Numaramin son 2 hanesi = 70
// 0 ve 13 araliginda kodlanmali. a = 0, b = 13
// ikinci 4 bit adder'in ilk toplami 6 degil 13 olmali yani 0110 gondermek yerine 1101 gondermeli
reg A0, A1, A2, A3;
reg B0, B1, B2, B3;
reg c_in;
wire s1, s2, s4, s8, c_4;

bcd_toplayici_soru_2 dut5(
.a0(A0), .a1(A1), .a2(A2), .a3(A3),
.b0(B0), .b1(B1), .b2(B2), .b3(B3),
.c_in(c_in),
.c_4(c_4), .s8(s8), .s4(s4), .s2(s2), .s1(s1)
);

initial begin
    // A = 1111, B = 1111
    A0 = 1; A1 = 1; A2 = 1; A3 = 1; B0 = 1; B1 = 1; B2 = 1; B3 = 1; // a = 0; b = 13
    #10;

    // A = 0000, B = 0000
    A0 = 0; A1 = 0; A2 = 0; A3 = 0; B0 = 0; B1 = 0; B2 = 0; B3 = 0; // a = 0; b = 13
    #10;

    // A = 1010, B = 1001
    A0 = 0; A1 = 1; A2 = 0; A3 = 1; B0 = 1; B1 = 0; B2 = 0; B3 = 1; // a = 0; b = 13
    #10;

    // A = 1100, B = 0011
    A0 = 0; A1 = 0; A2 = 1; A3 = 1; B0 = 0; B1 = 0; B2 = 1; B3 = 1; // a = 0; b = 13
    #10;
end
endmodule