

module question_dar(
    input A, B, C, D,
    output OUT
    );
    wire w1, w2, w3, w4, w5, w6;
    
    or gate1(w1, A, B); // A | B

    not gate2(w2, B); // ~B
    
    or gate3(w3, w2, C); // ~B | C
    
    or gate4(w4, w3, D); // ~B | C | D

    not gate5(w5, A); // ~A

    or gate6(w6, w5, D); // ~A | D 
    
    and gate7(OUT, w1, w4, w6);
    
endmodule

module question_genis(
    input A, B, C, D,
    output OUT
    );

    wire w11, w12, w13, w14;

    not gate11(w11, A); // ~A
    or gate12(w12, w11, B); // ~A | B
    or gate13(w13, w12, C); // ~A | B | C
    or gate14(w14, w13, D); // ~A | B | C | D

    wire w21, w22, w23, w24, w25;

    not gate21(w21, A); // ~A
    or gate22(w22, w21, B); // ~A | B
    not gate23(w23, C); // ~C
    or gate24(w24, w22, w23); // ~A | B | ~C
    or gate25(w25, w24, D); // ~A | B | ~C | D

    wire w31, w32, w33, w34;

    not gate31(w31, A); // ~A
    or gate32(w32, w31, ~B); // ~A | ~B
    or gate33(w33, w32, C); // ~A | ~B | C
    or gate34(w34, w33, D); // ~A | ~B | C | D


    wire w41, w42, w43, w44;

    not gate41(w41, A); // ~A
    or gate42(w42, w41, B); // ~A | B
    or gate43(w43, w42, ~C); // ~A | B | ~C
    or gate44(w44, w43, D); // ~A | B | ~C | D

    and gateFinal(OUT, w44, w34, w25, w14);



// (~A | B | C | D) & (~A | B | ~C | D) & (~A | ~B | C | D) & (~A | B | ~C | D)

endmodule


module testbench1;
reg A, B, C, D;
wire OUT;
question_dar dut ( //veya genisletilmemis olacak
 .A(A),
 .B(B),
 .C(C),
 .D(D),
 .OUT(OUT)
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

module testbench2;
reg A, B, C, D;
wire OUT;
question_genis dut2 ( //veya genisletilmemis olacak
 .A(A),
 .B(B),
 .C(C),
 .D(D),
 .OUT(OUT)
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
