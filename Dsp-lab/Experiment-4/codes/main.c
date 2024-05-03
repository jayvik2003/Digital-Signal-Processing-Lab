#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int fixpoint(float a, int Q)
{
    int y = round(a * pow(2, Q));
    return y;
}

float float_calc_conv(float *x, float *h, int l1, int l2,int index) // function to compute convolution
{
    int l = l1 + l2 - 1;
    float y[l];
    for (int n = 0; n < l; n++)
    {
        y[n] = 0;
        for (int k = 0; k < l1; k++)
        {
            if (n - k >= 0 && n - k < l2) 
            {
                y[n] = y[n] + x[k] * h[n  - k]; 
            }
        }
    }

    return y[index];
}

float fix_calc_conv(float *x, float *h, int l1, int l2,int index) // function to compute convolution
{
    int l = l1 + l2 - 1;
    
    float y[l],xh;
    
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

    return y[index];
}

float fliplr(float *x, int l1, int index) // function for folding the sequence i.e finding x(-n)
{
    float x0[l1];

    for (int i = 0; i < l1; i++)
    {
        x0[(l1 - 1) - i] = x[i];
    }
    return x0[index];
}

float fix_calc_corr(float *x, float *h, int l1, int l2,int index) // function to compute corss correlation
{
    float h0[l2];
    int l = l1 + l2 - 1;
    float y[l];
    for (int i = 0; i < l2; i++)
    {
        h0[i] = fliplr(h, l2, i);
    }
    for (int i = 0; i < l1 + l2 - 1; i++)
    {
        y[i]=fix_calc_conv(x, h0, l1, l2,i);
    }
    return y[index];
    
}

float float_calc_corr(float *x, float *h, int l1, int l2,int index) // function to compute corss correlation
{
    float h0[l2];
    int l = l1 + l2 - 1;
    float y[l];
    for (int i = 0; i < l2; i++)
    {
        h0[i] = fliplr(h, l2, i);
    }
    for (int i = 0; i < l1 + l2 - 1; i++)
    {
        y[i]=float_calc_conv(x, h0, l1, l2,i);
    }
    return y[index];
    
}

float error(float *x_obs,float *x_acc,int n,int index) 
{
    float err[n];

    for(int i=0;i<n;i++)
    {
        err[i]=(pow((x_obs[i]-x_acc[i]),2));
        
    }
    return err[index];
}

float sum(float *x, int n) {
    
    float total = 0;

    // Loop through the array using a pointer, efficiently accessing elements
    for (int i = 0; i < n; i++) {
        total += *(x + i); // Dereference the pointer with offset to get each element
    }

    float avg = total/n;

    return avg;
}

int main() 
{
    int l1 = 7;
    int l2 = 5;
    int l =l1 +l2 -1;
    float x[7] = {0.3426, 3.5784, 2.7694, -1.3499, 3.0349, 0.7254, -0.0631};
    float h[5] = {0.7147, -0.2050, -0.1241, 1.4897, 1.4090};
    
    printf("Convolution by fixpoint arithemetic of x and h resulted:\n");
    
    for (int i = 0; i < l1 + l2 - 1; i++)
    {
        printf("%.4f   ", fix_calc_conv(x, h, l1, l2,i));
    }
    printf("\n");

    printf("Convolution by floatpoint arithemetic of x and h resulted:\n");

    for (int i = 0; i < l1 + l2 - 1; i++)
    {
        printf("%.4f   ", float_calc_conv(x, h, l1, l2,i));
    }
    printf("\n");

    printf("Cross-correlation by fixpoint arithemetic of x and h resulted:\n");
    
    for (int i = 0; i < l1 + l2 - 1; i++)
    {
        printf("%.4f   ", fix_calc_corr(x, h, l1, l2,i));
    }
    printf("\n");

    printf("Cross-correlation floatpoint arithemetic of x and h resulted:\n");

    for (int i = 0; i < l1 + l2 - 1; i++)
    {
        printf("%.4f   ", float_calc_corr(x, h, l1, l2,i));
    }
    printf("\n");

    printf("the mean square error for convolution \n");

    // for computing mse in convolution
    float y_acc[l],y_obs[l],err[l];

    for(int i = 0; i < l1 + l2 - 1; i++)
    {
        y_obs[i]=float_calc_conv(x, h, l1, l2,i);
        y_acc[i]=fix_calc_conv(x, h, l1, l2,i);
    }

    for (int i = 0; i < l1 + l2 - 1; i++)
    {
        err[i]=error(y_obs,y_acc,l,i);
        printf("%E   ", error(y_obs,y_acc,l,i));
    }
    printf("\n");

    printf("The mse sum is %E",sum(err,l));

    printf("\n");

    // for computing mse in correlation

    printf("the mean square error for correlation\n");

    for(int i = 0; i < l1 + l2 - 1; i++)
    {
        y_obs[i]=float_calc_corr(x, h, l1, l2,i);
        y_acc[i]=fix_calc_corr(x, h, l1, l2,i);
    }    

    for (int i = 0; i < l1 + l2 - 1; i++)
    {
        err[i]=error(y_obs,y_acc,l,i);
        printf("%E   ", error(y_obs,y_acc,l,i));
    }
    printf("\n");

    printf("The mse sum is %E",sum(err,l));
    
    printf("\n");

    return 0;
}