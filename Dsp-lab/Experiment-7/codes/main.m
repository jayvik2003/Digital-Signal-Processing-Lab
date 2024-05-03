function main()
N = 41;
wc = 2*pi/11;
fc = 1000;
fs = (2*pi*fc)/(wc);

hpf = hpf_func(fc,fs,N).*hw(N);
%fvtool(hpf);

lpf = lpf_func(fc,fs,N).*hw(N);
%fvtool(lpf);
[d,r]= audioread('msmn1.wav');

%df_hpf = convl(d,hpf);
df_lpf = convl(d,lpf);

%specgram(d,1024,r);
%specgram(df_hpf,1024,r);
specgram(df_lpf,1024,r);

%Plot impulse response of LPF and HPF
 %figure;
 % subplot(2,1,1); 
 %stem(lpf);
 %xlabel('Time (samples)');
 %ylabel('Amplitude');
 %title('Impulse Response of Low-pass Filter');
 %grid on;
 %figure;
% subplot(2,1,2);
 %stem(hpf);
 %xlabel('Time (samples)');
 %ylabel('Amplitude');
 %title('Impulse Response of High-pass Filter');
 %grid on;

end

function y = lpf_func(fc,fs,N)
wc = (2*pi*fc)/(fs);
n = 1;
y = zeros(1,N-1);
for k = -(N-1)/2:(N-1)/2 
    if k == 0
        y(n) = wc/pi;
    else
        y(n) = sin((wc*k))/(pi*k);
    end
    n = n + 1;
end
end
function y = hpf_func(fc, fs, N)
    wc = (2*pi*fc)/(fs);
    n = 1;
    y = zeros(1, N);
    for k = -(N-1)/2:(N-1)/2 
        if k == 0
            y(n) = 1 - (wc)/pi; 
        else
            y(n) = sin(pi*k)/(pi*k)-sin(wc*k)/(pi*k); % Adjustment for high-pass filter
        end
        n = n + 1;
    end
end
function y = hw(N) %window function
n = 1;
y = zeros(1,N);
for k = 0  : (N-1)
    if k >= 0 && k <= (N-1)
        y(n) = 0.54 - 0.46*cos((2*pi*k)/(N-1));
    else 
        y(n) = 0;
    end
    n = n + 1;
end
end
function y = convl(x,h) 
  l = length(x) + length(h) - 1;
  y = zeros(1, l);
  for n = 1:l
    for k = 1:length(x)
      if (n - k + 1) >= 1 && (n - k + 1) <= length(h) 
        y(n) = y(n) + x(k) * h(n - k + 1); % This is just /sigma x(k)*h(n-k)
      end
    end
  end
end
