function y = timevarying_delay(meanDelay, delayAmp, fj, fs)

    n = 1:39999;
    x = sin(2*pi*3400*n/fs);
   
    D = meanDelay + delayAmp * sin(2*pi*fj*n/fs);

    y = zeros(size(x));
    for i = 1:length(n)
        idx = n(i) - D(i);
    if idx >= 1 && idx < 39999
        k = fix(idx);
        frac = idx - k;
        y(i) = (1 - frac)*x(k) + frac*x(k + 1);
    else
        y(i) = 0;
    end

    end
end