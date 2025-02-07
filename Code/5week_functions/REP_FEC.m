function encoded_data = REP_FEC(input_data, repeat_time)
    % REP_FEC: Repetition code for error correction
    
    % Convert input data to binary (if not already)
    if ischar(input_data)
        binary_data = reshape(dec2bin(input_data, 8).' - '0', 1, []);
    elseif isnumeric(input_data)
        binary_data = reshape(dec2bin(input_data, 8).' - '0', 1, []);
    else
        error('Input data must be a binary array, a numeric array, or a character array');
    end
    
    % Repeat each bit 'repeat_time' times
    expanded_data = repmat(binary_data, repeat_time, 1);
    
    % Ensure the length is a multiple of repeat_time
    extra_bits = mod(length(binary_data), repeat_time);
    if extra_bits > 0
        padded_zeros = zeros(1, repeat_time - extra_bits);
        encoded_data = [expanded_data, padded_zeros];
    else
        encoded_data = expanded_data;
    end
end
