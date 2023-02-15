function jacobi(nx,ny, tol, maxIter, T0; verbose=false)

    T = copy(T0)
    Tnew = copy(T0)
    residuals = zeros(nx,ny)

    flag = 0
    iter = 0
    while flag == 0
        iter += 1 # iter = iter + 1

        # update all the open values of T
        # T[i,j] = 1/4*( T[i+1,j] + T[i-1,j] + T[i,j+1] + T[i,j-1]  )

        for i = 2:nx-1
            for j = 2:ny-1
                Tnew[i,j] = 1/4*( T[i+1,j] + T[i-1,j] + T[i,j+1] + T[i,j-1]  )
            end
        end
        T = copy(Tnew)
        # T = Tnew % if using Matlab

        for i = 2:nx-1
            for j = 2:ny-1
                residuals[i,j] = T[i+1,j] + T[i-1,j] + T[i,j+1] + T[i,j-1] - 4*T[i,j]
            end
        end

        if verbose
            @printf("iter=%3d, |res|=%.3e\n", iter, norm(residuals))
        end

        if norm(residuals) <= tol
            flag = 1
        elseif iter >= maxIter
            flag = -1
            error("Failed to converge")
        end

    end

    return (T, iter)
end