#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int fixpoint(double a, int Q)
{
    int y = round(a * pow(2, Q));
    return y;
}

int main()
{
    int Q = 12;
    double x1 = 3.1425;
    double x2 = 4.2357;
    double sum_final, product_final;
    double sum_values[10], product_values[10];

    for (int i = 3; i <= Q; i++)
    {
        int sum = fixpoint(x1, i) + fixpoint(x2, i);

        sum_values[i - 3] = sum_final = sum / (pow(2, Q));

        double product = fixpoint(x1, i) * fixpoint(x2, i);

        product_values[i - 3] = product_final = product / (pow(pow(2, Q), 2));
    }
    printf("value of sum at different fractional bits -->");
    for (int i = 0; i <= Q - 3; i++)
    {
        printf("%.4f ", sum_values[i]);
    }

    printf("\n");

    printf("value of product at different fractional bits -->");
    for (int i = 0; i <= Q - 3; i++)
    {
        printf("%.4f ", product_values[i]);
    }

    printf("\n");
    
    printf("sum of the fixpoint number is %.4f\nproduct of the fixpoint number is %.4f", sum_final, product_final);
}