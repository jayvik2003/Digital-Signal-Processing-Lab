function [y] = LTV_impulse(x,H)

N = length(x);
L = width(H);
y = zeros(N + L - 1, 1);
for n = 1:N+L-1
     for k = max(1, n - N + 1):min(n, L)
         if n - k + 1 >= 1 && n - k + 1 <= N
            y(n) = y(n) + x(n - k + 1) * H(n - k + 1, k);
         end
     end
end 
end
