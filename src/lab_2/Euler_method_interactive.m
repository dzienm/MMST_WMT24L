% Define the vector field as a function
vectorField = @(x, y) [-y; x];

% Define the vector field as a function
vectorField_ode45 = @(t, y) [-y(2); y(1)];

% Time step
dt = 0.1;

% Number of steps
numSteps = 1000;

tspan = [0 (numSteps-1)*dt];


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
    
    % Clear the current axes
    cla;
    
    % Re-plot the vector field
    quiver(X, Y, U, V, 'b'); % Blue arrows for the vector field
    hold on;
    
    % Initialize arrays to store the solution - numeryczne
    x = zeros(1, numSteps);
    y = zeros(1, numSteps);
    x(1) = x0;
    y(1) = y0;

    % Initialize arrays to store the solution - numeryczne
    x_true = zeros(1, numSteps);
    y_true = zeros(1, numSteps);
    x(1) = x0;
    y(1) = y0;

A = [0, -1; 1, 0];

    % Euler's method loop
    for i = 1:numSteps-1
        u = vectorField(x(i), y(i));
        x(i+1) = x(i) + u(1) * dt;
        y(i+1) = y(i) + u(2) * dt;
        result = expm(A*(i-1)*dt)*[x0,y0]'; %mozna lepiej w sensie wydajnosci
        x_true(i+1) = result(1);
        y_true(i+1) = result(2);
    end


    initialPoint = [x0; y0];

    % Solve the differential equation using ode45
    [t, sol] = ode45(vectorField_ode45, tspan, initialPoint);

    
    % Plot the solution path
    plot(x, y, 'y'); % Red line for the solution path
    plot(x_true, y_true, 'g'); %prawdziwie rozwiazanie
    plot(sol(:,1), sol(:,2), 'r'); % yellow line for the solution path
end

legend('Vector Field', 'Solution Path');
