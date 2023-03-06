module LagrangeInterp

using LinearAlgebra

function lag(x,j,X)
    n = length(X)

    l = 1.0

    for m = 1:n
        if m != j
            l *= ( x - X[m])/( X[j] - X[m] )
        end
    end
    return l

end

function interp(X,Y)

    n = length(X)
    @assert n == length(Y)

    return function (x)

        return sum( lag(x, j, X)*Y[j] for j in 1:n  )

    end
end

end