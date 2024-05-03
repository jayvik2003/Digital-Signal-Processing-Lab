x = load('x_LTV.mat');
h = load('h_LTV.mat');

% Calculate output length
        l = length(x) + length(h) - 1;

% Initialize output sequence
        y = zeros(1, l);

  % Perform convolution manually
  for n = 1:l
    for k = 1:length(x)
      if (n - k + 1) >= 1 && (n - k + 1) <= length(h) 
        y(n) = y(n) + x(k) * h(n - k + 1);
  end end end end