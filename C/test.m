v_in = linspace(0.85, 1.15, 1e5); % in V
i_out_linear = 2*10*v_in - 10; % in mA
i_out_theoretical = 10 * (v_in.^2);

figure;
plot(v_in, i_out_linear, 'DisplayName', 'Linear Model about Operating Point');
hold on;
plot(v_in, i_out_theoretical, 'DisplayName', 'Theoretical')
title('Linear Characteristics at operating point');
xlabel('V_{in} (V)');
ylabel('I_{out} (mA)');
legend('show');
grid on;
saveas(gcf, 'linear_characteristics.png');

tolerance_above_1 = 1;
tolerance_above_5 = 1;
tolerance_below_1 = 1;
tolerance_below_5 = 1;

for i = 1:1e5
error = abs(i_out_theoretical(i) - i_out_linear(i))/abs(i_out_theoretical(i) - 10);

if(i < 5e4)
if(error>0.05)
tolerance_below_5 = i;
end
if(error>0.01)
tolerance_below_1 = i;
end

elseif(i > 5e4)
if(error<=0.05)
tolerance_above_5 = i;
end
if(error<=0.01)
tolerance_above_1 = i;
end
end
end
disp('Tolerance is 1% in the range ');
disp(v_in(tolerance_below_1));
disp(v_in(tolerance_above_1));
disp('Tolerance is 5% in the range ');
disp(v_in(tolerance_below_5));
disp(v_in(tolerance_above_5));