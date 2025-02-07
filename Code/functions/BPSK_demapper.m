function data = BPSK_demapper(symbol)
    % Demaps a BPSK symbol to binary data

    % Ensure that the input is a scalar
    if ~isscalar(symbol)
        error('Input must be a scalar.');
    end

    % Perform demapping
    if real(symbol) > 0
        data = 0;
    else
        data = 1;
    end
end
