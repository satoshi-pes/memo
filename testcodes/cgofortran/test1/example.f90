!
! examples of fortran called by golang
!

function func1(v_float, v_double) result(i_int) bind(C)
    use iso_c_binding, only: c_float, c_double, c_int
    implicit none

    real(c_float), intent(in) :: v_float
    real(c_double), intent(in) :: v_double
    integer(c_int) :: i_int

    print *, "float : ", v_float
    print *, "double: ", v_double

    ! return value
    i_int = 42
end function func1

subroutine sub1(v_float_in, v_float_inout, v_float_out) bind(C)
    use iso_c_binding, only: c_float
    implicit none

    real(c_float), intent(in):: v_float_in
    real(c_float), intent(inout):: v_float_inout
    real(c_float), intent(out):: v_float_out

    print *, "in, inout, out (before change): ", v_float_in, v_float_inout, v_float_out

    !v_float_in = 42.  !! cannot change 
    v_float_inout = 42.
    v_float_out = 42.
end subroutine sub1
