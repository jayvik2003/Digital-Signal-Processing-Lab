[y, fs] = audioread('speech_noisy.wav');

frameSize = 160; % Frame size for STFT
hopSize = 80;   % Hop size for STFT

% Compute STFT 
numFrames = floor((length(y) - frameSize) / hopSize) + 1;
S = zeros(frameSize, numFrames);

wnd = hanning(frameSize);

for i = 1:numFrames
    startIdx = (i - 1) * hopSize + 1;
    endIdx = startIdx + frameSize - 1;

    frame = y(startIdx:endIdx);
    % Apply Hanning window to the frame
    frame = frame .* wnd;

    % Compute FFT of the frame
    S(:, i) = fft(frame);
end

% Compute the noise threshold
noise_spectrum = mean(S,2); 
threshold = mean(20*log10(abs(S)),2) + 1.3*std(mean(20*log10(abs(S)),2));

% Apply noise reduction based on threshold condition
for i = 1:numFrames  
    S(:, i) = S(:, i) .* ( (noise_spectrum < threshold * max(noise_spectrum)));
end

%Compute ISTFT 
outputLength = (numFrames - 1) * hopSize + frameSize;
y_denoised = zeros(outputLength, 1);

for i = 1:numFrames
    startIdx = (i - 1) * hopSize + 1;
    endIdx = startIdx + frameSize - 1;

    % Inverse FFT to reconstruct time-domain frame
    frame_ifft = ifft(S(:, i));

    % Overlap/add to reconstruct the output signal
    y_denoised(startIdx:endIdx) = y_denoised(startIdx:endIdx) + frame_ifft .* wnd;
end

%audiowrite('denoised_speech_part2.wav', y_denoised, fs);
%sound(y_denoised);
%disp('Denoised denoising');

% Plot the spectrogram of the filtered signal
figure;
specgram(y_denoised, 256, fs);
title('SpectrogramSpeech');
colorbar;