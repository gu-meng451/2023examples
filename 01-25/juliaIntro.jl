## Strings
`a = "this is a string"`

## Dictionaries
A = Dict(1 => "value1", "2" => rand() )
# so to access it we use the 'key'
A[1]
A["2"]
A[:newsym] = 4

## Strucs
mutable struct myCustomType
    property1
    property2::String
    property3
end

ex1 = myCustomType(rand(), "this is a string", 3)
ex1.property1

## Memory Scope
# for loops and simple functions


## future stuff: Modules (groupings of functions)
