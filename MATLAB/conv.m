function conv()

  % Get input sequences
  x = input('Enter the first sequence x: ');
  h = input('Enter the second sequence h: ');

  % Calculate output length
  l = length(x) + length(h) - 1;

  % Initialize output sequence
  y = zeros(1, l);

  % Perform convolution manually
  for n = 1:l
    for k = 1:length(x)
      if (n - k + 1) >= 1 && (n - k + 1) <= length(h)
        y(n) = y(n) + x(k) * h(n - k + 1);
      end
    end
  end

  % Display the result
  disp(y);

end
