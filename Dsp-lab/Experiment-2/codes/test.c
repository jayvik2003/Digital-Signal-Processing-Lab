#include <stdio.h>
#include <math.h>

float fixpoint_multiply(double x1_fp, double x2_fp, int Q[]) {
   float int_bits = Q[0];
   float frac_bits = Q[1];

   float x1_scaled = round(x1_fp * pow(2, frac_bits));
   float x2_scaled = round(x2_fp * pow(2, frac_bits));

   long long product_int = x1_scaled * x2_scaled;  // Use long long to avoid overflow

   int product_fp = product_int / pow(2, frac_bits * 2);
   return product_fp;
}

float fixpoint_add(double x1_fp, double x2_fp, int Q[]) {
   float int_bits = Q[0];
   float frac_bits = Q[1];

   float x1_int = round(x1_fp * pow(2, frac_bits));
   float x2_int = round(x2_fp * pow(2, frac_bits));

   float sum_int = x1_int + x2_int;

   if (sum_int >= pow(2, int_bits)) {
       sum_int -= pow(2, int_bits);
   }

   float sum_fp = sum_int / pow(2, frac_bits);
   return sum_fp;
}

int main() {
   double x1_fp = 1.23456;
   double x2_fp = -0.78901;
   int Q[] = {3, 12};

   float sum_fp = fixpoint_add(x1_fp, x2_fp, Q);
   printf("Sum in fixed-point: %f\n", sum_fp);

   float product_fp = fixpoint_multiply(x1_fp, x2_fp, Q);
   printf("Product in fixed-point: %f\n", product_fp);

   return 0;
}
