
module Spline

using LinearAlgebra
using Polynomials

function spinterp(t, y)

    n = length(t) - 1
    h = [t[k+1] - t[k] for k in 1:n]

    # Definitions
    Z = zeros(n, n)
    In = I(n)
    E = In[1:n-1, :]
    J = diagm(0 => ones(n), 1 => -ones(n - 1))
    H = diagm(0 => h)

    # Left endpoint:
    AL = [In Z Z Z]
    vL = y[1:n]

    # Right endpoint
    AR = [ In H H^2 H^3 ]
    vR = y[2:n+1]

    # Continuity of the first derivative
    A1 = E * [Z J 2 * H 3 * H^2]
    v1 = zeros(n - 1)

    # Continuity of second derivative
    A2 = E * [Z Z J 3 * H]
    v2 = zeros(n - 1)

    # Not-a-knot condition
    nakL = [zeros(1, 3 * n) [1 -1 zeros(1, n - 2)]]
    nakR = [zeros(1, 3 * n) [zeros(1, n - 2) 1 -1]]

    # Assemble and solve the full system
    A = [AL; AR; A1; A2; nakL; nakR]
    v = [vL; vR; v1; v2; 0; 0]
    z = A \ v

    # unpack the results
    rows = 1:n
    a = z[rows]
    b = z[n.+rows]
    c = z[2*n.+rows]
    d = z[3*n.+rows]
    S = [Polynomial([a[k], b[k], c[k], d[k]]) for k in 1:n]

    return function (x)

        if x < t[1] || x > t[n+1]
            return NaN

        elseif x == t[1]
            return y[1]

        else
            k = findlast(x .> t)
            return S[k](x - t[k])
        end

    end

end


end