function output = BPSK_mapper(data)
    N = length(data);
    output = zeros(1, N);

    for n = 1:N
        if data(n) == 0
            output(n) = sqrt(0.5) * (1 + 1i);
        else
            output(n) = sqrt(0.5) * (-1 + 1i);
        end
    end
end