

A = Dict( 1=>"this is a string", "quad"=>rand(4,4), :quad=>3 )

A["quad"]

for i in keys(A)
    println(A[i])
end

for (key, val) in A
    println(val)
end