clear variables;
clc;

%Prepare
% n = rng(10);
for i = 1:3
    nSymbol = 10000; % 비트 수
    SNR_dB = [5, 10, 20]; %SNR값
    SNR_linear = 10^(SNR_dB/10); %Signal Power
    
    L1 = 1.2;  % 
    L2 = 1.7;
    %%% 히스토 그램 그래프 보기
    % max = 10000000;
    % h  = sqrt(1/2) * (randn(1, max)) + 1j*randn(1, max); % h 무선 채널 생성
    % figure(11);
    % histogram(abs(h));
    
    % 실험 시작
    BPSK_count = 0; %BPSK쓴 개수
    QPSK_count = 0; %QPSK쓴 개수
    QAM_count = 0; %16QAM쓴 개수
    
    BPSK_err_count = 0; %BPSK 로 왔을 때 오류 수
    QPSK_err_count = 0; %QPSK로 왔을 떄 오류수
    QAM_err_count = 0; %16QAM으로 왔을 때 오류수
    
    
    bit_data = randi([0 1], 1, nSymbol+3); % nSymbol+3 만큼 비트 생성 (만약 비트수가 9999개까지 왔을 때, 다음에 최대로 사용할 수 있는 비트수 4개 해서 nSymbol + 3개
    recovered_bit_data = zeros(1, 0); % 수신받은 비트  저장하는 배열
    max = nSymbol;
    h  = sqrt(1/2) * (randn(1, max)) + 1j*randn(1, max); % h 무선 채널 생성
    noise = sqrt(1/2)*(randn(1,max) +1j*randn(1, max) ); % 노이즈 생성
    
    h_index = 1; % h 무선채널 인덱스
    data_index = 1; % 데이터 인덱스

    while true
        if nSymbol < data_index % while 문 종료 조건 : nSymbol 개수 만큼 다 사용했을 때
            break;
        end
        
        %L1보다 h의 절대값이 작은 경우
        if abs(h(h_index)) <= L1 % -> BPSK로 설정
            data = bit_data(data_index);
            modulated_symbol = BPSK_Mapping(data);
            data_index = data_index+1;
            
        %L1과 L2 사이에 있을 경우   
        elseif abs(h(h_index)) > L1 && abs(h(h_index)) <=L2
            b_data = zeros(1, 2);
            b_data(1) = bit_data(data_index);
            b_data(2) = bit_data(data_index+1);
            data = QPSK_bit2data(b_data);
            
            modulated_symbol = QPSK_Mapping(data);
            data_index = data_index+2;
    
        %L2보다 큰 경우
        else
            b_data = zeros(1, 4);
            b_data(1) = bit_data(data_index);
            b_data(2) = bit_data(data_index+1);
            b_data(3) = bit_data(data_index+2);
            b_data(4) = bit_data(data_index+3);
            data = QAM_bit2data(b_data);
            modulated_symbol = QAM_Mapping(data);
            data_index = data_index+4;
        end
    
        % fading
        transmit_power = SNR_linear;
        tmp= modulated_symbol * h(h_index) * sqrt(transmit_power) + noise(h_index);
        received_symbol = tmp/h(h_index);
        
    
    
        %L1보다 h의 절대값이 작은 경우
        if abs(h(h_index)) <= L1 % -> BPSK로 설정
            recovered_data = BPSK_DeMapping(received_symbol);
            BPSK_count =  BPSK_count+1;
            temp = BPSK_data2bit(recovered_data);
    
            if recovered_data ~=data
                BPSK_err_count = BPSK_err_count+1;
            end
            
        %L1과 L2 사이에 있을 경우   
        elseif abs(h(h_index)) > L1 && abs(h(h_index)) <=L2
            recovered_data = QPSK_DeMapping(received_symbol);
            QPSK_count = QPSK_count+1;
            temp = QPSK_data2bit(recovered_data);
            if recovered_data ~=data
                QPSK_err_count = QPSK_err_count+1;
            end
    
        %L2보다 큰 경우
        else
            recovered_data= QAM_DeMapping(received_symbol, transmit_power);
            temp = QAM_data2bit(recovered_data);
            QAM_count = QAM_count+1;
            if recovered_data ~=data
                QAM_err_count = QAM_err_count+1;
            end
    
        end
        recovered_bit_data = cat(2, recovered_bit_data, temp);
        h_index = h_index+1;
    end
    
    bit_data = bit_data(1:nSymbol);
    recovered_bit_data= recovered_bit_data(1:nSymbol);


% disp(["SNR_dB = ", num2str(SNR_dB), "BPSK = ", num2str(BPSK_err_count/BPSK_count), ...
%     "QPSK = ", num2str(QPSK_err_count/QPSK_count), "16QAM = ", num2str(QAM_err_count/QAM_count), ...
%     "AVG = " , num2str((BPSK_err_count + QPSK_err_count + QAM_err_count) / (BPSK_count + QPSK_count + QAM_count))] );
% 에러 카운트/사용 카운트
    if i == 1
        fprintf("L1 : %1f\nL2 : % 1f\n", L1, L2);
    end
    fprintf("SNR_dB = %d    BPSK = %f   QPSK = %f   16QAM = %f  AVG = %f\n", ...
            SNR_dB(i), BPSK_err_count/BPSK_count, QPSK_err_count/QPSK_count, QAM_err_count/QAM_count, ...
            (BPSK_err_count + QPSK_err_count + QAM_err_count) / (BPSK_count + QPSK_count + QAM_count));

end





% %% Repeation FEC
% function [Repeat_bit_data]  = REP_FEC(bit_data, Repeat_time)
%     Repeat_bit_data = repmat(bit_data, 1, Repeat_time);
% end
% 
% function [bit_data] = FEC_check(Repeat_bit_data, Repeat_time)
%     bit_data = zeros(1, length(Repeat_bit_data/Repeat_time));
%     for i = 1:nSymbol
%         s = 0;
%         for j  = 1:Repeat_time
%             s = s + Repeat__bit_data(nSymbol*(j-1)+i);    
%         end
%         bit_data(i) = round((s/Repeat_time));
%     end
% 
% end