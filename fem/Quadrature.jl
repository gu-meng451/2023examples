module Quadrature

using LinearAlgebra

struct quadrule
    label::String
    n::Int
    dim::Int
    ξ::Array
    w::Array
    iterator::Any
end

function gauss_legendre_1d(n)
    β = @. 0.5 / sqrt(1 - (2 * (1:(n - 1)))^(-2))
    T = diagm(-1 => β, 1 => β)
    λ, V = eigen(T)
    p = sortperm(λ)

    # nodes
    ξ = λ[p]

    # weights
    w = @. 2V[1, p]^2

    return quadrule("1D GL", n, 1, ξ, w,
                    zip(eachrow(ξ), w))
end

function gauss_legendre_2d(n)

    gl = gauss_legendre_1d(n)
    ξ1 = gl.ξ
    w1 = gl.w

    ξ = zeros(n,n)
    η = zeros(n,n)
    w = zeros(n,n)
    for i in eachindex(ξ1)
        for j in eachindex(ξ1)
            ξ[i,j] = ξ1[i]
            η[i,j] = ξ1[j]
            w[i,j] = w1[i]*w1[j]
        end
    end
    # pack the output
    X = hcat( ξ[:], η[:] )
    return quadrule("2D GL on natural square", n^2, 
        2, X, w[:], zip( eachcol(X), w[:] ) )

end


end