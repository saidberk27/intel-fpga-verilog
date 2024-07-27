module canonic_form(
    input A, B, C, D,
    output OUT
    );
    wire w1, w2, w3, w4;
    
    and gate1(w1, ~C, ~D); // C'D'
    and gate2(w2, ~A, B, D); // A'BD
    and gate3(w3, ~B, ~D); //B'D
    and gate4(w4, A, ~D); // AD'
    or gate5(OUT, w1, w2, w3, w4); //C'D' + A'BD + B'D + AD'
    
endmodule

module POS_form(
    input A, B, C, D,
    output OUT
);
    wire w1, w2, w3, w4, w5, w6, w7;
    or gate1(w1, A, B, C, ~D); // (A + B + C + D')
    or gate2(w2, A, B, ~C, ~D); // (A + B + C' + D')
    or gate3(w3, A, ~B, ~C, D); // (A + B' + C' + D)
    or gate4(w4, ~A, B, C, ~D);// (A' + B + C + D')
    or gate5(w5, ~A, B, ~C, ~D);// (A' + B + C' +D')
    or gate6(w6, ~A, ~B, C, ~D);// (A' + B' + C + D')
    or gate7(w7, ~A, ~B, ~C, D);// (A' + B' + C' + D)
    and gate8(OUT, w1, w2, w3, w4, w5, w6, w7);// POS FORM
endmodule

module SOP_form(
    input A, B, C, D,
    output OUT
);
    wire w1, w2, w3, w4, w5, w6, w7, w8, w9;
    and gate1(w1, ~A, ~B, ~C, ~D); // (A'B'C'D')
    and gate2(w2, ~A, ~B, C, ~D); // (A'B'CD')
    and gate3(w3, ~A, B, ~C, ~D); // (A'BC'D')
    and gate4(w4, ~A, B, ~C, D);// (A'BC'D)
    and gate5(w5, ~A, B, C, D);// (A'BCD)
    and gate6(w6, A, ~B, ~C, ~D);// (AB'C'D')
    and gate7(w7, A, ~B, C, ~D);// (AB'CD')
    and gate8(w8, A, B, ~C, ~D);// (ABC'D')
    and gate9(w9, A, B, C, ~D);// (ABCD')
    or gate10(OUT, w1, w2, w3, w4, w5, w6, w7, w8, w9);// POS FORM
endmodule

module testbench_hafta7;
reg A, B, C, D;
wire OUT1, OUT2, OUT3;
canonic_form dut ( //veya genisletilmemis olacak
 .A(A),
 .B(B),
 .C(C),
 .D(D),
 .OUT(OUT1)
);

POS_form dut2 ( //veya genisletilmemis olacak
 .A(A),
 .B(B),
 .C(C),
 .D(D),
 .OUT(OUT2)
);

SOP_form dut3 ( //veya genisletilmemis olacak
 .A(A),
 .B(B),
 .C(C),
 .D(D),
 .OUT(OUT3)
);

initial begin
 A = 0; B = 0; C = 0; D = 0; #10; 
 A = 0; B = 0; C = 0; D = 1; #10; 
 A = 0; B = 0; C = 1; D = 0; #10; 
 A = 0; B = 0; C = 1; D = 1; #10; 
 A = 0; B = 1; C = 0; D = 0; #10; 
 A = 0; B = 1; C = 0; D = 1; #10; 
 A = 0; B = 1; C = 1; D = 0; #10; 
 A = 0; B = 1; C = 1; D = 1; #10; 
 A = 1; B = 0; C = 0; D = 0; #10; 
 A = 1; B = 0; C = 0; D = 1; #10; 
 A = 1; B = 0; C = 1; D = 0; #10; 
 A = 1; B = 0; C = 1; D = 1; #10; 
 A = 1; B = 1; C = 0; D = 0; #10; 
 A = 1; B = 1; C = 0; D = 1; #10; 
 A = 1; B = 1; C = 1; D = 0; #10; 
 A = 1; B = 1; C = 1; D = 1; #10; 
end
endmodule

