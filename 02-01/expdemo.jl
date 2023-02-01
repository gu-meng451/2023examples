using Pkg
Pkg.activate(".")
using Printf

"""
 myExp(x; tol, maxIter)

 A series based calculation of exp(x) to an optionally specifiable tolerance.

"""
function myExp(n::Int)
    e = 2.71828182845904523536028747135266249775724709369995

    y = 1.0

    for i in 1:n
        y *= e
    end

    return y

end

function myExp(X; tol=1e-14, maxIter=300, verbose=false)

    convergenceFlag = false

    # initialize the output variable
    y = one(typeof(X))
    newterm = one(typeof(X))

    ## if x < 0 flip it
    x = X
    if X < 0
        x = -X
    end

    ## break problem into part
    w = floor(Int, x)
    z = x - w

    expW = myExp(w)

    iter = 0

    while !convergenceFlag
        iter += 1

        newterm *= z / iter
        y += newterm

        rel_error = abs(newterm)
        if verbose
            @printf("iter = %3s, rel error = %.3e\n", iter, rel_error)
        end

        if rel_error <= tol
            convergenceFlag = true

            if X < 0
                return 1 / (y * expW)
            else
                return y * expW
            end

        elseif iter >= maxIter
            error("Solution failed to converge in $iter steps")
        end

    end

end

## Simple tests
myExp(1.0) - exp(1.0)

myExp(-100.5, verbose=true)

## Better tests
using BenchmarkTools

@benchmark myExp(x) setup = (x = 100 * (2 * rand() - 1))

@benchmark exp(x) setup = (x = 100 * (2 * rand() - 1))
