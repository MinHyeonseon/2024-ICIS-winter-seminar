function data = QAM_bit2data(b_data)
    % QAM16 bit to data mapping function
    % Input: b_data - input bit data for QAM16 demodulation
    % Output: data - demodulated data

    % Map the input bit data to the corresponding decimal value
    decimal_value = b_data(1)*8 + b_data(2)*4 + b_data(3)*2 + b_data(4)*1;

    % Map the decimal value to the corresponding QAM16 data index
    data_mapping = [
        1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
    ];

    % Get the demodulated data from the mapping
    data = data_mapping(decimal_value + 1);
end
