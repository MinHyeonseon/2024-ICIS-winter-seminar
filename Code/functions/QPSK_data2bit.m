function b_data = QPSK_data2bit(data)
    % QPSK data to bit mapping function
    % Input: data - demodulated data for QPSK modulation
    % Output: b_data - mapped bit data

    % Check if data values are within the expected range
    if any(data < 0) || any(data > 3)
        error('Invalid data value in QPSK_data2bit.');
    end

    % Convert data to binary representation (2 bits)
    b_data = fliplr(de2bi(data, 2));

    % Ensure that the result has exactly 2 bits
    if numel(b_data) < 2
        b_data = [zeros(1, 2 - numel(b_data)), b_data];
    end
end


% function b_data = QPSK_data2bit(data)
%     % QPSK data to bit mapping function
%     % Input: data - demodulated data for QPSK modulation
%     % Output: b_data - mapped bit data
% 
%     % Define the data mapping for QPSK
%     data_mapping = [0, 1, 3, 2];  % Adjusted mapping for QPSK
% 
%     % Get the mapped bit data directly from the mapping
%     rounded_data = round(data);  % Ensure data is rounded to the nearest integer
%     b_data = fliplr(de2bi(data_mapping(rounded_data + 1) - 1, 2));
% 
%     % Ensure that the result has exactly 2 bits
%     if length(b_data) < 2
%         b_data = [zeros(1, 2 - length(b_data)), b_data];
%     end
% end
