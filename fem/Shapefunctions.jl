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

function quad(r,s)

    NN = NaN
    Nr = NaN
    Ns = NaN
    return NN, Nr, Ns

end
quad(r) = quad(r[1],r[2])

function shapefunc(el_type::String)
    if el_type == "line"
        return line
    elseif el_type == "quad"
        return quad
    else
        error("Element type not found")
    end
end

end