function [modulated_symbol] = QAM_Mapping(data)
    modulated_symbol = zeros(1, length(data));
    
    modulated_symbol(data == 0) = (-3-3j)/sqrt(10);
    modulated_symbol(data == 1) = (-3-1j)/sqrt(10);
    modulated_symbol(data == 2) = (-3+1j)/sqrt(10);
    modulated_symbol(data == 3) = (-3+3j)/sqrt(10);
    modulated_symbol(data == 4) = (-1+3j)/sqrt(10);
    modulated_symbol(data == 5) = (-1+1j)/sqrt(10);
    modulated_symbol(data == 6) = (-1-1j)/sqrt(10);
    modulated_symbol(data == 7) = (-1-3j)/sqrt(10);
    modulated_symbol(data == 8) = (+1-3j)/sqrt(10);
    modulated_symbol(data == 9) = (1-1j)/sqrt(10);
    modulated_symbol(data == 10) = (1+1j)/sqrt(10);
    modulated_symbol(data == 11) = (1+3j)/sqrt(10);
    modulated_symbol(data == 12) = (3+3j)/sqrt(10);
    modulated_symbol(data == 13) = (3+1j)/sqrt(10);
    modulated_symbol(data == 14) = (3-1j)/sqrt(10);
    modulated_symbol(data == 15) = (3-3j)/sqrt(10);
    

end