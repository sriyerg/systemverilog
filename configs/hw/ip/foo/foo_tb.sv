module foo_tb;

  foo u_foo();

  initial begin
    #1;
    if (u_foo.s != "Module foo is standalone.") begin
      $error("Incorrect instantiation of u_foo");
    end else begin
      $display("u_foo is correctly instantiated");
    end

    if (u_foo.u_bar.s != "Sub-module bar's type is IP.") begin
      $error("Incorrect instantiation of u_foo.u_bar");
    end else begin
      $display("u_foo.u_bar is correctly instantiated");
    end
  end

endmodule
