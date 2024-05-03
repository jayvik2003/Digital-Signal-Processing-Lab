function main()

N = 39;

%lpf
wc = pi/2;
fc= 400;
fs_lpf = (2*pi*fc)/(wc);
h1 = lpf_func(fc,fs_lpf,N).*hw(N);
fvtool(h1);
disp('h1');
disp(h1);
x1 = 1 :N;
figure
stem(x1,h1)
xlabel('N-sample')
ylabel('lpf x wd (Impulse)')
grid on;

%bpf
fc1 = 500;
fc2 = 1200;
fs_bpf = 6000;
h2 = bpf_func(fc1,fc2,fs_bpf,N).*hw(N);
fvtool(h2);
disp('h2');
disp(h2);
x2 = 1:N;
figure
stem(x2,h2)
xlabel('N-sample')
ylabel('bpf x wd (Imppulse)')
grid on;

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

function y = bpf_func(fc1,fc2,fs,N) %bandpass

wc1 = (2*pi*fc1)/(fs);
wc2 = (2*pi*fc2)/(fs);
n = 1;
y = zeros(1,N-1);
for k = -(N-1)/2: (N-1)/2
    if k == 0
        y(n) = (wc2 - wc1)/pi;
    else
        y(n) = (sin((wc2*k))/(pi*k)) - (sin((wc1*k))/(pi*k));
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
