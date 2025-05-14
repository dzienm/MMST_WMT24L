function plot_vf_and_ode_solution(vector_field, ode_solver, dt, numSteps, x_axis, y_axis)
    % Define the grid for the vector field visualization
    [X, Y] = meshgrid(x_axis, y_axis);
    U = zeros(size(X));
    V = zeros(size(X));

    grid_size = size(U);
    for k = 1:grid_size(1)
        for m = 1:grid_size(2)
            vf = vector_field(X(k,m),Y(k,m));
            U(k,m) = vf(1);
            V(k,m) = vf(2);
        end
    end
    

    % Plot the vector field
    figure;
    quiver(X, Y, U, V, 'b'); % Blue arrows for the vector field
    hold on;
    title('Click on the plot to start the solution');
    xlabel('X-axis');
    ylabel('Y-axis');
    grid on;

    while true
        % Wait for user to click on the plot
        [x0, y0, button] = ginput(1);
        
        % Break the loop if the right mouse button is clicked
        if button ~= 1
            break;
        end
        
        % Initial conditions (starting point)
        initialPoint = [x0; y0];
        
        % Solve the differential equation using RK4
        [x, y] = ode_solver(vector_field, initialPoint, dt, numSteps);
        
        % Clear the current axes
        cla;
        
        % Re-plot the vector field
        quiver(X, Y, U, V, 'b'); % Blue arrows for the vector field
        hold on;
        
        % Plot the solution path using RK4
        plot(x, y, 'r'); % Red line for the solution path
        
        %figure(2)
        %t = linspace(dt,(numSteps-1)*dt,numSteps);
        %plot(t,x)
    end

    legend('Vector Field', 'RK4 Solution Path');
end
