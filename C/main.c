#include <stdio.h>

void calc_conv(double *x, double *h, int l1, int l2) // function to compute convolution
{
    int l = l1 + l2 - 1;
    double y[l];
    for (int n = 0; n < l; n++)
    {
        y[n] = 0;
        for (int k = 0; k < l1; k++)
        {
            if (n - k >= 0 && n - k < l2) /*keeping the h(n-k) sequnce same even though it has been folded and shifted */
            {
                y[n] = y[n] + x[k] * h[n  - k]; /* computing \sigma x(k)*h(n-k) */
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

int main()
{

    /*int l1, l2;
    double x[l1], h[l2];
    printf("Enter the length of the first sequence: ");
    scanf("%d", &l1);
    printf("Enter the length of the second sequence: ");
    scanf("%d", &l2);

    printf("Enter the first sequence x:\n");
    for (int i = 0; i < l1; i++) {
        scanf("%d", &x[i]);
    }

    printf("Enter the second sequence h:\n");
    for (int i = 0; i < l2; i++) {
        scanf("%d", &h[i]);
    } */

    // for our question i am taking the given input directly but the above commented part can also be used

    int l1 = 7;
    int l2 = 5;
    double x[7] = {0.3426, 3.5784, 2.7694, -1.3499, 3.0349, 0.7254, -0.0631};
    double h[5] = {0.7147, -0.2050, -0.1241, 1.4897, 1.4090};

    printf("Convolution of x and h resulted:\n");
    calc_conv(x, h, l1, l2);

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

    return 0;
}
