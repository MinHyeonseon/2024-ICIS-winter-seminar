function bit_data = BPSK_data2bit(data)
    % Converts BPSK data to a binary vector

    % Ensure that the input is a scalar
    if ~isscalar(data)
        error('Input must be a scalar.');
    end

    % Perform mapping
    if data == 0
        bit_data = 0;
    else
        bit_data = 1;
    end
end

