function output = QPSK_mapper(data)
N = length(data);
output = zeros(1, N/2);

for n=1:N/2
    tmp = data(2*n-1:2*n);
    if tmp==[0,0]
        output(n)=sqrt(0.5)*(1+1i);
    elseif tmp==[0,1]
        output(n)=sqrt(0.5)*(-1+1i);
    elseif tmp==[1,1]
        output(n)=sqrt(0.5)*(-1-1i);
    else
        output(n)=sqrt(0.5)*(1-1i);
    end
end
end
