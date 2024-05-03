#include <stdio.h>
#include <stdlib.h>

#define N 20  // Assuming a maximum signal length of 20

double *upsampling(double x[], int f, int length) {
    // Pre-allocate the output array with zeros
    double *y1 = (double *)calloc(length * f, sizeof(double));

    // Upsample the signal using indexing
    for (int i = 0, j = 0; i < length * f; i += f, j++) {
        y1[i] = x[j];
    }

    return y1;
}

double *downsampling(double x[], int f, int length) {
    // Pre-allocate the output array 
    double *y2 = (double *)calloc((length + f - 1) / f, sizeof(double));

    // Downsample the signal using indexing
    for (int i = 0, j = 0; i < length; i += f, j++) {
        y2[j] = x[i];
    }

    return y2;
}

int main() {
    // Example usage:
    double x[N] = {0.5377, 1.8339, -2.2588, 0.8622, 0.3188, -1.3077, -0.4336, 0.3426, 3.5784, 2.7694, -1.3499, 3.0349, 0.7254, -0.0631, 0.7147, -0.2050, -0.1241, 1.4897, 1.4090, 1.4172 };  // Fill in your signal values
    int f = 2;
    int length = sizeof(x) / sizeof(x[0]);  // Determine actual signal length

    // Upsample and downsample the signal
    double *upsampled_sequence = upsampling(x, f, length);
    double *downsampled_sequence = downsampling(x, f, length);

    // Display the results
    printf("Upsampled sequence:\n");
    for (int i = 0; i < length * f; i++) {
        printf("%f ", upsampled_sequence[i]);
    }
    printf("\n");

    printf("Downsampled sequence:\n");
    for (int i = 0; i < (length + f - 1) / f; i++) {
        printf("%f ", downsampled_sequence[i]);
    }
    printf("\n");

    // Free allocated memory
    free(upsampled_sequence);
    free(downsampled_sequence);

    return 0;
}

