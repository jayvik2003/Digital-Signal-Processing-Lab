function main2

X1 = 3.1425;
X2 = 4.2357;

Q_values = 3:12;
sum_values = zeros(size(Q_values)); %taking an array of sum for each iteration of Q for plotting sake (optional)
product_values = zeros(size(Q_values)); %same as thing but for product

for idx = 1:length(Q_values)

    Q = Q_values(idx); %taking an array of Q for plotting sake (optional)

    sum = fixpoint(X1, Q) + fixpoint(X2, Q); % performing sum of fix-point number
    sum_values(idx) = sum / (2^Q); % Store results of sum for later plotting 

    pro = fixpoint(X1, Q) * fixpoint(X2, Q); % performing product of fix-point number
    product_values(idx) = pro / (2^(2*Q)); % Store results of product for later plotting and display
end

disp('The addition is');
disp(sum / (2^Q));

disp('The product is');
disp(pro / (2^(2*Q)));

% This part is for ploting (optional)
%{
% Plotting Sum
figure;
subplot(2, 1, 1);
plot(Q_values, sum_values, 'o-', 'LineWidth', 2);
hold on;
y_ref_sum = X1 + X2;
plot(Q_values, y_ref_sum * ones(size(Q_values)), '--', 'LineWidth', 2, 'Color', 'r');
hold off;
legend('Sum', 'X1 + X2');
title('Sum vs Q with Reference Line');
xlabel('Q');
ylabel('Sum / 2^Q');
grid on;

% Plotting Product
subplot(2, 1, 2);
plot(Q_values, product_values, 'o-', 'LineWidth', 2);
hold on;
y_ref_product = X1 * X2;
plot(Q_values, y_ref_product * ones(size(Q_values)), '--', 'LineWidth', 2, 'Color', 'r');
hold off;
legend('Product', 'X1 * X2');
title('Product vs Q with Reference Line');
xlabel('Q');
ylabel('Product / 2^(2*Q)');
grid on;
%}

end

% Function to perform fixed-point arithmetic
function result = fixpoint(a, Q)
    result = fix(a * 2^Q);
end
