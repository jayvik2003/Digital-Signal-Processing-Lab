function [y] = musical_notes()

f1 = 440; 
duration = 2; 
fs = 8000;
y = zeros(duration * fs * 12, 1);

for n = 1:12
    frequency = f1 * 2.^((n - 1) / 11);
    t = linspace(0, duration, duration * fs);
    m = sin(2 * pi * frequency * (t));
    % Calculate the indices for the current note
    % n =1 , indices = 1,2,3, ... 800 
    % n =2 , indices = 1 + 800 , 2 + 800 , ... 1600 and so on. 
    indices = (length(m) * (n - 1)) +(1:length(m));
    
    y(indices) = m;
end
end