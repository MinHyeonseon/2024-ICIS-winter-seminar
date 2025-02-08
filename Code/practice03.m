%% 실습 1
%equalizer output
clear all;
close all;

N = 1000;
SNR = 10;
x = randint(1,N);
y = QPSK_mapper(x);
r = fading(y, SNR);

plot(r, '.');
title('Equalizer Output');
axis([-1.5 1.5 -1.5 1.5]);

%% 실습 2

clc
clear;
close all;

SNR_dB = 0:1:20; % 시뮬레이션할 SNR(dB) 범위
SNR = 10.^(SNR_dB/10); % SNR(dB)를 선형 스케일로 변환

% AWGN Channel
N = 100000;
AWGN_BER = zeros(size(SNR)); % AWGN 채널의 BER 초기화

for i = 1:length(SNR_dB)
    x = randint(1, N);
    y = QPSK_mapper(x);
    r = AWGN(y, SNR(i));
    x_hat = QPSK_demapper(r);
    
    % 비트 오류 계산
    numErrors = sum(x(:) ~= x_hat(:)); % 오류 비트 수
    AWGN_BER(i) = numErrors / (N * 1); % 비트 에러율 계산
end

% Fading Channel
N = 100000;

Fading_BER = zeros(size(SNR)); % Fading 채널의 BER 초기화

for i = 1:length(SNR_dB)
    x = randint(1, N);
    y = QPSK_mapper(x);
    r = fading(y, SNR(i));
    x_hat = QPSK_demapper(r);
    numErrors = sum(x(:) ~= x_hat(:));
    Fading_BER(i) = numErrors / N;
end

% 그래프 그리기
semilogy(SNR_dB, AWGN_BER, 'r-', 'DisplayName', 'AWGN Channel');
hold on;
semilogy(SNR_dB, Fading_BER, 'b-', 'DisplayName', 'Fading Channel');
title('BER Curve');
axis([0 20 10^-4 10^0]);
xlabel('SNR (dB)');
ylabel('BER');
grid on;
legend;

%% 실습 3-1 
% 함수는 functions 파일 참고
clc
clear
close all
x = [1, 0, 0, 1, 1, 1, 1, 1, 0];
R = 3;

y = FEC_dec(x, R);
disp(y);

%% 실습 3-2
% 함수는 functions 파일 참고
clc
clear
close all
x = [1, 0, 0, 1, 1, 1, 1, 1, 0];
R = 3;

y = FEC_enc(x, R);
disp(y);


%% 실습 4
% Fading 채널 BER 비교
clear
close all

N = 200000;
SNR = 0:2:20;
BER1 = zeros(size(SNR));
BER2 = zeros(size(SNR));
BER3 = zeros(size(SNR));

R2 = 3;
R3 = 5;
for SNR_loop = 1:length(SNR)

    data_bit = randint(1, N);
    FEC2 = FEC_enc(data_bit, R2);
    FEC3 = FEC_enc(data_bit, R3);
    QPSK_symbol1 = QPSK_mapper(data_bit);
    QPSK_symbol2 = QPSK_mapper(FEC2);
    QPSK_symbol3 = QPSK_mapper(FEC3);

    r1 = fading(QPSK_symbol1, SNR(SNR_loop));
    r2 = fading(QPSK_symbol2, SNR(SNR_loop));
    r3 = fading(QPSK_symbol3, SNR(SNR_loop));

    x_bit_1 = QPSK_demapper(r1);
    x_bit_2 = QPSK_demapper(r2);
    x_bit_3 = QPSK_demapper(r3);


    FEC_dec2 = FEC_dec(x_bit_2, R2);
    FEC_dec3 = FEC_dec(x_bit_3, R3);

    err_bit_1 = sum(abs(data_bit-x_bit_1));
    err_bit_2 = sum(abs(data_bit-FEC_dec2));
    err_bit_3 = sum(abs(data_bit-FEC_dec3));

    BER1(SNR_loop)=err_bit_1/N;
    BER2(SNR_loop)=err_bit_2/N;
    BER3(SNR_loop)=err_bit_3/N;
end

semilogy(SNR, BER1, 'r-')
hold on
semilogy(SNR, BER2, 'b-')
hold on
semilogy(SNR, BER3, 'g-')
xlabel('SNR(dB)')
ylabel('BER')
grid on
legend('fading without FEC','fading FEC R=3','fading FEC R=5')
axis([0 20 1e-4 1 ])
