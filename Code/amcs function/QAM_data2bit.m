function [bit_data] = QAM_data2bit(data)
 bit_data = zeros(1, length(data)*4);
    for i = 1:length(data)
        data_value = data(i);
        % recovered_data(i) 값에 따라서 recovered_bit_data 배열에 적절한 값 할당
        switch data_value
            case 0
                bit_data(4*i - 3) = 0;
                bit_data(4*i - 2) = 0;
                bit_data(4*i - 1) = 0;
                bit_data(4*i) = 0;
            case 1
                bit_data(4*i - 3) = 0;
                bit_data(4*i - 2) = 0;
                bit_data(4*i - 1) = 0;
                bit_data(4*i) = 1;
            case 2
                bit_data(4*i - 3) = 0;
                bit_data(4*i - 2) = 0;
                bit_data(4*i - 1) = 1;
                bit_data(4*i) = 1;
            case 3
                bit_data(4*i - 3) = 0;
                bit_data(4*i - 2) = 0;
                bit_data(4*i - 1) = 1;
                bit_data(4*i) = 0;
            case 4
                bit_data(4*i - 3) = 0;
                bit_data(4*i - 2) = 1;
                bit_data(4*i - 1) = 1;
                bit_data(4*i) = 0;
            case 5
                bit_data(4*i - 3) = 0;
                bit_data(4*i - 2) = 1;
                bit_data(4*i - 1) = 1;
                bit_data(4*i) = 1;
            case 6
                bit_data(4*i - 3) = 0;
                bit_data(4*i - 2) = 1;
                bit_data(4*i - 1) = 0;
                bit_data(4*i) = 1;
    
            case 7
                bit_data(4*i - 3) = 0;
                bit_data(4*i - 2) = 1;
                bit_data(4*i - 1) = 0;
                bit_data(4*i) = 0;
            case 8
                bit_data(4*i - 3) = 1;
                bit_data(4*i - 2) = 1;
                bit_data(4*i - 1) = 0;
                bit_data(4*i) = 0;
            case 9
                bit_data(4*i - 3) = 1;
                bit_data(4*i - 2) = 1;
                bit_data(4*i - 1) = 0;
                bit_data(4*i) = 1;
            case 10
                bit_data(4*i - 3) = 1;
                bit_data(4*i - 2) = 1;
                bit_data(4*i - 1) = 1;
                bit_data(4*i) = 1;
            case 11
                bit_data(4*i - 3) = 1;
                bit_data(4*i - 2) = 1;
                bit_data(4*i - 1) = 1;
                bit_data(4*i) = 0;
            case 12
                bit_data(4*i - 3) = 1;
                bit_data(4*i - 2) = 0;
                bit_data(4*i - 1) = 1;
                bit_data(4*i) = 0;
            case 13
                bit_data(4*i - 3) = 1;
                bit_data(4*i - 2) = 0;
                bit_data(4*i - 1) = 1;
                bit_data(4*i) = 1;
            case 14
                bit_data(4*i - 3) = 1;
                bit_data(4*i - 2) = 0;
                bit_data(4*i - 1) = 0;
                bit_data(4*i) = 1;
            case 15
                bit_data(4*i - 3) = 1;
                bit_data(4*i - 2) = 0;
                bit_data(4*i - 1) = 0;
                bit_data(4*i) = 0;
    
            otherwise
                error('Unexpected data value.');
        end
    end
end