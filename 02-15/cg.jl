"""
Conjugate Gradient Ax=b
A must be symmetric
https://en.wikipedia.org/wiki/Conjugate_gradient_method
"""
function cg(A,b, x0; tol=1e-6, maxIter=2*length(b)^2, verbose=true)

    # should include check to ensure A is symmetric

    iter = 0
    r = b - A*x0

    if norm(r) <= tol
        return (x0,0)
    end

    p = copy(r)
    x = copy(x0)

    flag = 0
    while flag == 0
        iter += 1

        z = A*p
        α = (r'*r)/( p'*z )
        x += α*p
        r1 = r - α*z

        if verbose
            @printf("iter=%3d, |res|=%.3e\n", iter, norm(r1))
        end

        if norm(r1) <= tol
            return x, iter
        elseif iter >= maxIter
            error("Failed to converge")
        end

        β = (r1'*r1)/(r'*r)
        r = copy(r1)

        p = r + β*p

    end

end