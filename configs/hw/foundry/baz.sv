module baz;
  string s;
  initial begin
    s = "Foundry implementation of baz.";
    $display("%0s", s);
  end
endmodule
