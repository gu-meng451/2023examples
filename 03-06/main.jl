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
Y = sin.(X)

x_range = LinRange(-1,7,10)
y_interp = [ L(x,X, Y) for x in x_range]

plot(x_range, y_interp)
scatter!(X, Y)
