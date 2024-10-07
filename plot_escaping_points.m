addpath('src');

% Idea: Color the point based on whether or not the gradient is closer to (x0, y0) than itself.

[x_grid, y_grid] = meshgrid(linspace(-3.5, 3.5, 100));

z_grid = mountain_range(x_grid, y_grid);

surf(x_grid, y_grid, z_grid);
hold on;
contour(x_grid, y_grid, z_grid, 30);

x0 = 1.5;
y0 = 1;
radius = 0.5; % Radius of circle around (x0, y0)
plot3(x0, y0, mountain_range(x0, y0) + 0.1, 'b.', 'MarkerSize', 30);

x = [];
y = [];
z = [];

number_points_on_circle = 100;
% Get (x, y) pairs in a circle around (x0, y0) and compute and plot their z values using mountain_range
for theta = linspace(0, 2*pi, number_points_on_circle)
    x = [x, x0 + cos(theta) * radius];
    y = [y, y0 + sin(theta) * radius];
    z = [z, mountain_range(x(end), y(end))];
end
plot3(x, y, z, 'black', 'LineWidth', 5);

gradient_scaling_factor = 0.25;
path_length = 20;
% Draw the negative gradient for each point in the circle. Normalize the path to be of constant length 1.
for i = 1:number_points_on_circle
    x_start = x(i);
    y_start = y(i);
    [x_path_gradient_initial, y_path_gradient_initial] = perform_gradient_descent(x_grid, y_grid, z_grid, x_start, y_start, 1.0, 2);
    x_end = x_path_gradient_initial(end); % We're only interested in the last point
    y_end = y_path_gradient_initial(end);
    % Normalize length
    x_direction_normed = (x_end - x_start) / norm([x_end - x_start, y_end - y_start]);
    y_direction_normed = (y_end - y_start) / norm([x_end - x_start, y_end - y_start]);
    x_end_normed = x_start + x_direction_normed * gradient_scaling_factor;
    y_end_normed = y_start + y_direction_normed * gradient_scaling_factor;
    % plot a smooth path from (x_start, y_start) to (x_end_normed, y_end_normed);
    x_path = linspace(x_start, x_end_normed, path_length);
    y_path = linspace(y_start, y_end_normed, path_length);
    z_path = mountain_range(x_path, y_path);
    % Color red if the gradient is closer to the point than the point itself, otherwise yellow
    if norm([x_end_normed - x0, y_end_normed - y0]) < norm([x_start - x0, y_start - y0])
        color = 'r';
    else
        color = 'y';
    end
    plot3(x_path, y_path, z_path, color, 'LineWidth', 2);
end

% Disable axes completely
set(gca,'XTick',[], 'YTick', [], 'ZTick', [], 'color', 'none');
axis off;
set(gca, 'LooseInset', get(gca,'TightInset'));

view(-35, 65);

hold off;
