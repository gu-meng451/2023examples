module FileInputOutput

using JLD2
using Dates
using Printf

function init_save_file( filename, mesh, quad_rules )

    jldopen(filename, "w") do f

        info = JLD2.Group(f, "info")
        info["date"] = now()
        info["hostname"] = gethostname()
        
        f["mesh"] = mesh
        f["quad_rules"] = quad_rules

    end

end

function save_snapshot( filename::String, snapshot_id::Int, q::AbstractArray )
    jldopen(filename, "a+") do f
        snapshot = JLD2.Group( f, @sprintf( "%d", snapshot_id  ) )
        snapshot["q"] = q
        snapshot["dateTime"] = now()
    end
end

function save_snapshot( filename::String, snapshot_id::Int, q::AbstractArray, time::Real )
    jldopen(filename, "a+") do f
        snapshot = JLD2.Group( f, @sprintf( "%d", snapshot_id  ) )
        snapshot["q"] = q
        snapshot["timeInSim"] = time
        snapshot["dateTime"] = now()
    end
end

function save_snapshot(filename::String, snapshot_id::Int, q::AbstractArray, qd::AbstractArray, time::Real)
    jldopen(filename, "a+") do f
        snapshot = JLD2.Group(f, @sprintf("%d", snapshot_id))
        snapshot["q"] = q
        snapshot["qd"] = qd
        snapshot["timeInSim"] = time
        snapshot["dateTime"] = now()
    end
end


end



