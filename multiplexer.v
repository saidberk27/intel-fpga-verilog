module ikili_mux(
	input I0, I1, S,
	output OUT
);
wire w0, w1, w2;

not gate0(w0, S);
and gate1(w1, I1, S);
and gate2(w2, I0, w0);
or gate3(OUT, w1, w2);
 
endmodule

module dortlu_mux(
	input I0, I1, I2, I3, S0, S1,
	output OUT
);
wire w0, w1, w2, w3, w4, w5;

not gate0(w0, S0);
not gate1(w1, S1);
and gate2(w2, I3, S1, S0);
and gate3(w3, I2, S1, w0);// w0 = ~S0
and gate4(w4, I1, w1, S0);// w1 = ~S1
and gate5(w5, I0, w0, w1);
or gate6(OUT, w2, w3, w4, w5);

endmodule

module kaydirici_devre(
	input A0, A1, A2, A3,
	input B0, B1, B2, B3,
	input S, E,
	output Y0, Y1, Y2, Y3
);
wire ng0, ng1, ng2;
wire ag0, ag1, ag2, ag3, ag4, ag5, ag6, ag7;

not gate0(ng0, E);//~E
not gate1(ng1, S);//~S
not gate2(ng2, ng1);// S

and gateB3(ag7, B3, ng2, ng0);
and gateB2(ag6, B2, ng2, ng0);
and gateB1(ag5, B1, ng2, ng0);
and gateB0(ag4, B0, ng2, ng0);

and gateA3(ag3, A3, ng1, ng0);
and gateA2(ag2, A2, ng1, ng0);
and gateA1(ag1, A1, ng1, ng0);
and gateA0(ag0, A0, ng1, ng0);

or gateY3(Y3, ag3, ag7);
or gateY2(Y2, ag2, ag6);
or gateY1(Y1, ag1, ag5);
or gateY0(Y0, ag0, ag4);
endmodule

module tb_ikili_mux;
reg i0, i1, s;
wire Y;

ikili_mux dut (
 .I0(i0), .I1(i1), .S(s), .OUT(Y)
);

initial begin
   
    i0 = 0; i1 = 1; s = 0;
    #10;
    i0 = 0; i1 = 1; s = 1;
    #10;
    i0 = 1; i1 = 0; s = 0;
    #10;
    i0 = 1; i1 = 0; s = 1;
    #10;
end

endmodule

module tb_dortlu_mux;
reg i0, i1, i2, i3, s0, s1;
wire Y;

dortlu_mux dut2 (
 .I0(i0), .I1(i1), .I2(i2), .I3(i3), .S0(s0), .S1(s1), .OUT(Y)
);

initial begin
   
    i0 = 1; i1 = 0; i2 = 0; i3 = 0; s0 = 0; s1 = 1;
    #10;

    i0 = 0; i1 = 1; i2 = 0; i3 = 0; s0 = 1; s1 = 0;
    #10;

    i0 = 0; i1 = 0; i2 = 1; i3 = 0; s0 = 0; s1 = 1;
    #10;

    i0 = 0; i1 = 0; i2 = 0; i3 = 1; s0 = 1; s1 = 1;
    #10;

end

endmodule

module tb_kaydirici_devre;
reg a0, a1, a2, a3, b0, b1, b2, b3, s, e;
wire y0, y1, y2, y3;

kaydirici_devre dut3 (
 .A0(a0), .A1(a1), .A2(a2), .A3(a3),
 .B0(b0), .B1(b1), .B2(b2), .B3(b3),
 .S(s), .E(e),
 .Y0(y0), .Y1(y1), .Y2(y2), .Y3(y3)
);

initial begin
   
    a0 = 0; a1 = 0; a2 = 0; a3 = 0;
    b0 = 0; b1 = 0; b2 = 0; b3 = 0;
    s = 0; e = 0;
    #10;

    a0 = 1; a1 = 1; a2 = 1; a3 = 1;
    b0 = 0; b1 = 0; b2 = 0; b3 = 0;
    s = 0; e = 0;
    #10;

    a0 = 1; a1 = 1; a2 = 1; a3 = 1;
    b0 = 0; b1 = 0; b2 = 0; b3 = 0;
    s = 1; e = 0;
    #10;

    a0 = 0; a1 = 0; a2 = 0; a3 = 0;
    b0 = 1; b1 = 1; b2 = 1; b3 = 1;
    s = 0; e = 0;
    #10;

    a0 = 0; a1 = 0; a2 = 0; a3 = 0;
    b0 = 1; b1 = 1; b2 = 1; b3 = 1;
    s = 1; e = 0;
    #10;
end

endmodule


