#include <stdio.h>

void calc_conv(int *x, int *h, int l1, int l2, int *y) {
    int l = l1 + l2 - 1;

    for (int n = 0; n < l; n++) {
        y[n] = 0;
        for (int k = 0; k < l1; k++) {
            if (n - k >= 0 && n - k < l2) {
                y[n] += x[k] * h[n - k];
            }
        }
    }
}

int main() {
    int l1, l2, x[100], h[100], y1[100], y[100];

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
    }

    int l = l1 + l2 - 1;

    calc_conv(x,h,l1,l2,y1);

    calc_conv(x,y1,l1,l,y);

    printf("Correlation result:\n");
    for (int i = 0; i < l1 + l2 - 1; i++) {
        printf("%d ", y[i]);
    }
    printf("\n");

    return 0;
}

