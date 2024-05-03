function [y] = convolution_sum(x,h)

l = length(x) + length(h) - 1;
y = zeros(l, 1);
for n = 1:l
  for k = 1:length(x)
    if (n - k + 1) >= 1 && (n - k + 1) <= length(h) 
      y(n) = y(n) + x(k) * h(n - k + 1);
    end
  end
end 
end
