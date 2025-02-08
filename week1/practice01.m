%% 실습 1
A = [-1 4 16 1 26; 7 8 11 12 -7;
    10 9 5 15 -8; 2 1 6 24 22; 3 0 2 20 13];

B = A(2:4, 2:4);

C = inv(B);

D = B * C;

disp('A:');
disp(A);

disp('B:');
disp(B);

disp('C (Inverse of B):');
disp(C);

disp('D (B x C):');
disp(D);
%% 35p
t = 0:0.01:2*pi;
y = sin(t);
plot(t, y)
grid on
xlabel('t (sec)')
ylabel('y')
title('Test 1')
y1 = cos(t);
hold on
plot(t, y1, 'r')
axis([0 2*pi -1.5 1.5])
legend('sin(t)', 'cos(t)')
%% 실습 2
x = 0.01:0.01:2; 
y = exp(x); 
plot(x, y, 'r')
grid on 
xlabel('x'); 
ylabel('y'); 
title('practice2'); 
z = log(x);
hold on
plot(x, z, 'g')
axis([0.01 2 -10 10]) 
legend('exp(x)', 'log(x)')
%% 실습 3
clear;
clc;
a = 1;
for n = 2:2:20
    a = a*n;
end

%% 실습 4
clear;
clc;
a = rand(20,1);
b = zeros(5, 1);
for n = 1:5
    b(n) = sum(a(4*n-3:4*n));
end
%% 실습 5
clear;
clc;
a = rand(1);
if a>=0.5
    fprintf('high');
elseif a<0.5
    fprintf('low');
end
%% 실습 6
% funtions 파일 참고

%% 실습 7
clc
clear
x = [1 2 3 4 5];
y = fun1(x);
disp(y);

%% 실습 8
clc
clear

x = [1 2 3];
y = func2(x);

disp(y);
%% 실습 9
clc
clear

x = [1 2 3 4 5 6];
y = func3(x);

disp(y);
%% 실습 10
clc
clear

x = [pi/4 -pi/2 pi -pi/3];
y = func4(x);

disp(y);