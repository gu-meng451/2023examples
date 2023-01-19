using Printf

a = 1 ÷ 10 # Integer division
b = 1 / 10 # promotion to doubles
c = 0.1 # a Float64

@printf("a = %.16f, type(a) = %s\n", a, typeof(a))
@printf("b = %.16f, type(b) = %s\n", b, typeof(b))
@printf("c = %.16f, type(c) = %s\n", c, typeof(c))
