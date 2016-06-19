with Symbol_Table;
with Standard_Complex_Polynomials;
with Standard_Complex_Polynomials_io;
with Standard_Complex_Poly_Systems;
with Standard_Complex_Poly_Systems_io;
with Series_and_Polynomials;                use Series_and_Polynomials;

package body Series_and_Polynomials_io is

  procedure get ( s : out Series ) is
  begin
    get(standard_input,s);
  end get;

  procedure get ( file : in file_type; s : out Series ) is

    p : Standard_Complex_Polynomials.Poly;

  begin
    if Symbol_Table.Empty
     then Symbol_Table.Init(1);
    end if;
    Standard_Complex_Polynomials_io.get(p);
    s := Polynomial_to_Series(p);
    Standard_Complex_Polynomials.Clear(p);
  end get;

  procedure put ( s : in Series ) is
  begin
    put(standard_output,s);
  end put;

  procedure put ( file : in file_type; s : in Series ) is

    p : Standard_Complex_Polynomials.Poly := Series_to_Polynomial(s);

  begin
    Standard_Complex_Polynomials_io.put(file,p);
    Standard_Complex_Polynomials.Clear(p);
  end put;

  procedure get ( p : out Standard_Series_Polynomials.Poly;
                  idx : in integer32 := 0; verbose : in boolean := false ) is
  begin
    get(standard_input,p,idx,verbose);
  end get;

  procedure get ( file : in file_type;
                  p : out Standard_Series_Polynomials.Poly;
                  idx : in integer32 := 0; verbose : in boolean := false ) is

    q : Standard_Complex_Polynomials.Poly;

  begin
    Standard_Complex_Polynomials_io.get(file,q);
    p := Polynomial_to_Series_Polynomial(q,idx,verbose);
    Standard_Complex_Polynomials.Clear(q);
  end get;

  procedure put ( p : in Standard_Series_Polynomials.Poly;
                  idx : in integer32 := 0; verbose : in boolean := false ) is
  begin
    put(standard_output,p,idx,verbose);
  end put;

  procedure put ( file : in file_type;
                  p : in Standard_Series_Polynomials.Poly;
                  idx : in integer32 := 0; verbose : in boolean := false ) is

    q : Standard_Complex_Polynomials.Poly
      := Series_Polynomial_to_Polynomial(p,idx,verbose);

  begin
    Standard_Complex_Polynomials_io.put(file,q);
    Standard_Complex_Polynomials.Clear(q);
  end put;

  procedure get ( ls : out Standard_Series_Poly_Systems.Link_to_Poly_Sys;
                  idx : in integer32 := 0; verbose : in boolean := false ) is

    lp : Standard_Complex_Poly_Systems.Link_to_Poly_Sys;

  begin
    Standard_Complex_Poly_Systems_io.get(lp);
    declare
      s : constant Standard_Series_Poly_Systems.Poly_Sys(lp'range)
        := Series_and_Polynomials.System_to_Series_System(lp.all,idx,verbose);
    begin
      ls := new Standard_Series_Poly_Systems.Poly_Sys'(s);
    end;
  end get;

  procedure put ( s : in Standard_Series_Poly_Systems.Poly_Sys;
                  idx : in integer32 := 0; verbose : in boolean := false ) is
  begin
    put(standard_output,s,idx,verbose);
  end put;

  procedure put ( file : in file_type;
                  s : in Standard_Series_Poly_Systems.Poly_Sys;
                  idx : in integer32 := 0; verbose : in boolean := false ) is

    p : Standard_Complex_Poly_Systems.Poly_Sys(s'range)
      := Series_and_Polynomials.Series_System_to_System(s,idx,verbose);

  begin
    Standard_Complex_Poly_Systems_io.put(file,p);
    Standard_Complex_Poly_Systems.Clear(p);
  end put;

end Series_and_Polynomials_io;
