clear; clc; close all;

A = [
    3 -6 6 -6 6 -6 -9 9 -9 15;
    5 -8 8 -8 8 -8 -5 8 -5 13;
    7 -7 7 -4 4 -4 -7 7 -7 11;
    3 -3 3 0 6 -6 -3 3 -3 9;
    5 -5 5 -5 11 -2 -5 5 -5 7;
    -5 5 -5 5 -5 14 -1 1 5 -1;
    -3 3 -3 3 -3 3 12 3 3 -3;
    -1 1 -1 1 -1 1 -2 17 1 1;
    -8 8 -8 8 -8 8 -16 16 2 8;
    -2 2 -2 2 -2 2 -4 4 22 14
];

eig_values = findAllEigenValue(A);
disp("Eigenvalues:");
disp(eig_values);

eig_vetors = zeros(size(A,1), size(eig_values,1));
for i = 1:length(eig_values)
    [lambda, v, ~] = findNearEigen(A, eig_values(i));
    eig_values(i) = lambda;
    eig_vetors(:, i) = v;
end
disp("Eigenvectors:");
disp(eig_vetors);

err = norm(A * eig_vetors - eig_vetors * diag(eig_values));
disp("Verification: norm(A * v - lambda * v) = " + err);