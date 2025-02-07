%% 실습 1
% functions 파일 참고
%% 실습 2
% functions 파일 참고
%% 실습3-1 16QAM에서 AWGN BER graph
clear all
close all

N = 200000;
SNR = 0:2:20;
BER1 = zeros(size(SNR));
BER2 = zeros(size(SNR));

R2 = 3;

for SNR_loop = 1:length(SNR)

    data_bit = randint(1, N);
    FEC2 = FEC_enc(data_bit, R2);
    symbol1=QAM16_mapper(data_bit);
    symbol2=QAM16_mapper(FEC2);
   

    r1 = AWGN(symbol1, SNR(SNR_loop));
    r2 = AWGN(symbol2, SNR(SNR_loop));
   

    x_bit_1 = QAM16_demapper(r1);
    x_bit_2 = QAM16_demapper(r2);
    


    FEC_dec2 = FEC_dec(x_bit_2, R2);
    
    err_bit_1 = sum(abs(data_bit-x_bit_1));
    err_bit_2 = sum(abs(data_bit-FEC_dec2));

    BER1(SNR_loop)=err_bit_1/N;
    BER2(SNR_loop)=err_bit_2/N;
    
end

title('AWGN BER')
semilogy(SNR, BER1, 'r-')
hold on
semilogy(SNR, BER2, 'b-')
hold on
xlabel('SNR(dB)')
ylabel('BER')
grid on
legend('AWGN, 16QAM without FEC','AWGN, 16QAM with FEC 1/3')
axis([0 20 10^-4 1 ])
%% 실습3-2 16QAM에서 fading chanell BER graph
clear all
close all

N = 200000;
SNR = 0:3:30;
BER1 = zeros(size(SNR));
BER2 = zeros(size(SNR));

R2 = 3;

for SNR_loop = 1:length(SNR)

    data_bit = randint(1, N);
    FEC2 = FEC_enc(data_bit, R2);
    symbol1=QAM16_mapper(data_bit);
    symbol2=QAM16_mapper(FEC2);
   

    r1 = fading(symbol1, SNR(SNR_loop));
    r2 = fading(symbol2, SNR(SNR_loop));
   

    x_bit_1 = QAM16_demapper(r1);
    x_bit_2 = QAM16_demapper(r2);
    


    FEC_dec2 = FEC_dec(x_bit_2, R2);
    
    err_bit_1 = sum(abs(data_bit-x_bit_1));
    err_bit_2 = sum(abs(data_bit-FEC_dec2));

    BER1(SNR_loop)=err_bit_1/N;
    BER2(SNR_loop)=err_bit_2/N;
    
end

title('AWGN BER')
semilogy(SNR, BER1, 'r-')
hold on
semilogy(SNR, BER2, 'b-')
hold on
xlabel('SNR(dB)')
ylabel('BER')
grid on
legend('fading, 16QAM without FEC','fading, 16QAM with FEC 1/3')
axis([0 30 1e-5 1 ])