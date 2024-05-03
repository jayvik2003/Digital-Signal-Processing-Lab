%fs = 8000;
%[y,fs] = audioread("solo.wav");
t = 0:1/8000:2;
tone = sin(2*pi*250*14*t);

[tone,W] = freqz(tone,1,1024,"whole",8000);

plot(W,20*log10(abs(tone)));


abs(fft(---))