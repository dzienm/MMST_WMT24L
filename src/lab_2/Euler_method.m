% Define the vector field as a function
vectorField = @(x, y) [-y; x];

% Initial conditions (starting point)
x0 = 1;
y0 = 0;

% Time step
dt = 0.1;

% Number of steps
numSteps = 100;

% Initialize arrays to store the solution
x = zeros(1, numSteps);
y = zeros(1, numSteps);
x(1) = x0;
y(1) = y0;

% Euler's method loop
for i = 1:numSteps-1
    u = vectorField(x(i), y(i));
    x(i+1) = x(i) + u(1) * dt;
    y(i+1) = y(i) + u(2) * dt;
end


% Define the grid for the vector field visualization
[X, Y] = meshgrid(-2:0.2:2, -2:0.2:2);
U = -Y;
V = X;

% Plot the vector field
figure;
quiver(X, Y, U, V, 'b'); % Blue arrows for the vector field
hold on;

% Plot the solution path
plot(x, y, 'r'); % Red line for the solution path
title('Vector Field and Solution Path');
xlabel('X-axis');
ylabel('Y-axis');
grid on;
legend('Vector Field', 'Solution Path')

