function [c, s] = givens(a, b)
if b == 0
    if a >= 0
        c = 1; s = 0;
    else
        c = -1; s = 0;
    end
else
    if abs(b) > abs(a)
        r = a / b;
        s = sign(b) / sqrt(1 + r^2);
        c = s * r;
    else
        r = b / a;
        c = sign(a) / sqrt(1 + r^2);
        s = c * r;
    end
end
end
