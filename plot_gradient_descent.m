addpath('src');

[x, y] = meshgrid(linspace(-3.5, 3.5, 100));

z = mountain_range(x, y);

surf(x, y, z);
hold on;
contour(x, y, z, 30);

alpha = 1.0; % Learning rate

% --- First gradient descent ---
x0 = 1.25; % Initial x
y0 = 1.7; % Initial y
num_iterations = 20;
color = 'r';

function plot_path(x_path, y_path, color)
    path_elevation = 0.1;
    plot3(x_path, y_path, mountain_range(x_path, y_path) + path_elevation, strcat(color, '-'), 'LineWidth', 2); % Path line
    quiver3(...
        x_path(1:end-1), y_path(1:end-1), mountain_range(x_path(1:end-1), y_path(1:end-1)), ...
        x_path(2:end)-x_path(1:end-1), y_path(2:end)-y_path(1:end-1), ...
        mountain_range(x_path(2:end), y_path(2:end))-mountain_range(x_path(1:end-1), y_path(1:end-1)) + path_elevation, ...
        0.5, color, 'LineWidth', 1.5);
end

[x_path, y_path] = perform_gradient_descent(x, y, z, x0, y0, alpha, num_iterations);
plot_path(x_path, y_path, color);


% --- Second gradient descent ---
x0 = 0.9;
y0 = 0.8;
alpha = 1;
num_iterations = 7;
color = 'b';

[x_path, y_path] = perform_gradient_descent(x, y, z, x0, y0, alpha, num_iterations);
plot_path(x_path, y_path, color);

% Disable axes completely
set(gca,'XTick',[], 'YTick', [], 'ZTick', [], 'color', 'none');
axis off;
set(gca, 'LooseInset', get(gca,'TightInset'));

view(-35, 65);

hold off;
