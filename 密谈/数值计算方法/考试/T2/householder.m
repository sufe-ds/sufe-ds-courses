function [v, beta] = householder(x)
x = x / max(abs(x));
sigma = x(2:end)' * x(2:end);
v = x;
v(1) = 1;
if sigma == 0
    if x(1) >= 0
        beta = 0;
    else
        beta = 2;
    end
else
    alpha = sqrt(x(1)^2 + sigma);
    if x(1) <= 0
        v(1) = x(1) - alpha;
    else
        v(1) = -sigma / (x(1) + alpha);
    end
    beta = 2 * v(1)^2 / (sigma + v(1)^2);
    v = v / v(1);
end
end