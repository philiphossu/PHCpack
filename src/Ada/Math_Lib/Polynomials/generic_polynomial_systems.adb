with unchecked_deallocation;

package body Generic_Polynomial_Systems is 

-- COPYING :

  procedure Copy ( p : in Poly_Sys; q : in out Poly_Sys ) is
  begin
    for i in p'range loop
      Copy(p(i),q(i));
    end loop;
  end Copy;

-- SELECTORS :

  function Variables_in_Support
             ( p : Poly_Sys ) return Standard_Natural_Vectors.Vector is

    nvr : constant integer32 := integer32(Number_of_Unknowns(p(p'first)));
    res : Standard_Natural_Vectors.Vector(1..nvr) := (1..nvr => 0);
    wrk : Standard_Natural_Vectors.Vector(1..nvr);
    cnt : integer32 := 0;

  begin
    for i in p'range loop
      wrk := Variables_in_Support(p(i));
      for k in wrk'range loop
        if wrk(k) = 1 and res(k) = 0
         then res(k) := 1; cnt := cnt + 1;
        end if;
      end loop;
      exit when (cnt >= nvr);
    end loop;
    return res;
  end Variables_in_Support;

  function Size_of_Support ( p : Poly_Sys ) return natural32 is

    res : natural32;
    vsp : constant Standard_Natural_Vectors.Vector := Variables_in_Support(p);

  begin
    res := Standard_Natural_Vectors.Sum(vsp);
    return res;
  end Size_of_Support;

-- ARITHMETIC OPERATIONS :

  function "+" ( p,q : Poly_Sys ) return Poly_Sys is

    res : Poly_Sys(p'range);

  begin
    for i in p'range loop
      res(i) := p(i)+q(i);
    end loop;
    return res;
  end "+";

  function "-" ( p,q : Poly_Sys ) return Poly_Sys is

    res : Poly_Sys(p'range);

  begin
    for i in p'range loop
      res(i) := p(i)-q(i);
    end loop;
    return res;
  end "-";

  function "-" ( p : Poly_Sys ) return Poly_Sys is

    res : Poly_Sys(p'range);

  begin
    for i in p'range loop
      res(i) := -p(i);
    end loop;
    return res;
  end "-";

  function "*" ( a : number; p : Poly_Sys ) return Poly_Sys is

    res : Poly_Sys(p'range);

  begin
    for k in p'range loop
      res(k) := a*p(k);
    end loop;
    return res;
  end "*";

  function "*" ( p : Poly_Sys; a : number ) return Poly_Sys is
  begin
    return a*p;
  end "*";

  procedure Add ( p : in out Poly_Sys; q : in Poly_Sys ) is
  begin
    for i in p'range loop
      Add(p(i),q(i));
    end loop;
  end Add;

  procedure Sub ( p : in out Poly_Sys; q : in Poly_Sys ) is
  begin
    for i in p'range loop
      Sub(p(i),q(i));
    end loop;
  end Sub;

  procedure Min ( p : in out Poly_Sys ) is
  begin
    for i in p'range loop
      Min(p(i));
    end loop;
  end Min;

  procedure Mul ( p : in out Poly_Sys; a : in number ) is
  begin
    for k in p'range loop
      Mul(p(k),a);
    end loop;
  end Mul;

  function Diff ( p : Poly_Sys; i : integer32 ) return Poly_Sys is

    res : Poly_Sys(p'range);

  begin
    for j in p'range loop
      res(j) := Diff(p(j),i);
    end loop;
    return res;
  end Diff;

  procedure Diff ( p : in out Poly_Sys; i : in integer32 ) is
  begin
    for j in p'range loop
      Diff(p(j),i);
    end loop;
  end Diff;

-- DESTRUCTORS :

  procedure Clear ( p : in out Poly_Sys ) is
  begin
    for i in p'range loop
      Clear(p(i));
    end loop;
  end Clear;

  procedure free is new unchecked_deallocation(Poly_Sys,Link_to_Poly_Sys);

  procedure Clear ( p : in out Link_to_Poly_Sys ) is
  begin
    if p /= null
     then Clear(p.all);
          free(p);
    end if;
  end Clear;

  procedure Shallow_Clear ( p : in out Link_to_Poly_Sys ) is
  begin
    free(p);
  end Shallow_Clear;

end Generic_Polynomial_Systems;
