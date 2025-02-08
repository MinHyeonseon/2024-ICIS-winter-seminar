%% 실습 1
%functions 파일 참고

%% 실습 2, 3, 4
%functions 파일 참고
%BER Curve for AWGN Channel
clc;
clear;

N = 1000000; 
M = 1; 
SNR_dB = 1:1:11; % 시뮬레이션할 SNR(dB) 범위
SNR = 10.^(SNR_dB/10); % SNR(dB)를 선형 스케일로 변환

BER = zeros(size(SNR)); % BER 초기화

for i = 1:length(SNR_dB)
    x = randint(1, N);
    y = QPSK_mapper(x);
    r = AWGN(y, SNR(i));
    x_hat = QPSK_demapper(r);
    
    % 비트 오류 계산
    numErrors = sum(x(:) ~= x_hat(:)); % 오류 비트 수
    BER(i) = numErrors / (N * 1); % 비트 에러율 계산
end

% BER 곡선 플롯
semilogy(SNR_dB, BER, 'bo-');
title('BER Curve');
xlabel('SNR(dB)');
ylabel('BER');
grid on;