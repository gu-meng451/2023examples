module HeatTransfer2D

using LinearAlgebra
include("Shapefunctions.jl")
using .Shapefunctions

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

function assemble_stiffness(mesh, prop_K, quad_rules)
    ned = mesh.ned
    totaldofs = ned * mesh.nnp
    K = zeros(totaldofs, totaldofs)

    ## loop over each element from each part of the mesh
    for (element_type, ien) in mesh.IEN
        nel = size(ien, 1)
        nen = std_element_defs[element_type].nen
        nee = ned * nen
        LM = mesh.LM[element_type]
        N = shapefunc(element_type)
        element_quad_rule = quad_rules[element_type]

        for e in 1:nel
            A = ien[e, 1:nen]
            xe = mesh.x[A]
            ye = mesh.y[A]

            ke = element_stiffness(xe, ye, N, element_quad_rule, prop_K)

            # assemble element stiffness into the Global stiffness Matrix
            for loop1 in 1:nee
                i = LM[loop1, e]
                for loop2 in 1:nee
                    j = LM[loop2, e]
                    K[i, j] += ke[loop1, loop2]
                end
            end
        end
    end
    return K
end

end