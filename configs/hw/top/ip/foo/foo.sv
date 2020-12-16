module foo;
  import foo_pkg::*;
  string s;
  initial begin
    s = $sformatf("Module foo is %0s.", foo_pkg::FOO_TYPE);
    $display("%0s", s);
  end
  bar u_bar();
  baz u_baz();
endmodule
