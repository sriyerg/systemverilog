module baz;
  string s;
  initial begin
    s = "Generic implementation of baz.";
    $display("%0s", s);
  end
endmodule
