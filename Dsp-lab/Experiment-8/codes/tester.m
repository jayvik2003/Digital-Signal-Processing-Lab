for n = 1:2
    error(n) = main(n);
end

plot(error);
xlabel("different Sampling frequency (fs)");
ylabel("Mean of Absolute Error");
grid on;