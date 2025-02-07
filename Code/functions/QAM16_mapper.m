function modulated_symbol = QAM16_mapper(data)
    % QAM16 mapping function
    % Input: data - input data for QAM16 modulation
    % Output: modulated_symbol - QAM16 modulated symbol

    % QAM16 constellation points
    constellation = [
        -3-3i, -3-1i, -3+3i, -3+1i;
        -1-3i, -1-1i, -1+3i, -1+1i;
         3-3i,  3-1i,  3+3i,  3+1i;
         1-3i,  1-1i,  1+3i,  1+1i
    ];

    % Limit data to be between 0 and 15
    data = mod(data, 16);

    % Map input data to QAM16 constellation point
    modulated_symbol = constellation(data + 1);
end
