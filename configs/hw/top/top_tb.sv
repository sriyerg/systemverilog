module top_tb;

  top u_top();

  initial begin
    string mode;
    string exp;

    #1;
    if (!$value$plusargs("mode=%s", mode)) begin
      $fatal("Required plusarg \"mode\" is not specified.");
    end

    if (u_top.u_foo.s != "Module foo is integrated.") begin
      $error("Incorrect instantiation of u_foo");
    end else begin
      $display("u_foo is correctly instantiated");
    end

    if (u_top.u_foo.u_bar.s != "Sub-module bar's type is top-level.") begin
      $error("Incorrect instantiation of u_foo.u_bar");
    end else begin
      $display("u_foo.u_bar is correctly instantiated");
    end

    case (mode)
      "system":   exp = "Generic implementation of baz.";
      "foundry":  exp = "Foundry implementation of baz.";
      default:    $fatal("Plusarg \"mode\" must be one of the following: {system, foundry}.");
    endcase

    if (u_top.u_foo.u_baz.s != exp) begin
      $error("Incorrect instantiation of u_foo.u_bar.u_baz");
    end else begin
      $display("u_foo.u_bar.u_baz is correctly instantiated");
    end
  end

endmodule
