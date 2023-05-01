module Shapefunctions

export shapefunc

"""
    lines(r)

Shape functions for a 2 node line
`` r \\in [-1,1] ``
"""
function line(r::AbstractFloat)
    NN = [(1 - r) / 2, (1 + r) / 2]
    Nr = [-1 / 2, 1 / 2]
    return NN, Nr
end
line(r) = line(r[1])

"""
    triangles(r,s)

Shape functions for a 3 node triangle
`` r \\in [-1,1] ``, `` s \\in [-1,1] ``, `` r + s \\leq 0 ``
"""
function triangle(r, s)
    NN = [(1 / 2) * ((-1) * r + (-1) * s), (1 / 2) * (1 + r), (1 / 2) * (1 + s)]
    # derivatives
    Nr = [(-1 / 2), (1 / 2), 0]
    Ns = [(-1 / 2), 0, (1 / 2)]
    return NN, Nr, Ns
end
triangle(x) = triangle(x[1], x[2])

"""
    quads(r,s)

Shape functions for a 4 node quadrilateral
`` r \\in [-1,1] ``, `` s \\in [-1,1] ``
"""
function quad(r, s)
    NN = [(1 / 4) * ((-1) + r) * ((-1) + s), (-1 / 4) * (1 + r) * ((-1) + s),
        (1 / 4) * (1 + r) * (1 + s), (-1 / 4) * ((-1) + r) * (1 + s)]
    # derivatives
    Nr = [
        (1 / 4) * ((-1) + s),
        (1 / 4) * (1 + (-1) * s),
        (1 / 4) * (1 + s),
        (1 / 4) * ((-1) + (-1) * s),
    ]
    Ns = [
        (1 / 4) * ((-1) + r),
        (1 / 4) * ((-1) + (-1) * r),
        (1 / 4) * (1 + r),
        (1 / 4) * (1 + (-1) * r),
    ]
    return NN, Nr, Ns
end
quad(x) = quad(x[1], x[2])

function shapefunc(el_type::String)
    if el_type == "line"
        return line
    elseif el_type == "triangle"
        return triangle
    elseif el_type == "quad"
        return quad
    else
        error("Element type not found")
    end
end

end
