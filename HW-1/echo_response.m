function [y] = echo_response(x)
    
    time_instants = [20, 30, 60, 70];  
    amplitudes = [0.55, -0.25, 0.15, -0.05]; 

    fs = 8000;
    y = zeros(size(x));

    for n = 1:length(time_instants)
        time_sample = fix(time_instants(n) * (fs*0.001));

        for k = time_sample:length(y)
            if k - time_sample + 1 <= length(x)
                y(k) = y(k) + amplitudes(n) * x(k - time_sample + 1);
            end
        end
    end
end
