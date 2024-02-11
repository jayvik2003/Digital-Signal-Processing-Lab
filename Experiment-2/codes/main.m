function main()
  % Example usage:
    x = [0.5377 1.8339 -2.2588 0.8622 0.3188 -1.3077 -0.4336 0.3426 3.5784 2.7694 -1.3499 3.0349 0.7254 -0.0631 0.7147 -0.2050 -0.1241 1.4897 1.4090 1.4172];
    f = 2;

  % Upsample and downsample the signal
    upsampled_sequence = upsampling(x, f);
    downsampled_sequence = downsampling(x, f);
  % Display the results
    disp('upsample ');
    disp(upsampled_sequence);
    disp('downsample ');
    disp(downsampled_sequence);

  % Plot the signals
    subplot(3,1,1);  % Arrange plots vertically in 3 rows, 1 column
    stem(1:length(x), x, 'b', 'Marker', 'o', 'DisplayName', 'Original Signal');
    title('Original Signal');
    xlabel('Index');
    ylabel('x');

    subplot(3,1,2);
    stem(1:length(upsampled_sequence), upsampled_sequence, 'r', 'Marker', 'o', 'DisplayName', 'Upsampled Signal');  % Corrected marker to 'x'
    title('Upsampled Signal');
    xlabel('Index');
    ylabel('y1');

    subplot(3,1,3);
    stem(1:length(downsampled_sequence), downsampled_sequence, 'p', 'Marker', 'o', 'DisplayName', 'Downsampled Signal');  % Corrected marker to 'x'
    title('Downsampled Signal');
    xlabel('Index');
    ylabel('y2');

end

function y1 = upsampling(x, f)
  % Pre-allocate the output array with zeros
    y1 = zeros(1, length(x) * f);

  % Upsample the signal using vectorized operations
    y1(1:f:end) = x;
end

function y2 = downsampling(x, f)
  % Pre-allocate the output array with zeros
    y2 = zeros(1, floor(length(x) / f));

  % Downsample the signal using vectorized operations
    y2 = x(1:f:end);
end

