clear variables;
clc;

for i = 1:3
    % 준비
    nSymbol = 10000; % 비트 수
    SNR_dB = [5, 10, 20]; % SNR 값
    SNR_linear = 10^(SNR_dB(i)/10); % 신호 전력

    L1 = 1.2;
    L2 = 1.7;

    % 히스토그램 그래프 보기
    max = 1000000;
    h = sqrt(1/2)*(randn(1, max)) + 1j*randn(1, max); % 무선 채널 생성
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
    recovered_bit_data = zeros(1, nSymbol);  % 초기 크기를 nSymbol로 설정
    max = nSymbol;
    h = sqrt(1/2)*(randn(1, max)) + 1j*randn(1, max); % 무선 채널 생성
    noise = sqrt(1/2)*(randn(1, max)) + 1j*randn(1, max); % 노이즈 생성

    h_index = 1;
    data_index = 1;

    while true
        if nSymbol < data_index
            break;
        end

        if abs(h(h_index)) <= L1
            data = bit_data(data_index);
            modulated_symbol = BPSK_mapper(data);
            data_index = data_index + 1;

        elseif abs(h(h_index)) > L1 && abs(h(h_index)) <= L2
            b_data = zeros(1, 2);
            b_data(1) = bit_data(data_index);
            b_data(2) = bit_data(data_index + 1);
            data = QPSK_bit2data(b_data);
            modulated_symbol = QPSK_mapper(data);
            data_index = data_index + 2;

        else
            b_data = zeros(1, 4);
            b_data(1) = bit_data(data_index);
            b_data(2) = bit_data(data_index + 1);
            b_data(3) = bit_data(data_index + 2);
            b_data(4) = bit_data(data_index + 3);
            data = QAM_bit2data(b_data);
            modulated_symbol = QAM16_mapper(data);
            data_index = data_index + 4;
        end

        transmit_power = SNR_linear;
        tmp = modulated_symbol * h(h_index) * sqrt(transmit_power) + noise(h_index);
        received_symbol = tmp / h(h_index);

        if abs(h(h_index)) <= L1
            recovered_data = BPSK_demapper(received_symbol);
            BPSK_count = BPSK_count + 1;
            temp = BPSK_data2bit(recovered_data);

            if recovered_data ~= data
                BPSK_err_count = BPSK_err_count + 1;
            end

        elseif abs(h(h_index)) > L1 && abs(h(h_index)) <= L2
            recovered_data = QPSK_demapper(received_symbol);
            QPSK_count = QPSK_count + 1;
            temp = QPSK_data2bit(recovered_data);

            if recovered_data ~= data
                QPSK_err_count = QPSK_err_count + 1;
            end

        else
            recovered_data = QAM16_demapper(received_symbol);
            temp = QAM_data2bit(recovered_data);
            QAM_count = QAM_count + 1;

            if recovered_data ~= data
                QAM_err_count = QAM_err_count + 1;
            end
        end

        % 데이터 저장
        recovered_bit_data(data_index : data_index + numel(temp) - 1) = temp;
        data_index = data_index + numel(temp);
        
        h_index = h_index + 1;
    end

    recovered_bit_data = recovered_bit_data(1:nSymbol);

    % 오류 횟수 및 사용 횟수
    if i == 1
        fprintf("L1 : %1f\nL2 : % 1f\n", L1, L2);
    end
    fprintf("SNR_dB = %d    BPSK = %f   QPSK = %f   16QAM = %f  AVG = %f\n", ...
        SNR_dB(i), BPSK_err_count/BPSK_count, QPSK_err_count/QPSK_count, QAM_err_count/QAM_count, ...
        (BPSK_err_count + QPSK_err_count + QAM_err_count) / (BPSK_count + QPSK_count + QAM_count));
end
