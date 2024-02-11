% a) Generate a square waveform using sinusoidal waveforms with different frequencies.
fs = 2e6; % Sampling frequency (2 MHz)
t = 0:1/fs:1e-3; % Time vector (1 ms)

% Generate square wave by summing sinusoidal harmonics
square_wave = zeros(size(t));
for f = 5e3:5e3:2e6
    square_wave = square_wave + sin(2*pi*f*t) / f;
end

% Normalize the square wave
square_wave = square_wave / max(abs(square_wave));

% b) Pass the square waveform through an amplifier with the specified frequency response
y_amplified = zeros(size(t));
for i = 1:2:100
    if 5*i >= 5 && 5*i < 10
        A = 1;
    elseif 5*i >= 10 && 5*i < 50
        A = 5;
    elseif 5*i >= 50 && 5*i < 200
        A = 2;
    elseif 5*i >= 200 && 5*i < 1e3
        A = 1;
    elseif 5*i >= 1e3 && 5*i < 2e3
        A = 0.3;
    elseif 5*i >= 2e3
        A = 0;
    end
    
    y_amplified = y_amplified + A * sin(2*pi*5*i*t) / (5*i);
end

% c) Pass the square waveform through an ideal low-pass filter with cutoff frequency 8 kHz
fc = 8e3; % Cutoff frequency: 8 kHz
filter = sinc(fc * (2 * (t - 0.5)));

% Apply filter to the amplified square waveform
filtered_output = conv(y_amplified, filter, "same");

% Plotting
figure;

% Plot 1: Generated Square Waveform
subplot(3, 1, 1);
plot(t, square_wave, 'b');
xlabel('Time (s)');
ylabel('Amplitude');
title('Generated Square Waveform');
grid on;

% Plot 2: Amplified Square Waveform
subplot(3, 1, 2);
plot(t, y_amplified, 'g');
xlabel('Time (s)');
ylabel('Amplitude');
title('Amplified Square Waveform');
grid on;

% Plot 3: Filtered Amplified Square Waveform
subplot(3, 1, 3);
plot(t, filtered_output, 'r');
xlabel('Time (s)');
ylabel('Amplitude');
title('Filtered Amplified Square Waveform');
grid on;
