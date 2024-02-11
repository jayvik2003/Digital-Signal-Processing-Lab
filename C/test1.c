#include <stdio.h>
#include <stdlib.h>

// Function to create an upscaled sequence by inserting zeros
double *upscaling(const double *x, int n, int f) {
   // Allocate memory for the upscaled sequence
   double *y = calloc(n * f, sizeof(double));

   if (y == NULL) {
       printf("Memory allocation failed!\n");
       return NULL;
   }

   // Insert elements with zeros in between
   int idx = 0;
   for (int i = 0; i < n; i++) {
       y[idx] = x[i];
       idx += f;
   }

   return y;
}

int main() {
   // Example usage:
   double x[] = {1, 2, 3, 4};
   int n = sizeof(x) / sizeof(x[0]);  // Length of x
   int f = 2;

   double *upscaled_sequence = upscaling(x, n, f);

   if (upscaled_sequence != NULL) {
       // Print the upscaled sequence
       for (int i = 0; i < n * f; i++) {
           printf("%.0f ", upscaled_sequence[i]);
       }
       printf("\n");

       free(upscaled_sequence);  // Free the allocated memory
   }

   return 0;
}
