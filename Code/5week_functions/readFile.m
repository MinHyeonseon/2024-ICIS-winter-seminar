function textString = readFile(filename)
    fileID = fopen(filename, 'r');
    textString = fread(fileID, '*char')'; % 전체 파일 내용을 문자열로 읽기
    fclose(fileID);
end

