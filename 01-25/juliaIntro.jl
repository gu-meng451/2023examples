using Printf

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

# for loops:
for i in 1:4
    x = i
end
# neither x or i exist out here

# let's try again but use a global variable
# you need to initialize the variable before the loop
x = 0
y = 0
for i in 1:4
    x = i
    y += x
    j = 10
end
x
y
# stuff that is *initialized* inside a loop is local to the loop!

# arrays in loops won't change size like Matlab
n = 10
X = zeros(n) # defaults to Float64
for i in 1:n
    X[i] = cos(i)
end
X

# loops can also work over elements of an array instead of just counting integers.  We can also use a "List Comprehension" to make the previous pattern simpler

[ cos(x) for x in 1:n ]


## while loops
# these are useful when we don't know ahead of time how many times we need to work through the loop.  This is a common task when we are using an iterative method and we are trying to converge on a solution.
n = 3
iter = 0
while iter < n
    iter += 1
    @printf("i = %d\n",i)
end



## future stuff: Modules (groupings of functions)
