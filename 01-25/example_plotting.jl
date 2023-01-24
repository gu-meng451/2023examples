## Load up the Plots package
using Pkg
Pkg.activate(".")
using Plots

## We can plot data

t = LinRange(0, 10, 30)
ζ = 0.1
y = exp.(-ζ*t).*cos.(sqrt.(1-ζ^2)*t)

# make a new plot
plt = plot(t, y, xlabel="Time t", ylabel="output [-]",
  linewidth=2, label="First curve")

# modify the plot, by calling `plot!`
y2 = exp.(-ζ*t).*cos.(sqrt.(1-ζ^2)*t .+ 1)
plot!(plt, t, y2, linewidth=2, label="Second curve")

## Plotting a function
f(t) = exp(-0.4*ζ*t)*cos(sqrt(1-ζ^2)*t)
plot!(plt, f,0,t[end], label="function version", 
  linewidth=2, linestyle=:dash)

## output results
# Save figure as a png
savefig(plt, "myfig.png")

# save figure as a pdf
savefig(plt, "myfig.pdf")