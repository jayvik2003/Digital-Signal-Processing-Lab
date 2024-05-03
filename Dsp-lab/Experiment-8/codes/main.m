function main()
fs = 8000;
f1 = 500;
f2 = 1000;
f3 = 700;

t = 0:1/fs:1; 
x = sin(2 * pi * f1 * t) + 2 * sin(2 * pi * f2 * t) + 1.5 * sin(2 * pi * f3 * t); 

%(INTERPOLATION)
N = 39;
L = 2;

wc1 = pi/L;
fc1 = (wc1*fs)/(2*pi);

% Step-1 (upscaling)
xe = upsampler(x,L);

% Step-2 (Lowpass filtered)
h0 = lpf_ftr(fc1,fs,N,L);
xi = convl(xe,h0);


%(DECIMATION)
M = 2;
wc2 = pi/M;
fc2 = (wc2*fs)/(2*pi);

% Step-3 (Lowpass filtered)
h1 = lpf_ftr(fc2,fs,N,1);
xi2 = convl(xi,h1);

% Step-4 (downscaling)
xd = downsampler(xi2,M);

error = mean(abs(xd((N+1)/2:fs+(N+1)/2)-x));
disp(error)

end
function y1 = upsampler(x, f)
    y1 = zeros(1, length(x) * f);
    y1(1:f:end) = x;
end

function y2 = downsampler(x, f)
    y2 = zeros(1, floor(length(x) / f));
    y2 = x(1:f:end);
end

function y = lpf_ftr(fc,fs,N,G)

wc = (2*pi*fc)/(fs);
n = 1;
y = zeros(1,N-1);
for k = -(N-1)/2:(N-1)/2 
    if k == 0
        y(n) =G*wc/pi;
    else
        y(n) = G*sin((wc*k))/(pi*k);
    end
    n = n + 1;
end

y = y.*hw(N);

end

function w = hw(N) %window function

n = 1;
w = zeros(1,N-1);
for k = 0  : (N-1)
    if k >= 0 && k <= (N-1)
        w(n) = 0.54 - 0.46*cos((2*pi*k)/(N-1));
    else 
        w(n) = 0;
    end
    n = n + 1;
end


end

function y = convl(x,h) % y here is the output

  l = length(x) + length(h) - 1;

  y = zeros(1, l);

  for n = 1:l
    for k = 1:length(x)
      if (n - k + 1) >= 1 && (n - k + 1) <= length(h) 
        y(n) = y(n) + x(k) * h(n - k + 1); 
      end
    end
  end
end
