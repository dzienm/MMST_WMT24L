% Parameters
m = 1; % mass (kg)
k = 10; % spring constant (N/m)
F0 = 1; % amplitude of the forcing function (N)
omega = 2; % angular frequency of the forcing function (rad/s)

% Time vector
t = linspace(0, 60, 1000); % time (s)

% Define the differential equation for forced harmonic oscillator
forced_oscillator_eq = @(t, y, c) [y(2); (F0*cos(omega*t) - c*y(2) - k*y(1))/m];

% Initial conditions
y0 = [0; 0]; % initial displacement and velocity
% Damping coefficients for different conditions
damping_coeffs = struct('Undamped', 0, ...
                        'Underdamped', 0.5, ...
                        'CriticallyDamped', 2*sqrt(k*m), ...
                        'Overdamped', 5);

% Solve the differential equation for each damping condition
solutions = struct();
for field = fieldnames(damping_coeffs)'
    condition = field{1};
    c = damping_coeffs.(condition);
    [t, y] = ode45(@(t, y) forced_oscillator_eq(t, y, c), t, y0);
    solutions.(condition) = y(:, 1);
end

% Plot the solutions for different damping conditions
figure;
hold on;
for field = fieldnames(solutions)'
    
    condition = field{1};
    plot(t, solutions.(condition), 'DisplayName', condition);
end
title('Forced Harmonic Oscillator with Different Damping Conditions');
xlabel('Time (s)');
ylabel('Displacement (m)');
legend;
grid on;
hold off;



% Parameters
m = 1; % mass (kg)
k = 10; % spring constant (N/m)
F0 = 1; % amplitude of the forcing function (N)
c = 0.5; % damping coefficient (Ns/m)

% Time vector
t = linspace(0, 200, 20000); % extended time (s)

% Define the differential equation for forced harmonic oscillator
forced_oscillator_eq = @(t, y, omega) [y(2); (F0*cos(omega*t) - c*y(2) - k*y(1))/m];

% Initial conditions
y0 = [0; 0]; % initial displacement and velocity

% Frequency range for the excitation
frequencies = linspace(0.1, 10, 100);

% Store the steady-state amplitudes
steady_state_amplitudes = zeros(size(frequencies));

% Solve the differential equation for each frequency and calculate the steady-state amplitude
for i = 1:length(frequencies)
    omega = frequencies(i);
    [t, y] = ode45(@(t, y) forced_oscillator_eq(t, y, omega), t, y0);
    
    % Analyze the amplitude over time to ensure steady-state
    segment_length = round(length(t) / 10); % analyze last 10% of the time vector
    steady_state_amplitude = max(y(end-segment_length:end, 1)) - min(y(end-segment_length:end, 1));
    steady_state_amplitudes(i) = steady_state_amplitude / F0;
end

% Plot the filter characteristics
figure;
plot(frequencies, steady_state_amplitudes);
title('Amplitude Dependence of Damped Oscillations on Excitation Frequency');
xlabel('Excitation Frequency (rad/s)');
ylabel('Normalized Steady-State Amplitude');
grid on;

