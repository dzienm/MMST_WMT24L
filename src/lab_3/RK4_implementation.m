% Define the vector field as a function
vectorField = @(x, y) [-y; x];

% Time step
dt = 0.1;

% Number of steps
numSteps = 100;

% Define the grid for the vector field visualization
[X, Y] = meshgrid(-2:0.2:2, -2:0.2:2);
U = -Y;
V = X;

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
    x = zeros(1, numSteps);
    y = zeros(1, numSteps);
    x(1) = x0;
    y(1) = y0;
    
    for i = 1:numSteps-1
        k1 = vectorField(x(i), y(i));
        k2 = vectorField(x(i) + dt/2 * k1(1), y(i) + dt/2 * k1(2));
        k3 = vectorField(x(i) + dt/2 * k2(1), y(i) + dt/2 * k2(2));
        k4 = vectorField(x(i) + dt * k3(1), y(i) + dt * k3(2));
        x(i+1) = x(i) + dt/6 * (k1(1) + 2*k2(1) + 2*k3(1) + k4(1));
        y(i+1) = y(i) + dt/6 * (k1(2) + 2*k2(2) + 2*k3(2) + k4(2));
    end
    
    % Clear the current axes
    cla;
    
    % Re-plot the vector field
    quiver(X, Y, U, V, 'b'); % Blue arrows for the vector field
    hold on;
    
    % Plot the solution path using RK4
    plot(x, y, 'r'); % Red line for the solution path
    
    
% Calculate and plot the true solution using matrix exponentiation
    t = (0:numSteps-1) * dt;
    trueSolution = zeros(numSteps, 2);
    for i = 1:numSteps
        trueSolution(i, :) = (expm([0 -1; 1 0] * t(i)) * initialPoint)';   
    end
    plot(trueSolution(:,1), trueSolution(:,2), 'g--'); % Green dashed line for the true solution

end

legend('Vector Field', 'RK4 Solution Path', 'True Solution');


