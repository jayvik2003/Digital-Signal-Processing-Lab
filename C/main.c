#include <stdio.h>

// Function for upsampling a signal
void upsampling( double *x, int length, int factor, double *out) {
    for (int i = 0; i < length * factor; i += factor) {
        out[i] = x[i / factor]; // Insert original samples at spaced intervals
    }
}

// Function for downsampling a signal
void downsampling( double *x, int length, int factor, double *out) {
    int new_length = length / factor;
    for (int i = 0; i < new_length; i++) {
        out[i] = x[i * factor]; // Select every 'factor'th sample
    }
}

int main() {
    double x[] = {1, 2, 3, 4, 5, 6};
    int length = sizeof(x) / sizeof(x[0]);
    int factor = 3;

    double upsampled[length * factor]; // Pre-allocate space for upsampled sequence
    double downsampled[length / factor]; // Pre-allocate space for downsampled sequence

    upsampling(x, length, factor, upsampled);
    downsampling(x, length, factor, downsampled);

    printf("Upsampled sequence: ");
    for (int i = 0; i < length * factor; i++) {
        printf("%.1f ", upsampled[i]);
    }
    printf("\n");

    printf("Downsampled sequence: ");
    for (int i = 0; i < length / factor; i++) {
        printf("%.1f ", downsampled[i]);
    }
    printf("\n");

    return 0;
}

