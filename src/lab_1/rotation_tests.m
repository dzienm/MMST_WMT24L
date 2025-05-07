% Define the axis of rotation and the starting point
rot_axis = [1, 1, 0];
point = [1, 0, 0];

% Define the range of angles from 0 to 2*pi
angles = linspace(0, 2 * pi, 100);

% Rotate the point for each angle and plot it
colormap jet;
cmap = colormap;
n_colors = size(cmap, 1);

% Initialize the plot
figure;
hold on;
% Rotate the point for each angle and plot it
for i = 1:length(angles)
    theta = angles(i);
    R = rotation_matrix(rot_axis, theta);
    rotated_point = R * point';
    color_idx = round((i / length(angles)) * (n_colors - 1)) + 1; %rainbow
    plot3(rotated_point(1), rotated_point(2), rotated_point(3), 'o', 'Color', cmap(color_idx,:));
end
% Set plot labels and show the plot
xlabel('X');
ylabel('Y');
zlabel('Z');
grid on;
title('Rotation of a Point Around a 3D Axis');
axis equal;
hold off;
