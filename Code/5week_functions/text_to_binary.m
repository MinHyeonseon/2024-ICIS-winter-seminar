function binaryNumArray = text_to_binary(textString)

    %문자열의 각 문자를 ASCII 코드 값으로 변환
    asciiValues = double(textString);

    %ASCII 코드 값을 2진수로 변환
    binaryStrings = dec2bin(asciiValues, 8);

    %문자 배열을 숫자 배열로 변환
    binaryNumArray = binaryStrings - '0';

    %nXm 배열을 1xm*n 배열로 변환
    binaryNumArray = reshape(binaryNumArray', 1, []);
end