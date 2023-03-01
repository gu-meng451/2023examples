module LaBudde

# original Matlab: # code source: https://github.com/SebastianJiroSchlecht/fastCharPoly/
# link to Rehman and Ipsen's paper: https://doi.org/10.48550/arXiv.1104.3769

# function p = fastCharPoly( A )
# Fast algorithm for characteristic polynomial of square matrices.
# Algortihm is described in 
# La Budde's Method For Computing Characteristic Polynomials
# by Rizwana Rehman and Ilse C.F. Ipsen
# 
# Input: square matrix A
# 
# Output: charactersitic polynomial p of A
#
# Author: Sebastian J. Schlecht
# Date: 11.04.2015

#fastCharPoly - Fast algorithm for characteristic polynomial of square matrices.
#Algortihm is described in 
#La Budde's Method For Computing Characteristic Polynomials
#by Rizwana Rehman and Ilse C.F. Ipsen
#
# Syntax:  p = fastCharPoly( A )
#
# Inputs:
#    A - square matrix complex or real
#
# Outputs:
#    p - coefficients of characteristic polynomial
#
# Example: 
#    p = fastCharPoly( randn(4) )
#    p = charpoly(magic(4)) - fastCharPoly(magic(4))
#
# Other m-files required: none
# Subfunctions: none
# MAT-files required: none
#
# Author: Dr.-Ing. Sebastian Jiro Schlecht, 
# International Audio Laboratories, University of Erlangen-Nuremberg
# email address: sebastian.schlecht@audiolabs-erlangen.de
# Website: sebastianjiroschlecht.com
# 10. December 2018; Last revision: 10. December 2018
#
# Translated to Julia by T. Fitzgerald, 18-Feb-2021
# 

using LinearAlgebra
using Base.Cartesian

export fastCharPoly

function fastCharPoly(A)

    N = size(A, 1)
    H = hessenberg(A).H
    beta = diag(H[2:end, 1:end-1])
    alpha = diag(H)

    pH = zeros(N + 1, N + 1)
    pH[0+1, 1] = 1
    pH[1+1, 1:2] = [-alpha[1], 1]

    for it = 2:N
        partB = reverse(cumprod(reverse(beta[1:it-1])))
        partH = H[1:it-1, it]
        partP = pH[1:it-1, :]

        rec = sum(broadcast(*, partB .* partH, partP), dims=1)
        # convp = conv(pH[it-1+1, :], [-alpha[it], 1])
        convp = fastconv(pH[it-1+1, :], [-alpha[it], 1])

        pH[it+1, :] = convp[1:end-1]' .- rec
    end

    # p = reverse(pH[end, :])
    p = pH[end, :]

end

# export convn, fastconv

##############################################
# Generic convn function using direct method for computing convolutions:
# Accelerated Convolutions for Efficient Multi-Scale Time to Contact Computation in Julia
# Alexander Amini, Alan Edelman, Berthold Horn
##############################################

@generated function convn(E::Array{T,N}, k::Array{T,N}) where {T,N}
    quote
        sizeThreshold = 21
        if length(k) <= sizeThreshold || $N > 2
            #println("using direct")
            retsize = [size(E)...] + [size(k)...] .- 1
            retsize = tuple(retsize...)
            ret = zeros(T, retsize)

            convn!(ret, E, k)
            return ret
        elseif $N == 2 #greater than threshold but still compatible with base julia
            #println("using fft2")
            return conv2(E, k)
        else
            #println("using fft1")
            return conv(E, k)
        end
    end
end

# direct version (do not check if threshold is satisfied)
@generated function fastconv(E::Array{T,N}, k::Array{T,N}) where {T,N}
    quote

        retsize = [size(E)...] + [size(k)...] .- 1
        retsize = tuple(retsize...)
        ret = zeros(T, retsize)

        convn!(ret, E, k)
        return ret

    end
end


# in place helper operation to speedup memory allocations
@generated function convn!(out::Array{T}, E::Array{T,N}, k::Array{T,N}) where {T,N}
    quote
        @inbounds begin
            @nloops $N x E begin
                @nloops $N i k begin
                    (@nref $N out d -> (x_d + i_d - 1)) += (@nref $N E x) * (@nref $N k i)
                end
            end
        end
        return out
    end
end


end