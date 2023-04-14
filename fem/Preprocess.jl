module Preprocess

using LinearAlgebra

export mesh, std_element_defs, build_mesh

struct mesh
    x::Vector{Float64}
    y::Vector{Float64}
    z::Vector{Float64}
    IEN::Dict
    ID::Matrix{Int}
    LM::Dict
    ned::Int
    neq::Int
    nnp::Int
    ng::Int
    BC_g_list::Any
    BC_fix_list::Any
    free_range::Any
    freefix_range::Any
end

#= Sandard GMSH element types:
% Types = { ...
%     {  2,  1, 'LINES',      'nbLines'},      ... % 1
%     {  3,  2, 'TRIANGLES',  'nbTriangles'},  ...
%     {  4,  2, 'QUADS',      'nbQuads'},      ...
%     {  4,  3, 'TETS',       'nbTets'},       ...
%     {  8,  3, 'HEXAS',      'nbHexas'},      ... %5
%     {  6,  3, 'PRISMS',     'nbPrisms'},     ...
%     {  5,  3, 'PYRAMIDS',   'nbPyramids'},   ...
%     {  3,  1, 'LINES3',     'nbLines3'},     ...
%     {  6,  2, 'TRIANGLES6', 'nbTriangles6'}, ...
%     {  9,  2, 'QUADS9',     'nbQuads9'},     ... % 10
%     { 10,  3, 'TETS10',     'nbTets10'},     ...
%     { 27,  3, 'HEXAS27',    'nbHexas27'},    ...
%     { 18,  3, 'PRISMS18',   'nbPrisms18'},   ...
%     { 14,  3, 'PYRAMIDS14', 'nbPyramids14'}, ...
%     {  1,  0, 'POINTS',     'nbPoints'},     ... % 15
%     {  8,  3, 'QUADS8',     'nbQuads8'},     ...
%     { 20,  3, 'HEXAS20',    'nbHexas20'},    ...
%     { 15,  3, 'PRISMS15',   'nbPrisms15'},   ...
%     { 13,  3, 'PYRAMIDS13', 'nbPyramids13'}, ...
%     };
=#

struct element_def
    name::String
    nen::Int
    internal_dim::Int
    gmsh_number::Int
end

# Build and save the list of the basic GMSH element numbers
const std_element_defs = Dict("line" => element_def("Linear Line", 2, 1, 1),
                              "triangle" => element_def("Linear Triangle", 3, 2, 2),
                              "quad" => element_def("4 node quadrilateral", 4, 2, 3))

function build_ID(nnp, g_list, ned, fix_list)
    neq = 0
    count = 0

    ## compute ng:
    ng = sum(fix_list[:] .> 0)

    ## construct ID
    ID = zeros(Int, ned, nnp)
    totaldof = ned * nnp

    gg = zeros(ng)

    ## loop over all nodes
    if ng > 0
        for A in 1:nnp
            for i in 1:ned
                # find Essential BC
                if fix_list[i, A] == 1
                    ID[i, A] = totaldof - count
                    count += 1
                    gg[count] = g_list[i, A]
                else
                    # list no gg's
                    neq += 1
                    ID[i, A] = neq
                end
            end
        end
    else
        # no constrained coords:
        for A in 1:nnp
            for i in 1:ned
                neq += 1
                ID[i, A] = neq
            end
        end
        gg = []
    end

    free_range = 1:neq
    freefix_range = (neq + 1):(ng + neq)

    ## perform some checks to make sure the BC's are accounted for
    # count_ng = length(gg);
    # if( ng - count_ng ~= 0 )
    #     fprintf(2,'Error: Number of Essential BC counting does not match.\n');
    # end

    return (ID, neq, ng, free_range, freefix_range)
end

function build_LM(ID::Array, IEN::Dict)
    ned = size(ID, 1)

    # LM is a Dict, where each key is the element type of that part of the mesh matching IEN
    LM = Dict()

    for (element_type, ien) in IEN
        nel = size(ien, 1)
        nen = std_element_defs[element_type].nen
        lm = zeros(Int, nen * ned, nel)
        for e in 1:nel
            for a in 1:nen
                for i in 1:ned
                    p = a + nen * (i - 1)
                    lm[p, e] = ID[i, ien[e, a]]
                end
            end
        end
        LM[element_type] = lm
    end

    return LM
end

function build_mesh(x, y, z, IEN, DofPerNode, BC_fix_list, BC_g_list)
    nnp = length(x)

    ID, neq, ng, free_range, freefix_range = build_ID(nnp, BC_g_list, DofPerNode,
                                                      BC_fix_list)
    LM = build_LM(ID, IEN)

    return mesh(x, y, z, IEN, ID, LM, DofPerNode, neq, nnp, ng,
                BC_g_list, BC_fix_list, free_range, freefix_range)
end

end