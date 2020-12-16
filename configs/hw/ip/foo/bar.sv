module bar;
  string s;
  initial begin
    s = $sformatf("Sub-module bar's type is %0s.", foo_pkg::BAR_TYPE);
    $display("%0s", s);
  end
endmodule
