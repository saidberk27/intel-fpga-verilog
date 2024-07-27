module genisletilmemis (
    input A, B, C, D,
    output OUT
);

assign OUT = (A & ~B) | (A & B & C) | (C & ~D);
endmodule

module genisletilmis (
    input A, B, C, D,
    output OUT
);

assign OUT = (~A & ~B & C & ~D) | (~A & B & ~C & ~D) | (~A & B & ~C & D) | (~A & B & C & ~D) | (~A & B & C & D) | (A & ~B & C & ~D) | (A & B & C & ~D) | (A & B & C & D);
endmodule

module testbench;

reg A, B, C, D;
wire OUT;



genisletilmis dut (
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

