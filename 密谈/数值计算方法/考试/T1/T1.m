clear; clc; close all;

m = 11;
n = 3;
x = (0:m-1)';
X = [sqrt(x), x, ones(m,1)];
y = [0.9; 2.6; 2.7; 3; 2.9; 3; 2.9; 2.8; 2.5; 2.6; 2.2];

Q = eye(m);
for k = 1:n
    [v, beta] = householder(X(k:end, k));
    Hk = eye(m - k + 1) - beta * (v * v');
    X(k:end, k:end) = Hk * X(k:end, k:end);
    Qk = eye(m);
    Qk(k:end, k:end) = Hk;
    Q = Q * Qk;
end
R = X(1:n, :);

disp("Q = ")
disp(Q)
disp("R = ")
disp(R)

Q1 = Q(:, 1:n);
c1 = Q1 \ y;   
res = R \ c1;

a = res(1);
b = res(2);
c = res(3);

disp("a = " + a)
disp("b = " + b)
disp("c = " + c)

r = y - (a * sqrt(x) + b * x + c);
disp("Norm of Residuals = " + norm(r))