
function X = backSub(U, B)
% n = size(U, 1);
% m = size(B, 2);
% X = zeros(n, m);
% for i = n:-1:1
%     X(i, :) = (B(i, :) - U(i, i+1:n) * X(i+1:n, :)) / U(i, i);
% end
X= linsolve(U, B, struct('UT', true)); % 真没招了，自己写的回代法太慢了
end
