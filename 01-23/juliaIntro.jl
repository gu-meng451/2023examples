## Packages and enviroments

using Pkg
Pkg.activate(".")
# Pkg.add("Polynomials")

# "]" in the REPL puts us in Pkg mode

## Types
# Numbers: Integers, Floats, Complex

a = 1
b = 1.

c::Int16 = 2

d = 1 + 3.0im
typeof(d)

# Arrays: 1D, 2D, Floats, Any
A = [ 1 2 3 4]
B = [1; 2; 3; 4.]
D = [1+2 (3 + 4)]

E = [1 3;
    2 5]

E[1,:]
E[:,2]
a = 1

# Tuple (cannot easily change after making):
q = (1,2,B)

a,b,c2 = q

# Strings
`a = "this is a string"`

# Dictionaries
A = Dict(1 => "value1", "2" => rand() )
# so to access it we use the 'key'
A[1]
A["2"]
A[:newsym] = 4

# Strucs
mutable struct myCustomType
    property1
    property2::String
    property3
end

ex1 = myCustomType(rand(), "this is a string", 3)
ex1.property1

## Memory Scope
# for loops and simple functions


## Packages and plotting
# we can add stuff from the Package library.  Let's add the Plots Package
# Pkg.add("Plots")
# using Plots

## future stuff: Modules
