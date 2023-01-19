

program ex1_fortran
  implicit none

  real*8 :: a,b,c
  real*4 :: d

  a = 1/10
  b = 1/10d0
  c = 0.1d0
  d = 1/10.


  write(*,*) 'a = ',a
  write(*,*) 'b = ',b
  write(*,*) 'c = ',c
  write(*,*) 'd = ',d

end program
