clear variables;
clc;

%Prepare
max = 1000000; % h의 최대 범위

M = 16; % M=4이면 QPSK, M=16이면 16QAM

nSymbol = 10000; %비트 수
SNR_dB = 20; %SNR 값
SNR_linear = 10^(SNR_dB/10); % Signal Power

test_time = 10; % 실험 반복 횟수
count_average = zeros(1, length(test_time)); % 각 실험마다 재전송이 일어난 횟수를 기록하는 배열 변수

%실험 시작

%test_time만큼 반복
for i = 1: test_time
    bit_data = randi([0 1], 1, nSymbol); % nSymbol 만큼 비트 생성
    h = sqrt(1/2)*(randn(1, max))+ 1j*randn(1, max); % h 무선 채널 생성
    noise = sqrt(1/2)*(randn(1, max) +1j*randn(1, max)); % 노이즈 생성

    %bit_data의 비트를 일정한 개수만큼 쪼개서 숫자로 변환 ex) 0 0 1 1 -> 3 후 Mapping
    if M==2
        data = BPSK_bit2data(bit_data);
        modulated_symbol = BPSK_mapping(data);
    elseif M==4
        data = QPSK_bit2data(bit_data);
        modulated_symbol = QPSK_Mapping(data);
    elseif M==16
        data = QAM_bit2data(bit_data);
        modulated_symbol = QAM_Mapping(data);
    end

    count_time = zeros(1, length(modulated_symbol)); % 심볼에 따른 재전송 횟수
    transmit_power = SNR_linear; %전송 출력

    data_index = 1; % 데이터 인덱스
    h_index = 1; % 무선 채널 인덱스

    count = 0;
    received_symbol = zeros(1, length(modulated_symbol));
    recovered_data = zeros(count, length(modulated_symbol));

    while true
        % 보낼 비트를 전부 보냈으면 while문 탈출
        if data_index>length(modulated_symbol)
            break;
        end

        if M==4
            tmp = modulated_symbol(data_index)*h(h_index)* sqrt(transmit_power)+noise(h_index);
            received_symbol(data_index) = tmp/h(h_index); % 페이딩 데이터 복구
            recovered_data(data_index) = QPSK_DeMapping(received_symbol(data_index)); %QPSK로 디매핑

            %받은 값과 보낸 값이 다르다면 재전송 요구, 채널값 +1
            if recovered_data(data_index) ~= data(data_index)
                h_index = h_index+1;
                count = count +1;
                % 받은 값과 보낸 값이 같다면, 다음 비트 전송
            else
                count_time(data_index) = count;
                data_index = data_index+1;
                h_index = h_index+1;
                count = 0;
            end

        elseif M==16
            tmp = modulated_symbol(data_index)*h(h_index)* sqrt(transmit_power)+noise(h_index);
            received_symbol(data_index) = tmp/h(h_index); % 페이딩 데이터 복구
            recovered_data(data_index) = QAM_DeMapping(received_symbol(data_index), transmit_power); %16QAM으로 디매핑
            % 받은 값과 보낸 값이 다르다면, 재전송 요구, 채널값 +1
            if recovered_data(data_index) ~= data(data_index)
                h_index = h_index+1;
                count = count+1;
            % 받은 값과 보낸 값이 같다면, 다음 비트 전송
            else
                count_time(data_index) = count;
                data_index = data_index+1;
                h_index = h_index+1;
                count = 0;
            end
        end
    end
    count_average(i) = sum(count_time);
end

average = sum(count_average)/test_time; % test_time 개수로 나눠버리면 평균이 된다.
disp(count_average);
disp(average);


