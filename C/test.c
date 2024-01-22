#include <stdio.h>
double fliplr(double *x, int l1,int index)
{
        double x0[l1];

        for (int i = 0; i < l1; i++)
        {
                x0[(l1 - 1) - i ] = x[i];
        }
        return x0[index];
}

int main()
{

        double x[7] = {0.3426, 3.5784, 2.7694, -1.3499, 3.0349, 0.7254, -0.0631};
        int l1 = 7;
        
        double x0[l1];        
        for(int i = 0 ; i<l1 ; i++) {
                x0[i]=fliplr(x,l1,i);
                printf("%lf, ",x0[i]);
        }
}
