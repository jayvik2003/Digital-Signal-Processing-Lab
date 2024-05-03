function Tst
    N = 20;
    fs = 11000;
    fc = 1000;

    fltr = hpf_func(fc, fs, N) .* hw(N);
    op = conv(d,fltr);
    sound(op,fs);
end

function y = hpf_func(fc, fs, N)
    wc = (2 * pi * fc) / fs;
    n = 1;
    y = zeros(1, N);
    for k = -(N-1)/2 : (N-1)/2 
        if k == 0
            y(n) = 1 - (wc / pi); % High-pass filter response
        else
            y(n) = -sin(wc * k) / (pi * k); % Negative of LPF's sinc response
        end
        n = n + 1;
    end
end

function y = hw(N) %window function
    y = zeros(1, N);
    for k = 0 : (N-1)
        y(k+1) = 0.54 - 0.46 * cos((2 * pi * k) / (N-1));
    end
end
