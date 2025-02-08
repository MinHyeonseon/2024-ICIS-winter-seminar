function data = QPSK_bit2data(b_data)
    % QPSK bit to data mapping function
    % Input: b_data - input bit data for QPSK demodulation
    % Output: data - demodulated data

    % Validate input length
    if numel(b_data) ~= 2
        error('Input bit data must be a 2-element array.');
    end

    % Map the input bit data to the corresponding QPSK data
    data_mapping = [0, 1, 3, 2];  % Adjusted mapping for QPSK
    index = b_data(1)*2 + b_data(2)*1 + 1;
    data = data_mapping(index);
end
