using Printf

"""
 myExp(x; tol, maxIter)

 A series based calculation of exp(x) to an optionally specifiable tolerance.

"""
function  myExp(x; tol=1e-14, maxIter=300, verbose=false)

convergenceFlag = false

# initialize the output variable
y = one(typeof(x))
newterm = one(typeof(x))

iter = 0

while !convergenceFlag
    iter += 1

    newterm *= x/iter
    y += newterm

    rel_error = abs( newterm )
    if verbose
        @printf("iter = %3s, rel error = %.3e\n",iter,rel_error)
    end

    if rel_error <= tol
        convergenceFlag = true
        return y
    elseif iter >= maxIter
        error("Solution failed to converge in $iter steps")
    end

end

end

myExp(1.) - exp(1.)

myExp(-100., verbose=true)

# what happens when x is very large or very small?