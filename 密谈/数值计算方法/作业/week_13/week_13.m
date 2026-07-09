clear; clc; close all;
addpath('./functions');

M = [3 2 3 4 5 6 7; 11 1 2 3 4 5 6; 2 8 9 1 2 3 4; -4 2 9 11 13 5 8; -1 -2 -3 -1 -1 -1 -1; 3 2 3 4 13 15 8; -2 -2 -3 -4 -5 -3 -3];

mu = 11;
[lambda, v, iter] = findNearEigen(M, mu);
fprintf('Computed Eigenvalue (%d iterations): %.8f\n', iter, lambda);
fprintf('Error of computed eigenpair: %.8e\n', norm(M*v - lambda*v));

eigenvalues = eig(M);
[~, idx] = min(abs(eigenvalues - mu));
fprintf('Nearest Eigenvalue from eig(): %.8f\n', eigenvalues(idx));

fprintf("-------------------------------\n");

[D, iter] = findAllEigenValue(M);
fprintf('Computed Eigenvalues (%d iterations):\n', iter);
disp(D);

eigenvalues = eig(M);
fprintf('Eigenvalues from eig():\n');
disp(eigenvalues);