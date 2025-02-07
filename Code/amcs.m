clear variables;
clc;

for i = 1:3
    % 준비
    nSymbol = 1000000;
    SNR_dB = [5, 10, 20];
    SNR_linear = 10^(SNR_dB(i)/10);

    L1 = 1.2;
    L2 = 1.7;

    max = 1000000;
    h = sqrt(1/2)*(randn(1, max)) + 1j*randn(1, max);
    figure(1);
    histogram(abs(h));

    % 실험 시작
    BPSK_count = 0;
    QPSK_count = 0;
    QAM_count = 0;

    BPSK_err_count = 0;
    QPSK_err_count = 0;
    QAM_err_count = 0;

    bit_data = randi([0 1], 1, nSymbol+3);
    recovered_bit_data = zeros(1, nSymbol);
    max = nSymbol;
    h = sqrt(1/2)*(randn(1, max)) + 1j*randn(1, max);
    noise = sqrt(1/2)*(randn(1, max)) + 1j*randn(1, max);

    h_index = 1;
    data_index = 1;

    while true
        if nSymbol < data_index
            break;
        end

        % L1보다 h의 절대값이 작은 경우
        if abs(h(h_index)) <= L1
            data = bit_data(data_index);
            modulated_symbol = BPSK_Mapping(data);
            data_index = data_index + 1;

        % L1과 L2 사이에 있을 경우
        elseif abs(h(h_index)) > L1 && abs(h(h_index)) <= L2
            b_data = zeros(1, 2);
            b_data(1) = bit_data(data_index);
            b_data(2) = bit_data(data_index+1);
            data = QPSK_bit2data(b_data);

            modulated_symbol = QPSK_Mapping(data);
            data_index = data_index + 2;

        % L2보다 큰 경우
        else
            b_data = zeros(1,4);
            b_data(1) = bit_data(data_index);
            b_data(2) = bit_data(data_index+1);
            b_data(3) = bit_data(data_index+2);
            b_data(4) = bit_data(data_index+3);
            data = QAM_bit2data(b_data);
            modulated_symbol = QAM_Mapping(data);
            data_index = data_index + 4;
        end

        % fading
        transmit_power = SNR_linear;
        tmp = modulated_symbol * h(h_index) * sqrt(transmit_power) + noise(h_index);
        received_symbol = tmp / h(h_index);

        % L1보다 h의 절대값이 작은 경우
        if abs(h(h_index)) <= L1
            recovered_data = BPSK_DeMapping(received_symbol);
            BPSK_count = BPSK_count + 1;
            temp = BPSK_data2bit(recovered_data);

            if recovered_data ~= data
                BPSK_err_count = BPSK_err_count + 1;
            end

        % L1과 L2 사이에 있을 경우
        elseif abs(h(h_index)) > L1 && abs(h(h_index)) <= L2
            recovered_data = QPSK_DeMapping(received_symbol);
            QPSK_count = QPSK_count + 1;
            temp = QPSK_data2bit(recovered_data);

            if recovered_data ~= data
                QPSK_err_count = QPSK_err_count + 1;
            end

        % L2보다 큰 경우
        else
            recovered_data = QAM_DeMapping(received_symbol, transmit_power);
            temp = QAM_data2bit(recovered_data);
            QAM_count = QAM_count + 1;

            if recovered_data ~= data
                QAM_err_count = QAM_err_count + 1;
            end
        end

        % 할당하는 부분
        if data_index + length(temp) - 1 > nSymbol
            temp = temp(1:nSymbol - data_index + 1);
        end

        recovered_bit_data(data_index:data_index+length(temp)-1) = temp;
        data_index = data_index + length(temp);
        h_index = h_index + 1;
    end

    bit_data = bit_data(1:nSymbol);
    recovered_bit_data = recovered_bit_data(1:nSymbol);

    % 에러 카운트/사용 카운트
    if i == 1
        fprintf("L1 : %1f\nL2 : % 1f\n", L1, L2);
    end

    fprintf("SNR_dB = %d    BPSK = %f   QPSK = %f   16QAM = %f  AVG = %f\n", ...
        SNR_dB(i), BPSK_err_count/BPSK_count, QPSK_err_count/QPSK_count, QAM_err_count/QAM_count, ...
        (BPSK_err_count + QPSK_err_count + QAM_err_count) / (BPSK_count + QPSK_count + QAM_count));
    % 총 변조시도 횟수
    fprintf(' 1. 총 변조시도 횟수\n');
    fprintf(' BPSK: %d       QPSK : %d       QAM: %d\n', BPSK_count, QPSK_count, QAM_count);
    
    % 총 변조에러 횟수
    fprintf(' 2. 총 변조에러 횟수\n');
    fprintf(' BPSK: %d        QPSK : %d         QAM: %d\n', BPSK_err_count, QPSK_err_count, QAM_err_count);
    
    % 총 성공횟수 = 시도횟수 - 에러횟수 = 총 성공심볼 수
    BPSK_suc_count=BPSK_count-BPSK_err_count;
    QPSK_suc_count=QPSK_count-QPSK_err_count;
    QAM_suc_count=QAM_count-QAM_err_count;
    
    fprintf(' 3. 총 전송성공 심볼 수\n')
    fprintf(' BPSK: %d       QPSK : %d       QAM: %d\n\n',BPSK_suc_count, QPSK_suc_count, QAM_suc_count)
    % 총 성공 bit수
    success_bit_count=BPSK_suc_count+QPSK_suc_count*2+QAM_suc_count*4;
    fprintf('   → 총 전송 성공 bit 수: %d\n', success_bit_count);

end

%% 총 변조시도 횟수
fprintf(' 1. 총 변조시도 횟수\n');
fprintf(' BPSK: %d       QPSK : %d       QAM: %d\n', BPSK_count, QPSK_count, QAM_count);

% 총 변조에러 횟수
fprintf(' 2. 총 변조에러 횟수\n');
fprintf(' BPSK: %d        QPSK : %d         QAM: %d\n', BPSK_err_count, QPSK_err_count, QAM_err_count);

% 총 성공횟수 = 시도횟수 - 에러횟수 = 총 성공심볼 수
BPSK_suc_count=BPSK_count-BPSK_err_count;
QPSK_suc_count=QPSK_count-QPSK_err_count;
QAM_suc_count=QAM_count-QAM_err_count;

fprintf(' 3. 총 전송성공 심볼 수\n')
fprintf(' BPSK: %d       QPSK : %d       QAM: %d\n\n',BPSK_suc_count, QPSK_suc_count, QAM_suc_count)
% 총 성공 bit수
success_bit_count=BPSK_suc_count+QPSK_suc_count*2+QAM_suc_count*4;
fprintf('   → 총 전송 성공 bit 수: %d\n', success_bit_count);


