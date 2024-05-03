function main()

x = [0.3426 3.5784 2.7694 -1.3499 3.0349 0.7254 -0.0631];
h = [0.7147 -0.2050 -0.1241 1.4897 1.4090];

disp('convolution x and h by fix-point arithmetic is given by');
disp(fix_convl(x,h));

disp('corss-correlation of x and h by fix-point arithmetic is given by');
disp(fix_xcorrl(x,h));


disp('error of convolution from my function');
err_convl = mserr(fix_convl(x,h),float_convl(x,h),length(x)+length(h)-1);
disp(err_convl)

disp('error of correlation from my function');
err_xcorrl = mserr(fix_xcorrl(x,h),float_xcorrl(x,h),length(x)+length(h)-1);
disp(err_xcorrl);

%Plot
x = 1:1:length(x)+length(h)-1;
figure;
plot(x,err_convl,"g")
grid on;
figure;
plot(x,err_xcorrl,"b")
grid on;
end

function y = float_convl(x,h) % y here is the output

  l = length(x) + length(h) - 1;

  % Initialize output sequence
  y = zeros(1, l);

  % Perform convolution manually
  for n = 1:l
    for k = 1:length(x)
      if (n - k + 1) >= 1 && (n - k + 1) <= length(h) 
        y(n) = y(n) + x(k) * h(n - k + 1); % This is just /sigma x(k)*h(n-k)
      end
    end
  end
end

function y = fix_convl(x,h) % y here is the output
  
  % Calculate output length
  l = length(x) + length(h) - 1;

  % Initialize output sequence
  y = zeros(1, l);
  Q = 12;
  % Perform convolution manually
  for n = 1:l
    for k = 1:length(x)
      if (n - k + 1) >= 1 && (n - k + 1) <= length(h)
        
        yf = fixpoint(y(n),Q); 
        
        xf = fixpoint(x(k),Q); %x(k) taken in fixpoint
        
        hf = fixpoint(h(n - k + 1),Q); %x(n-k) taken in fixpoint
        
        xhf = xf*hf; %x(k)*h(n-k) product taken in fixpoint

        xh = xhf/(2^(2*Q)); %x(k)*h(n-k) product converted back  

        xhff = fixpoint(xh,Q); %x(k)*h(n-k)=xh taken in fixpoint   

        yf = yf + (xhff); % This is just /sigma x(k)*h(n-k) done in fixpoint

        y(n) = yf/(2^(Q)); % convolution in fixpoint converted back 
      end
    end
  end
end

function x0 = flip_lr(x)
    l = length(x);
    x0 = zeros(1,l);
    for i = 1:l
        x0(l-i+1) = x(i);
    end
end 

function y1 = fix_xcorrl(x,h) % y1 here is the output
  
  h0=flip_lr(h); %to rearange h(n) as h(-n)
  y1 = fix_convl(x,h0);

end

% cross_correlation

function y1 = float_xcorrl(x,h) % y1 here is the output
  
  h0=fliplr(h); %to rearange h(n) as h(-n)
  y1 = float_convl(x,h0);

end

function result = fixpoint(a, Q)
    result = fix(a * 2^Q);
end

function err = mserr(y_obs,y_acc,n)

err = zeros(1,n);

    for i = 1:n

        err(i) = (y_obs(i) - y_acc(i))^2 ;

    end
    disp('mse is')
    disp(sum((err))/(n));
    

end

