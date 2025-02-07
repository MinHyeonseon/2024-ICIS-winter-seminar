function corrected_data = FEC_check(input_data, repeat_time)
    % FEC_check: Error checking and correction using repetition code
    
    % Convert input data to binary (if not already)
    if ischar(input_data)
        binary_data = reshape(dec2bin(input_data, 8).' - '0', 1, []);
    elseif isnumeric(input_data)
        binary_data = reshape(dec2bin(input_data, 8).' - '0', 1, []);
    elseif islogical(input_data)
        binary_data = input_data;
    else
        error('Input data must be a binary array, a numeric array, or a character array');
    end
    
    % Reshape the binary data into a matrix with each row representing a repeated block
    reshaped_data = reshape(binary_data, repeat_time, []);
    
    % Sum along each column to count the number of 1s in each block
    sum_per_block = sum(reshaped_data);
    
    % Set the corrected data based on majority voting
    corrected_data = sum_per_block >= repeat_time / 2;
    
    % Reshape back to a single row
    corrected_data = reshape(corrected_data, 1, []);
end
