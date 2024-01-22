t = 0:.001:2;
y=0;
y1=0;
k= 2*pi;
for w = 1:2:100
    y1 = y1 + A*(1/(w))*sin(w*t);
    if w >= 5 && w < 10 
        A=1;
    elseif w >= 10 && w < 50
        A=5;
    elseif w >= 50 && w < 200
        A=2;
    elseif w >= 200 && w < 1000
        A=1;
    elseif w >= 1000 && w < 2000
        A=0.3;
    elseif w >= 2000
        A=0;
    end
    if w >=5 && w <= 3001
        y = y + (1/(w))*sin(w*t);
    end
end

% Ideal low-pass filter with cut-off frequency 8 Hz
fc = 8;
filter = sinc(fc*((t)));
filter = filter / max(filter);  % Normalize for unity gain

% Apply filter to y1
filtered_y1 = conv( filter,y1,"same");


% Time-domain plots
plot(t, y, 'b');
hold on;
plot(t, y1, 'g');
plot(t, filtered_y1, 'r');
xlabel('Time (s)');
ylabel('Amplitude');
title('Time-Domain Plots');
legend('i/p', 'Amplified i/p', 'Filtered Amplified i/p');
grid on;





