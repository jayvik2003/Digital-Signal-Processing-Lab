#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int fixpoint(double a, int Q)
{
    int y = round(a * pow(2, Q));
    return y;
}

void calc_convf(double *x, double *h, int l1, int l2) // function to compute convolution
{
    int l = l1 + l2 - 1;
    
    double y[l],xh;
    
    int yf,xf,hf,xhf,xhff;

    for (int n = 0; n < l; n++)
    {
        y[n] = 0;
        int Q = 12;
        for (int k = 0; k < l1; k++)
        {
            if (n - k >= 0 && n - k < l2) /*keeping the h(n-k) sequnce same even though it has been folded and shifted */
            {
                yf = fixpoint(y[n],Q);
                xf = fixpoint(x[k],Q);
                hf = fixpoint(h[n-k],Q);

                xhf = xf*hf;
                xh = xhf/(pow(2,2*Q));

                xhff = fixpoint(xh,Q); 

                yf = yf + xhff;  
                y[n] = yf/(pow(2,Q));
            }
        }
    }

    for (int i = 0; i < l1 + l2 - 1; i++)
    {
        printf("%.4lf   ", y[i]);
    }
    printf("\n");
}

double fliplr(double *x, int l1, int index) // function for folding the sequence i.e finding x(-n)
{
    double x0[l1];

    for (int i = 0; i < l1; i++)
    {
        x0[(l1 - 1) - i] = x[i];
    }
    return x0[index];
}

void calc_xcorr(double *x, double *h, int l1, int l2) // function to compute corss correlation
{
    double h0[l2];
    for (int i = 0; i < l2; i++)
    {
        h0[i] = fliplr(h, l2, i);
    }
    calc_conv(x, h0, l1, l2);
}

void calc_acorr(double *x, int l1) // function to compute auto correlation
{
    double x0[l1];
    for (int i = 0; i < l1; i++)
    {
        x0[i] = fliplr(x, l1, i);
    }
    calc_conv(x, x0, l1, l1);
}

double error(double *x_obs,double *x_acc,int n) 
{
    double err[n];

    for(int i=0;i<n;i++)
    {
        err[i]=err[i] + (pow((x_obs[i]-x_acc[i]),2))/(n);
        printf("%E   ", err[i]);
    }
    printf("\n");
}

int main() 
{
    int l1 = 7;
    int l2 = 5;
    double x[7] = {0.3426, 3.5784, 2.7694, -1.3499, 3.0349, 0.7254, -0.0631};
    double h[5] = {0.7147, -0.2050, -0.1241, 1.4897, 1.4090};

    printf("Convolution of x and h resulted:\n");
    calc_convf(x, h, l1, l2);

    printf("\n");

    printf("Cross-correlation of x and h resulted:\n");
    calc_xcorr(x, h, l1, l2);

    printf("\n");

    printf("auto-correlation of x resulted:\n");
    calc_acorr(x, l1);

    printf("\n");

    printf("auto-correlation of h resulted:\n");
    calc_acorr(h, l2);

    printf("\n");

    printf("the mse is ");

    return 0;
}