% Function containing two prominent local minima.
function f = mountain_range(x, y) 
    f = (0.2 * x .* (sin(0.2 * x.^2 + 0.5 * x) + 1)) ...
    + (0.1 * y.^2 .* sin(y + 0.1 * x.^3) + 1) ...
    - 3 * exp(-(1 * x.^2 + 0.5 * y.^2)) ... % Deep local minimum at (0, 0)
    - 1.5 * exp(-5 * (2 * (x-1.5).^2 + (y-1).^2)) ... % Shallow local minimum at (1.5, 1)
    + 2;
end;
