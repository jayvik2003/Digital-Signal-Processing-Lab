function  y = generateToneLUT(fc, fs, numSamples)
    
    theta = linspace(0, 2*pi, 512);
    LUT = sin(theta);

    k = floor((1:numSamples) * fc/fs * 512);
    frac = ((1:numSamples) * fc/fs * 512) - (k);
    norm_k = mod(k - 1, 512) + 1;

    y = (1-frac) .* LUT(norm_k) + frac .* LUT(mod(norm_k, 512) + 1);
end
