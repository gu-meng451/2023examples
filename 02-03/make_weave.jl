using Pkg
Pkg.activate(".")
using Weave
using Plots

filename = "sparse.jl"

weave(filename; doctype="md2html", out_path=:pwd)
