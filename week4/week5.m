clear variables;
clc
% plaintext = readFile("./plain.txt");
% disp(plaintext);
% original_bit_data = text_to_binary(plaintext);
% disp(original_bit_data);

%% Setting var
SNR_dB = 5;
SNR_linear = 10^(SNR_dB/10); % signal power
M = 4; % 기본적인 이 실험은 QPSK로만 진행할 예정
repeat_time = 7; % fec

%% bit_data 불러오기

plaintext = readFile("./plain.txt");

original_bit_data = text_to_binary(plaintext);
% disp(original_bit_data);

nSymbols = length(original_bit_data); % 전체 비트 개수
nRows = nSymbols/8; % 전체 글자 수
flag = false; % 전체 글자수가 짝수면 false, 홀수면 true

%% 변조
if M == 4
    if mod(nSymbols, 2) ~=0 %글자 수가 홀수라면
        bit_data = [original_bit_data, 0]; %비트배열 맨 뒤에 0 추가
        nSymbols = nSymbols +1; %전체 심볼 수 1 증가
        flag = true; % 전체 글자 수는 홀수라고 flag 값 변경
    else
        bit_data = REP_FEC(original_bit_data, repeat_time);
    end

    modulated_symbol = QPSK_Mapping(bit_data);% QPSK 맵핑
elseif M ==16
elseif M==2

end

%% Transmission System
%r(n) = h(n)* y(n)+z(n)
transmit_power = SNR_linear; % 출력세기(y(n))
h = sqrt(1/2)*(randn(1, length(modulated_symbol))+1j*randn(1, length(modulated_symbol))); %무선채널의 개수(h(n))
transmission_symbol = sqrt(transmit_power)*modulated_symbol;
noise = sqrt(1/2)*(randn(1, length(modulated_symbol))+1j*randn(1, length(modulated_symbol)));

%fading channel
transmission_symbol = transmission_symbol.*h;

%% receive
%equalizer
received_symbol = (transmission_symbol+noise)./h;

FEC_recovered_bit_data = QPSK_DeMapping(received_symbol);
recovered_bit_data = FEC_check(FEC_recovered_bit_data, repeat_time);

if flag
    recovered_bit_data(end) = []; % 전체 글자수가 홀수 였으면 맨 뒤 요소 삭제
    nSymbols = nSymbols -1; %전체 비트수 변경
end


%% 다시 문자로 바꾸기
recovered_data = reshape(recovered_bit_data, 8, []);
recovered_data = recovered_data';

decimalValues = bin2dec(num2str(recovered_data));

%ASCII 코드를 문자로 변환
textString = char(decimalValues)';
disp(textString);


