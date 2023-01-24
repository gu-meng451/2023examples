## Simple File IO
using Pkg
Pkg.activate(".")

# turns out there are several (competing?) ways to write and read files in Julia
# We'll use JLD2 which is pretty portable and has few dependencies
# Pkg.add("JLD2")
using JLD2

## Example Data
# make some rando data
x = rand(Float32, 10,10)
y = Dict( :x=>Float64.(x), 2=>"second value" )
z = 700

jldsave("temp.jld2"; x,z, y)

## Loading everything
data = load("temp.jld2")

# to get `x` we call it by its string name
data["x"]

# if we only wanted to load a particular dataset, we add that directly to the `load` call
load_z = load("temp.jld2", "z")

## Other Packages to note
# - CSV.jl for reading/writing comma separated text files
# - MAT.jl for reading/writing Matlab files
# - XLSX.jl for IO with Excel files