with Standard_Natural_Numbers;           use Standard_Natural_Numbers;
with Standard_Integer_Numbers;           use Standard_Integer_Numbers;
with Standard_Integer_Matrices;
with Standard_Integer64_Matrices;
with Standard_Floating_Matrices;
with Standard_Complex_Matrices;

package Standard_Random_Matrices is

-- DESCRIPTION :
--   Offers routines to generate random standard integer, floating and
--   complex matrices.

  function Random_Matrix ( n,m : natural32; low,upp : integer32 )
                         return Standard_Integer_Matrices.Matrix;
  function Random_Matrix ( n,m : natural32; low,upp : integer64 )
                         return Standard_Integer64_Matrices.Matrix;

  -- DESCRIPTION : 
  --   Returns a matrix of range 1..n,1..m with entries between low and upp.

  function Random_Matrix ( n,m : natural32 )
                         return Standard_Floating_Matrices.Matrix;

  -- DESCRIPTION :
  --   Returns a matrix of range 1..n,1..m with random floating numbers.

  function Orthogonalize ( mat : Standard_Floating_Matrices.Matrix )
                         return Standard_Floating_Matrices.Matrix;

  -- DESCRIPTION :
  --   Returns the orthogonal matrix with the same column span as mat.

  function Random_Orthogonal_Matrix
                ( n,m : natural32 ) return Standard_Floating_Matrices.Matrix;

  -- DESCRIPTION :
  --   Returns a matrix of range 1..n,1..m with random floating numbers,
  --   where the columns are orthogonal w.r.t. each other.

  function Random_Matrix ( n,m : natural32 )
                         return Standard_Complex_Matrices.Matrix;

  -- DESCRIPTION :
  --   Returns a matrix of range 1..n,1..m with random complex numbers.

  function Random_Matrix ( low_row,upp_row,low_col,upp_col : integer32 )
                         return Standard_Complex_Matrices.Matrix;

  -- DESCRIPTION :
  --   Returns a random matrix with row range low_row..upp_row,
  --   and column range low_col..upp_col.

  function Orthogonalize ( mat : Standard_Complex_Matrices.Matrix )
                         return Standard_Complex_Matrices.Matrix;

  -- DESCRIPTION :
  --   Returns the orthogonal matrix with the same column span as mat.

  function Random_Orthogonal_Matrix
                ( n,m : natural32 ) return Standard_Complex_Matrices.Matrix;

  -- DESCRIPTION :
  --   Returns a matrix of range 1..n,1..m with random complex numbers,
  --   where the columns are orthogonal w.r.t. each other.

end Standard_Random_Matrices;
