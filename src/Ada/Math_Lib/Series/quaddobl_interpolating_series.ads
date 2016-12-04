with Standard_Integer_Numbers;         use Standard_Integer_Numbers;
with QuadDobl_Complex_Numbers;         use QuadDobl_Complex_Numbers;
with Quad_Double_Vectors;
with QuadDobl_Complex_Vectors;
with QuadDobl_Complex_VecVecs;
with QuadDobl_Complex_Matrices;
with QuadDobl_Complex_VecMats;
with QuadDobl_Dense_Vector_Series;
with QuadDobl_Dense_Matrix_Series;

package QuadDobl_Interpolating_Series is

-- DESCRIPTION :
--   Via interpolation at random points we can solve linear systems
--   with matrix series, even if several of the leading coefficients
--   of the matrix coefficients are singular matrices.
--   The calculations happen in quad double precision.

  function Eval ( v : QuadDobl_Dense_Vector_Series.Vector;
                  t : Complex_Number )
                return QuadDobl_Complex_Vectors.Vector;

  -- DESCRIPTION :
  --   Returns the vector obtained by evaluating v at t.

  function Eval ( m : QuadDobl_Dense_Matrix_Series.Matrix;
                  t : Complex_Number )
                return QuadDobl_Complex_Matrices.Matrix;

  -- DESCRIPTION :
  --   Returns the matrix obtained by evaluating m at t.

  function Full_Rank
             ( m : QuadDobl_Dense_Matrix_Series.Matrix;
               d : integer32; verbose : boolean := true ) return boolean;

  -- DESCRIPTION :
  --   Returns true if the matrix series up to degree d <= m.deg
  --   has full rank when evaluated at a random complex value.

  function Full_Rank
             ( m : QuadDobl_Dense_Matrix_Series.Matrix;
               verbose : boolean := true ) return integer32;

  -- DESCRIPTION :
  --   Returns -1 if for all degrees d in 0..m.deg the matrix has no
  --   full rank when evaluated at a random complex value, otherwise
  --   returns the smallest d for which the evaluation of m at a
  --   random complex value yields a full rank matrix.
  --   If the matrix series m does not have full rank, then the solution
  --   of a linear system with m as a coefficient matrix may not work.

  function Sample ( v : QuadDobl_Dense_Vector_Series.Vector;
                    t : QuadDobl_Complex_Vectors.Vector )
                  return QuadDobl_Complex_VecVecs.VecVec;

  -- DESCRIPTION :
  --   Samples the vector series m at the points in t,
  --   returning the evaluated vectors v(t).
  --   The range of the returned result is t'range.

  function Sample ( m : QuadDobl_Dense_Matrix_Series.Matrix;
                    t : QuadDobl_Complex_Vectors.Vector )
                  return QuadDobl_Complex_VecMats.VecMat;

  -- DESCRIPTION :
  --   Samples the matrix series m at the points in t,
  --   returning the evaluated matrices m(t).
  --   The range of the returned result is t'range.

  function Solve_Linear_Systems
             ( m : QuadDobl_Complex_VecMats.VecMat;
               v : QuadDobl_Complex_VecVecs.VecVec )
             return QuadDobl_Complex_VecVecs.VecVec;
            
  -- DESCRIPTION :
  --   Solves the linear systems m(i)*x = v(i) and returns
  --   the solutions x in the vector of vectors on return.

  -- REQUIRED : m'range = v'range and all matrices in m and
  --   vectors in v have the same dimension.

  function Residuals
             ( m : QuadDobl_Complex_VecMats.VecMat;
               v,x : QuadDobl_Complex_VecVecs.VecVec )
             return Quad_Double_Vectors.Vector;

  -- DESCRIPTION :
  --   Returns the vector of residuals for the solutions in x
  --   of the systems defined by the matrices in m and the
  --   right hand side vectors in v.

  function Transpose ( x : QuadDobl_Complex_VecVecs.VecVec )
                     return QuadDobl_Complex_VecVecs.VecVec;

  -- DESCRIPTION :
  --   If the range of x is 0..deg and the range of each x(i)
  --   is 1..dim, then the vector of vectors on return has
  --   the range 1..dim and each vector in the vector of vectors
  --   on return has the range 1..deg+1.

  function Vandermonde_Matrix
             ( t : QuadDobl_Complex_Vectors.Vector )
             return QuadDobl_Complex_Matrices.Matrix;

  -- DESCRIPTION :
  --   Returns the Vandermonde matrix defined by the points in t.
  --   The range of the square matrix on return is 1..dim,
  --   where dim equals the number of points in t.

  function Solve_Interpolation_Systems
             ( v : QuadDobl_Complex_Matrices.Matrix;
               f : QuadDobl_Complex_VecVecs.VecVec )
             return QuadDobl_Complex_VecVecs.VecVec;

  -- DESCRIPTION :
  --   Solves the interpolation linear systems defined by the
  --   Vandermonde matrix in v and the right hand side vectors in f.

  function Construct ( x : QuadDobl_Complex_VecVecs.VecVec )
                     return QuadDobl_Dense_Vector_Series.Vector;

  -- DESCRIPTION :
  --   Takes the solutions of the interpolation systems in x
  --   and constructs the vector series.

  function Interpolate
             ( mat : QuadDobl_Dense_Matrix_Series.Matrix;
               rhs : QuadDobl_Dense_Vector_Series.Vector;
               verbose : boolean := true )
             return QuadDobl_Dense_Vector_Series.Vector;

  -- DESCRIPTION :
  --   Samples the matrix and vector series at random points
  --   and solves the linear systems defined by the evaluated
  --   coefficient matrices and right hand side vectors.
  --   If verbose, then additional results and diagnostics
  --   are written to screen.

  function Diff ( m : QuadDobl_Complex_VecMats.VecMat;
                  t : Complex_Number; pow,ord : integer32 )
                return QuadDobl_Complex_Matrices.Matrix;

  -- DESCRIPTION :
  --   Returns the value of the derivative of the power series 
  --   with coefficients in m, at t, where t is multiplied by t**pow,
  --   and the order of the derivative equals ord. 
  --   For pow = 0 and ord = 0, Diff(m,t,0,0) returns the value
  --   of the series.

  function Hermite_Matrix
             ( m : QuadDobl_Complex_VecMats.VecMat;
               t : Complex_Number )
             return QuadDobl_Complex_Matrices.Matrix;

  -- DESCRIPTION :
  --   Returns the coefficient matrix for the linear system for the
  --   coefficients of the Hermite interpolating polynomial at t.
  --   The order of the interpolation is determined by m'last.
  --   For i in m'range, the solution x(t) to m*x(t) = b will
  --   agree with the i-th derivative at the value for t.

  -- REQUIRED : m'first = 0.

  function Hermite_Vector
             ( v : QuadDobl_Complex_VecVecs.VecVec;
               t : Complex_Number )
             return QuadDobl_Complex_Vectors.Vector;

  -- DESCRIPTION :
  --   Returns the right hand side vector corresponding to the Hermite
  --   coefficient matrix to interpolate at t.

  function Hermite_Interpolate
             ( mat : QuadDobl_Dense_Matrix_Series.Matrix;
               rhs : QuadDobl_Dense_Vector_Series.Vector;
               t : Complex_Number; verbose : boolean := true )
             return QuadDobl_Dense_Vector_Series.Vector;

  -- DESCRIPTION :
  --   Samples the matrix and vector series at t and solves
  --   the linear system defined by the Hermite matrix and vector.
  --   If verbose, then additional results and diagnostics
  --   are written to screen.

  -- REQUIRED : mat.deg = rhs.deg.

end QuadDobl_Interpolating_Series;