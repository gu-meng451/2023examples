module Bar1D

using LinearAlgebra
include("Shapefunctions.jl")
using .Shapefunctions
include("Preprocess.jl")
using .Preprocess

function assemble_stiffness(mesh, properties)
    ned = mesh.ned
    totaldofs = ned * mesh.nnp
    K = zeros(totaldofs, totaldofs)

    ## loop over each element from each part of the mesh
    for (element_type, ien) in mesh.IEN
        nel = size(ien, 1)
        nen = std_element_defs[element_type].nen
        nee = ned * nen
        LM = mesh.LM[element_type]

        for e in 1:nel
            A = ien[e, 1:nen]
            xe = mesh.x[A]

            ke = element_stiffness(xe, properties)

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

function element_stiffness(xe, properties)
    Le = abs(xe[2] - xe[1])
    E = properties.E
    A = properties.A

    ke = E * A / Le * [+1.0 -1.0;
                       -1.0 +1.0]

    return ke
end

function assemble_rhs(mesh, external_forcing, quad_rules)
    ned = mesh.ned
    totaldofs = ned * mesh.nnp
    F = zeros(totaldofs)

    ## loop over each element from each part of the mesh
    for (element_type, ien) in mesh.IEN
        nel = size(ien, 1)
        N = shapefunc(element_type)
        element_quad_rule = quad_rules[element_type]
        nen = std_element_defs[element_type].nen
        nee = ned * nen
        LM = mesh.LM[element_type]

        for e in 1:nel
            A = ien[e, 1:nen]
            xe = mesh.x[A]

            fe = element_forcing(xe, N, element_quad_rule, external_forcing)

            # assemble element stiffness into the Global stiffness Matrix
            for loop1 in 1:nee
                i = LM[loop1, e]
                F[i] += fe[loop1]
            end
        end
    end
    return F
end

function element_forcing(xe, N, element_quad_rule, external_forcing)
    ned = 1
    nen = length(xe)
    nee = ned * nen
    fe = zeros(nee)

    # integration loop
    for (ξ, w) in element_quad_rule.iterator

        # Evaluate the shape function
        Ne, Nξ = N(ξ)

        # evaluate the external loading at x(ξ)
        x = dot(Ne, xe)
        fext = external_forcing(x)

        # build Jacobian
        detJ = dot(Nξ, xe)

        # dV0
        dV0 = detJ * w

        # integrate ke:
        fe += Ne * fext * dV0
    end

    return fe
end

end