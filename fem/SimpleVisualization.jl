module SimpleVisualization

include("Shapefunctions.jl")
using .Shapefunctions

using GLMakie
using LinearAlgebra

function init_plot(; xlabel = "Position x", ylabel="Displacement u")
    fig = Figure()
    ax = Axis(fig[1, 1], autolimitaspect = 1,
              xlabel = xlabel,
              ylabel = ylabel)

    return fig, ax
end

function draw_element(ax, mesh, q; linestyle = nothing, linewidth = 2,
                      color = GLMakie.Makie.wong_colors()[1])

    # plot cells
    for (element_type, ien) in mesh.IEN
        if element_type == "line"
            nel = size(ien, 1)
            for e in 1:nel
                A = ien[e, :]
                xpts = @view mesh.x[A]
                idx = mesh.ID[1, A]
                qe = @view q[idx]
                lines!(ax, xpts, qe, color = color,
                       linestyle = linestyle,
                       linewidth = linewidth)
            end
        end
    end
end

function draw_element_stress(ax, mesh, q, properties;
                             linestyle = nothing, linewidth = 2,
                             color = GLMakie.Makie.wong_colors()[1])

    # plot cells
    for (element_type, ien) in mesh.IEN
        if element_type == "line"
            nel = size(ien, 1)
            N = Shapefunctions.shapefunc(element_type)
            ξ = LinRange(-1,1,3)
            for e in 1:nel
                A = ien[e, :]
                xe = @view mesh.x[A]
                idx = mesh.ID[1, A]
                qe = @view q[idx]
                X = zeros(length(ξ))
                σ = zeros(length(ξ))
                for (i,ξ) in enumerate(ξ)
                    NN,Nξ = N(ξ)
                    X[i] = dot(NN,xe)
                    σ[i] = properties.E*properties.A*dot(Nξ,qe)/dot(Nξ, xe)
                end

                lines!(ax, X, σ, color = color,
                       linestyle = linestyle,
                       linewidth = linewidth)
            end
        end
    end
end

end