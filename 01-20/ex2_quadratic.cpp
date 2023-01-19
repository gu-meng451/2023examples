#include <iostream>
#include <cmath>
template <typename T> int sgn(T val) {
    return (T(0) < val) - (val < T(0));
}

typedef float T;

int main()
{
    // a x^2 + b x + c = 0
    T a, b, c;
    bool flag_alt = true;

    a = 1.;
    b = 200.;
    c = -0.000015;

    // a = 1;
    // b = 1;
    // c = 2;

    T d = b*b - 4*a*c;
    // If the solution has real roots:
    if( d >= 0 )
    {
        printf("Real Result\n");
        T x1 = (-b - sgn(b)*sqrt(d) )/(2*a);
        T x2 = (-b + sgn(b)*sqrt(d) )/(2*a);
        printf("x1  = %.15f\n",x1);
        printf("x2  = %.15f\n",x2);

        if( flag_alt )
        {
            T x2_alt = c/a/x1;
            printf("x2 (alt) = %.15f\n",x2_alt);
        }
        return 0;
    }
    else
    {
        printf("Complex Result\n");
        T x1r, x1i, x2r, x2i;
        x1r = -b/2/a;
        x2r = x1r;

        x1i = sqrt(-d)/2/a;
        x2i = -x1i;

        printf("x1 = %.15f%+.15fj\n",x1r,x1i);
        printf("x2 = %.15f%+.15fj\n",x2r,x2i);
        return 0;
    }


    return 0;
}
