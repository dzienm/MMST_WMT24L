% Define the axis of rotation and the point to rotate
axis = [0, 0, -1];
point = [1; 0; 0];         % Column vector

figure;
hold on;
grid on;
axis equal;
xlabel('X');
ylabel('Y');
zlabel('Z');
title('Rotation of a 3D Point around an Arbitrary Axis');
view(3);

% Generate colors
numSteps = 100;
angles = linspace(0, 2*pi, numSteps);
cmap = jet(numSteps);
% Rotate and plot
for i = 1:numSteps
    theta = angles(i);
    R = rotation_matrix_exp(axis,theta);
    rotated_point = R * point;
    scatter3(rotated_point(1), rotated_point(2), rotated_point(3), 36, cmap(i,:), 'filled');
    drawnow;
    pause(0.05);
end