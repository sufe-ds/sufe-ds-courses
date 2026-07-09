clear; clc; close all;

n = 2000;
A = triu(ones(n)) + eye(n) + diag(1:n) + 2 * diag(ones(n-1,1),-1);

tic;
[Q, R] = HessenQR(A);
A_inv = backSub(R, Q');
toc;

disp("A_inv: ");
disp(A_inv);

err = norm(A_inv * A - eye(n), 'fro');
disp("Verification: norm(A_inv * A - I) = " + err);