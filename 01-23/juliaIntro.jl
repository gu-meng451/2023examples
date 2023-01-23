## Packages and enviroments
using Pkg
Pkg.activate(".")

## Types
# Numbers: Integers, Floats, Complex

# Arrays: 1D, 2D, Floats, Any

# Strings

# Dictionaries

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
