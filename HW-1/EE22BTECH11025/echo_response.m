function [y] = echo_response(x)

time_instants = [20, 30, 60, 70] ;  
amplitudes = [0.55, -0.25, 0.15, -0.05];

fs = 8000; 
time_samples = fix(time_instants * fs / 1000);
len_h = max(time_samples);
y = zeros(length(x)+len_h-1,1);

for n = 1:length(time_samples)
    for k = 1:length(x)
        if k + time_samples(n) <= length(x)
            y(k) = y(k) + amplitudes(n) * x(k + time_samples(n));
        end
    end
end
end
