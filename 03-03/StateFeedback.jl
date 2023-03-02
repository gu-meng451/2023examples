
module StateFeedback

using LinearAlgebra
using Polynomials: fromroots, coeffs
include("../03-01/LaBudde.jl")


function build_ContMatrix(A,B)

    n = length(B)

    CM = zeros(n,n)

    CM[:,1] = B

    for i = 2:n
        CM[:,i] = A*CM[:,i-1]
    end

    return CM

end

build_ObsMatrix(A,C) = build_ContMatrix(A',C')'

function build_ControllerCanonicalTransform(A,B)

    n = length(B)

    CM_x = build_ContMatrix(A,B)

    a = LaBudde.fastCharPoly(A)
    Ā = diagm(1=>ones(n-1))
    Ā[end,:] = -a[1:end-1]
    B̄ = zeros(n)
    B̄[n] = 1.
    CM_z = build_ContMatrix(Ā,B̄)

    P = CM_x/CM_z

    return (P, a)

end

function build_desiredPoly(sx)
    
    q = fromroots(sx)
    return coeffs(q)

end

function buildK(A,B,sx)

    P,a = build_ControllerCanonicalTransform(A,B)
    d   = build_desiredPoly(sx)
    Kz  = (d-a)[1:end-1]'
    K   = Kz/P
    return K
end



end