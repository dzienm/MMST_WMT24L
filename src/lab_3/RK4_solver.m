function [x, y] = RK4_solver(vector_field, initialPoint, dt, numSteps)
    x = zeros(1, numSteps);
    y = zeros(1, numSteps);
    x(1) = initialPoint(1);
    y(1) = initialPoint(2);
    
    for i = 1:numSteps-1
        k1 = vector_field(x(i), y(i));
        k2 = vector_field(x(i) + dt/2 * k1(1), y(i) + dt/2 * k1(2));
        k3 = vector_field(x(i) + dt/2 * k2(1), y(i) + dt/2 * k2(2));
        k4 = vector_field(x(i) + dt * k3(1), y(i) + dt * k3(2));
        x(i+1) = x(i) + dt/6 * (k1(1) + 2*k2(1) + 2*k3(1) + k4(1));
        y(i+1) = y(i) + dt/6 * (k1(2) + 2*k2(2) + 2*k3(2) + k4(2));
    end
end

