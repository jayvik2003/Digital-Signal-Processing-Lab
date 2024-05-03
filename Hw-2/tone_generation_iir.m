function y = tone_generation_iir(fc, fs, A)
   w = 2*pi*(fc/fs);
   a = -1;
   b = 2*cos(w);
   y_minus_1 = (A*sin(w))/a;
   y_minus_2 = (-b*y_minus_1)/a;
   y(1) = y_minus_2;
   y(2) = y_minus_1;
   for n = 3:16002
    y(n) = a*y(n-2) + b*y(n-1);
   end
   y = y(3:16002);
   
end
