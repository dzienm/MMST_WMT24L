function [x, y] = Euler_solver(vector_field, initialPoint, dt, numSteps)
    x = zeros(1, numSteps);
    y = zeros(1, numSteps);
    x(1) = initialPoint(1);
    y(1) = initialPoint(2);
    
    for i = 1:numSteps-1
        u = vector_field(x(i), y(i));
        x(i+1) = x(i) + u(1) * dt;
        y(i+1) = y(i) + u(2) * dt;
    end
end
