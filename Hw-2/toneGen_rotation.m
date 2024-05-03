function [sin_Wave, cos_Wave] = toneGen_rotation(fc, fs)

    numSamples = 16000;
    w = 2 * pi * (fc / fs);

    y1 = zeros(2, numSamples);
    y1(:, 1) = [1; 0];

    tyr_cos = taylor(cos(sym('n')), 'Order', 10);
    tyr_sin = taylor(sin(sym('n')), 'Order', 10);

    apx_cos = subs(tyr_cos, w);
    apx_sin = subs(tyr_sin, w);

    rtn_matrix = [apx_cos, -apx_sin; apx_sin, apx_cos];

    cos_Wave = zeros(1, numSamples);
    cos_Wave(1,1) = 1;
    sin_Wave = zeros(1, numSamples);
    sin_Wave(1,1) = 0;
    for n = 1:numSamples - 1
        y1(:, n + 1) = rtn_matrix * y1(:, n);
        cos_Wave(n + 1) = y1(1, n + 1);
        sin_Wave(n + 1) = y1(2, n + 1);
    end

end
