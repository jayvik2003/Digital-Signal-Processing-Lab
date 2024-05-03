function [y,h] = reverb(x)

fs = 8000;
t = 0:1/fs:0.04;
p = -0.625*t + 5;    
h = sqrt(10.^(p/10));
y = convolution_sum(x,h);

end
