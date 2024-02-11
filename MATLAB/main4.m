function main4()

x = [0.3426 3.5784 2.7694 -1.3499 3.0349 0.7254 -0.0631];
h = [0.7147 -0.2050 -0.1241 1.4897 1.4090];

disp('convolution x and h is given by');
disp(convl(x,h));

%{
disp('corss-correlation of x and h is given by');
disp(xcorr(x,h));

disp('auto-correlation x is given by');
disp(acorr(x));

disp('auto-correlation h is given by');
disp(acorr(h));
%}
disp('error');
disp(mserr(fixpoint(convl(x,h),12),fixpoint(conv(x,h),12),length(x)+length(h)-1));

end

function y = convl(x,h) % y here is the output

  % Get input sequences
  %x = input('Enter the first sequence x: ');
  %h = input('Enter the second sequence h: ');
  %dont mind the above comments just for testing and debuging
  
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

% cross_correlation

function y1 = xcorr(x,h) % y1 here is the output
  
  h0=flip_lr(h); %to rearange h(n) as h(-n)
  y1 = convl(x,h0);

end

% auto_correlation

function y2 = acorr(x) 
  
  h0=flip_lr(x); %to rearange x(n) as x(-n)
  y2 = convl(x,h0);

end

function result = fixpoint(a, Q)
    result = fix(a * 2^Q);
end

function err = mserr(y_obs,y_acc,n)

err = zeros(1,n);

    for i = 1:n

        err(i) = err(i) + ((y_obs(i) - y_acc(i))^2)/(n) ;

    end

end

