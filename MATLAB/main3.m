
X1 = 3.1425;
X2 = 4.2357;

for Q = 3:12
    pro = fixpt(X1,Q) * fixpt(X2,Q);    
end

disp((pro)/(2^(2*Q)));

function result = fixpt(a,Q)
        result=fix(a*2^Q);
end      