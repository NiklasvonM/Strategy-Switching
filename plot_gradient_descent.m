% Function containing two prominent local minima.
f = @(x, y) (0.2 * x .* (sin(0.2 * x.^2 + 0.5 * x) + 1)) + (0.1 * y.^2 .* sin(y + 0.1 * x.^3) + 1) - 3 * exp(-(1 * x.^2 + 0.5 * y.^2)) - 1.5 * exp(-5 * (2 * (x-1.5).^2 + (y-1).^2)) + 2;

[x, y] = meshgrid(linspace(-3.5, 3.5, 100));

z = f(x, y);

surf(x, y, z);
hold on;
contour(x, y, z, 30);


function [x_path, y_path] = perform_gradient_descent(x, y, z, x0, y0, alpha, num_iterations)
    [dx, dy] = gradient(z);

    % Store path
    x_path = zeros(1, num_iterations);
    y_path = zeros(1, num_iterations);

    % Perform gradient descent
    x_current = x0;
    y_current = y0;
    for i = 1:num_iterations
        x_path(i) = x_current;
        y_path(i) = y_current;

        % Find index of current (x,y) in meshgrid
        [~, ix] = min(abs(x(1,:) - x_current));
        [~, iy] = min(abs(y(:,1) - y_current));

        % Update x and y using gradient descent
        x_current = x_current - alpha * dx(iy, ix);
        y_current = y_current - alpha * dy(iy, ix);
    end
end

function plot_path(x_path, y_path, f, color)
    path_elevation = 0.1;
    plot3(x_path, y_path, f(x_path, y_path) + path_elevation, strcat(color, '-'), 'LineWidth', 2); % Path line
    quiver3(x_path(1:end-1), y_path(1:end-1), f(x_path(1:end-1), y_path(1:end-1)), ...
            x_path(2:end)-x_path(1:end-1), y_path(2:end)-y_path(1:end-1), f(x_path(2:end), y_path(2:end))-f(x_path(1:end-1), y_path(1:end-1)) + path_elevation, ...
            0.5, color, 'LineWidth', 1.5);
end

alpha = 1.0; % Learning rate

% --- First gradient descent ---
x0 = 1.25; % Initial x
y0 = 1.7; % Initial y
num_iterations = 20;
color = 'r';

[x_path, y_path] = perform_gradient_descent(x, y, z, x0, y0, alpha, num_iterations);
plot_path(x_path, y_path, f, color);


% --- Second gradient descent ---
x0 = 0.9;
y0 = 0.8;
alpha = 1;
num_iterations = 7;
color = 'b';

[x_path, y_path] = perform_gradient_descent(x, y, z, x0, y0, alpha, num_iterations);
plot_path(x_path, y_path, f, color);

% Disable axes completely
set(gca,'XTick',[], 'YTick', [], 'ZTick', [], 'color', 'none');
axis off;
set(gca, 'LooseInset', get(gca,'TightInset'));

view(-35, 65);

hold off;
