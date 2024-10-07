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
