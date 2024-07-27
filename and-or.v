//SA?D BERK 21118080070

module and_gate (
    input a,
    input b,
    output reg and_result
);

  always @* begin
    and_result = a & b;
  end

endmodule

module or_gate (
    input a,
    input b,
    output reg or_result
);

  always @* begin
    or_result = a | b;
  end

endmodule


module hafta1();


  reg a_reg = 0; // A
  reg b_reg = 0; // B
  reg c_reg = 0; // C
  reg d_reg = 0; // D

  wire operation1; // A'B
  wire operation2; // BC'
  wire operation3; // AD'
  wire operation4; // BD
  

  wire paranthesis1; // (A'B + BC')
  wire paranthesis2; // (AD' + BD)

  wire final_result; // F

  initial begin
    $display("Said Berk 21118080070");
    $display("a: %b, b: %b, c: %b, d: %b", a_reg, b_reg, c_reg, d_reg);
    #10;

    // AND sonuclari
    $display("Islem1: ", operation1);
    $display("Islem2: ", operation2);
    $display("Islem3: ", operation3);
    $display("Islem4: ", operation4);

    // OR sonuclari
    $display("Parantez 1:", paranthesis1);
    $display("Parantez 2:", paranthesis2);

    $display("Islem Sonucu: ", final_result);
  end


  and_gate and_gate_inst1 (
    .a(~a_reg),
    .b(b_reg),
    .and_result(operation1)
  );

  and_gate and_gate_inst2 (
    .a(b_reg),
    .b(~c_reg),
    .and_result(operation2)
  );

  and_gate and_gate_inst3 (
    .a(a_reg),
    .b(~d_reg),
    .and_result(operation3)
  );

  and_gate and_gate_inst4 (
    .a(b_reg),
    .b(d_reg),
    .and_result(operation4)
  );


  or_gate or_gate_inst1 (
    .a(operation1),
    .b(operation2),
    .or_result(paranthesis1)
  );

  or_gate or_gate_inst2 (
    .a(operation3),
    .b(operation4),
    .or_result(paranthesis2)
  );

  or_gate or_gate_inst3 (
    .a(~paranthesis1),
    .b(paranthesis2),
    .or_result(final_result)
  );


endmodule

