using Pkg; Pkg.activate(".")
using Plots

function lag(x,j,X)
    n = length(X)

    l = 1.0

    for m = 1:n
        if m != j
            l *= ( x - X[m])/( X[j] - X[m] )
        end
    end
    return l

end

L(x,X,Y) = sum( [ lag(x, j, X)*Y[j] for j in 1:length(Y) ] )

X = [-1, 2, 4, 7]
f(x) = sin(x)
Y = f.(X)

x_range = LinRange(-1,7,40)
y_interp = [ L( x, X, Y) for x in x_range ]

plot( f, -1, 7, lw=2, label="sin(x)" )
plot!(x_range, y_interp, 
    lw=2, line_style=:dash, 
    label="Interpolation")
scatter!(X, Y, marker_size=4, label="Control Points")
