% Define the grid
[x, y] = meshgrid(-2:0.2:2, -2:0.2:2);

% Define the vector field components
%coordinate x
u = -y;
%coordinate y
v = x;

% Visualize the vector field
figure(1)
quiver(x, y, u, v);
title('Vector Field Visualization');
xlabel('X-axis');
ylabel('Y-axis');

%przyklad rysowania funkcji
figure(2)
z = x.^2+y.^2;
mesh(x,y,z)

%%nowa metida

% Example data (replace these with your actual data)
x = [1, 2, 3, 4, 5];
y = [1, 4, 9, 16, 25];
u = [1, 0.5, -0.5, -1, -1.5];
v = [0.5, 1, 1.5, 2, 2.5];

% Visualize the vector field
quiver(x, y, u, v);
title('Vector Field Visualization');
xlabel('X-axis');
ylabel('Y-axis');
