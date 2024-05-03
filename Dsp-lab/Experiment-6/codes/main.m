function main()

fs = 4000;
f1 = 500;
f2 = 1000;
f3 = 700;

t = 0:1/fs:1; 
x = sin(2 * pi * f1 * t) + 2 * sin(2 * pi * f2 * t) + 1.5 * sin(2 * pi * f3 * t); 

omega = -pi:(2*pi)/fs:pi;

X = DTFT_func(x, omega);

figure;
plot((omega*fs)/(2*pi), abs(X));
xlabel('frequency(Hz)')
ylabel('|X(w)|')
grid on;

end

function X = DTFT_func(x, omega)
    
    N = length(x); 
    X = zeros(size(omega)); 
    for k = 1:length(omega)
        X(k) =(1/(N))* (sum(x .* exp(-1i * omega(k) .* (0:N-1))));
    end
end
