clear; clc; close all;

addpath('./functions');

function [A] = makeMatrix(a)
n = length(a);
A = zeros(n, n);
A(:, end) = -a;
A(2:end, 1:end-1) = eye(n-1);
end

a1 = [3, -5, 1];
a2 = [-1, -3, 0];
a3 = [-1000, 790, -99902, 79108.9, 9802.08, 10891.01, 208.01, 101];

[maxRoot1, iter1] = findMaxEigenvalue(makeMatrix(a1));
[maxRoot2, iter2] = findMaxEigenvalue(makeMatrix(a2));
[maxRoot3, iter3] = findMaxEigenvalue(makeMatrix(a3));

fprintf('Max Root for poly 1: %.8f in %d iterations\n', maxRoot1, iter1);
fprintf('Max Root for poly 2: %.8f in %d iterations\n', maxRoot2, iter2);
fprintf('Max Root for poly 3: %.8f in %d iterations\n', maxRoot3, iter3);