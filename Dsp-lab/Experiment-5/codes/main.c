#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define N 39
#define M_PI 3.14159265358979323846

void lpf_func(double fc, double fs, double* h) {
    double wc = (2 * M_PI * fc) / fs;
    for (int k = -(N - 1) / 2, n = 0; k <= (N - 1) / 2; ++k, ++n) {
        if (k == 0) {
            h[n] = (wc / M_PI) ;
        } else {
            h[n] = (sin(wc * k) / (M_PI * k)) ;
        }
    }
}

void bpf_func(double fc1, double fc2, double fs, double* h) {
    double wc1 = (2 * M_PI * fc1) / fs;
    double wc2 = (2 * M_PI * fc2) / fs;
    for (int k = -(N - 1) / 2, n = 0; k <= (N - 1) / 2; ++k, ++n) {
        if (k == 0) {
            h[n] = ((wc2 - wc1) / M_PI) ;
        } else {
            h[n] = ((sin(wc2 * k) / (M_PI * k)) - (sin(wc1 * k) / (M_PI * k)));
        }
    }
}

double hw(int i) {
    double window[N];
    for (int k = 0; k < N; ++k) {
        window[k] = 0.54 - 0.46 * cos((2 * M_PI * k) / (N - 1));
    }
    return window[i];
}

int main() {
    double h1[N], h2[N];
    double fc = 400, fs_lpf = 1600;
    lpf_func(fc, fs_lpf, h1);

    double fc1 = 500, fc2 = 1200, fs_bpf = 6000;
    bpf_func(fc1, fc2, fs_bpf, h2);

    
    printf("h1:\n");
    for (int i = 0; i < N; ++i) {
        printf("%f ", h1[i]*hw(i));
    }
    printf("\n");

    printf("h2:\n");
    for (int i = 0; i < N; ++i) {
        printf("%f ", h2[i]*hw(i));
    }
    printf("\n");

    return 0;
}
