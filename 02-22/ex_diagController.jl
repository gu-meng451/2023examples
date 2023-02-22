using LinearAlgebra

function dropzeros(A; tol=1e-12)
    rel_A = norm(A)
    [ abs(a)/rel_A <= tol ? 0. : a for a in A ]
end

A = [-5.5 -1.1 -1.8 -2.6;
      1.0 -3.6  0.7  0.9;
      0.5  0.9 -2.8  0.4;
      0    0.4  0.7 -2.1]
B = [-0.2; 0.3; -0.2; 0.3]
C = [3 5 7 5.]
n = 4

F = eigen(A)
P = F.vectors

Ā = P\A*P |> dropzeros
B̄ = P\B |> dropzeros
C̄ = C*P |> dropzeros

# we could rescale that a bit further:
p = norm(B̄,Inf)
P = p*P
Ā = P\A*P |> dropzeros
B̄ = P\B |> dropzeros
C̄ = C*P |> dropzeros

# Build the controllability and observability matrices
CM = [B A*B A^2*B A^3*B]
det(CM)
rank(CM)

OM = [ C; C*A; C*A^2; C*A^3]
det(OM)
rank(OM)