function b_data = QAM_data2bit(data)
    % QAM16 data to bit mapping function
    % Input: data - demodulated data for QAM16 modulation
    % Output: b_data - mapped bit data

    % Define the data mapping for QAM16
    data_mapping = [
        1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
    ];

    % Find the index of the input data in the mapping
    index = find(data_mapping == data);

    % Check if the index is valid
    if isempty(index) || numel(index) ~= 1
        error('Invalid data value in QAM_data2bit.');
    end

    % Convert the index to binary representation (4 bits)
    b_data = fliplr(de2bi(index - 1, 4));

    % Ensure that the result has exactly 4 bits
    if numel(b_data) < 4
        b_data = [zeros(1, 4 - numel(b_data)), b_data];
    end
end


% function b_data = QAM_data2bit(data)
%     % QAM16 data to bit mapping function
%     % Input: data - demodulated data for QAM16 modulation
%     % Output: b_data - mapped bit data
% 
%     % Define the data mapping for QAM16
%     data_mapping = [
%         1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
%     ];
% 
%     % Find the index of the input data in the mapping
%     index = find(data_mapping == data);
% 
%     % Convert the index to binary representation (4 bits)
%     b_data = fliplr(de2bi(index - 1, 4));
% 
%     % Ensure that the result has exactly 4 bits
%     if length(b_data) < 4
%         b_data = [zeros(1, 4 - length(b_data)), b_data];
%     end
% end
