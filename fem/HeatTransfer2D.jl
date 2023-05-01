module HeatTransfer2D

using LinearAlgebra

function element_stiffness(xe, ye, N, element_quad_rule, prop_K)
    ned = 1
    nen = length(xe)
    nee = nen * ned
    ke = zeros(nee, nee)

    # integration loop
    for (ξ, w) in element_quad_rule.iterator
        _, Nξ, Nη = N(ξ)

        # Jacobian
        J = [dot(Nξ, xe) dot(Nη, xe);
             dot(Nξ, ye) dot(Nη, ye)]
        detJ = det(J)

        B = J \ [Nξ'; Nη']

        dV = detJ * w

        # integrate ke
        ke += B' * prop_K * B * dV
    end

    return ke
end

end