% Main script
dt = 0.1;
numSteps = 100;

% Define the non-linear vector field as an anonymous function
%vector_field = @(x, y) [y - x^2; x - y^2];
%vector_field = @(x, y) deal(y - x.^2, x - y.^2);
vector_field = @(x, y) [-y; x];
%vector_field = @(x, y) [-0.5*x-y; x];

%solver
%ode_solver = @RK4_solver;
ode_solver = @Euler_solver;

%define axes range to plot vector_field
x_axis = -2:0.2:2;
y_axis = -2:0.2:2;

% Call the plotting function
plot_vf_and_ode_solution(vector_field, ode_solver, dt, numSteps, x_axis, y_axis);
