% Read the noisy speech signal
[y, fs] = audioread('speech_with_beeps.wav');

% Parameters
frameSize = 160; % Frame size for STFT
hopSize = 80;   % Hop size for STFT

% Compute STFT manually
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

threshold_factor = 4; 
for i = 1:numFrames

    % Find peaks in the spectrogram
    peaks = find(abs(S(:, i)) > threshold_factor * mean(abs(S(:, i))));

    % Zero out the corresponding frequency bins
    S(peaks, i) = 0;
end

% Compute ISTFT
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

%audiowrite('denoised_speech_part1.wav', y_denoised, fs);
%sound(y_denoised);
%disp('denoising speech done');

% Plot the spectrogram using specgram
figure;
specgram(y_denoised, 256, fs); 
title('SpectrogramSpeech');
colorbar;
