## Let's make a function

f(x) = sin(2*x + 1)

# now `f` is the name of the function that takes 1 input.
# this input is generic, meaning we didn't require it to be a particular type

# there's an alternate notation we can use
g = x -> sin(2*x + 1)
# and g(x) is the same as f(x)

f(1)

x = LinRange(-1,3,10)
f.(x)

## Multiple inputs
h(x,y) = x + y

## Larger forms of functions
function largefcn(a,b,c)

    # do interesting things here
    x = a + b + c

    if a > b
        return x
    else
        return (c,x)
    end

end

output = largefcn(2., 20., 1.)

## Optional inputs
function myfcn(x,y; n = 4)

    # let's use a list comprehension
    A = [ x^i + y^j for i in 1:n, j in 1:n ]

end

myfcn(2,2)
