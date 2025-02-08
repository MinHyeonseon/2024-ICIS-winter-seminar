function x_hat = QPSK_demapper(r)
    L = length(r);
   
    x_hat = zeros(1, 2*L);
    for n = 1:L
        if real(r(n)) >= 0 && imag(r(n)) >= 0
            x_hat(2*(n-1)+1:2*n) = [0 0];
        elseif real(r(n)) < 0 && imag(r(n)) >= 0
            x_hat(2*(n-1)+1:2*n) = [0 1];
        elseif real(r(n)) < 0 && imag(r(n)) < 0
            x_hat(2*(n-1)+1:2*n) = [1 1];
        else
            x_hat(2*(n-1)+1:2*n) = [1 0];
        end
    end
end
