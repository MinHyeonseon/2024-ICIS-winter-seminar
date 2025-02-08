function result = func3(input_vector)
    % 입력 벡터의 절반 크기의 벡터 생성
    half_length = length(input_vector) / 2;
    result = input_vector(1:2:end-1) + input_vector(2:2:end);
end
