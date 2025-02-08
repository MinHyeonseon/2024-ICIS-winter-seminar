function modulated_symbol = QPSK_mapper(data)
    % QPSK mapping function
    % Input: data - input data for QPSK modulation
    % Output: modulated_symbol - QPSK modulated symbol

    % QPSK constellation points
    constellation = [1+1i, -1+1i, -1-1i, 1-1i];

    % Validate input data to be between 0 and 3
    data = mod(data, 4);

    % Map input data to QPSK constellation point
    modulated_symbol = constellation(data + 1);
end


% function output = QPSK_mapper(data)
%     % Maps QPSK data to modulated symbols
% 
%     % Ensure that input is a scalar
%     if ~isscalar(data)
%         error('Input must be a scalar.');
%     end
% 
%     % Define the constellation points for QPSK
%     constellation = [sqrt(0.5)*(1+1i), sqrt(0.5)*(-1+1i), sqrt(0.5)*(-1-1i), sqrt(0.5)*(1-1i)];
% 
%     % Map the data to the corresponding constellation point
%     output = constellation(data + 1);
% end
