% Example usage
filename = 'IGB.txt';

% Load the data
data = load_signal_data(filename);

% Plot the signal over time
figure;
subplot(2, 1, 1);
plot(data.time, data.signal);
title('Signal over Time');
xlabel('Time (s)');
ylabel('Signal (m/s)');
grid on;

% Compute and plot the signal spectrum
subplot(2, 1, 2);
n = length(data.signal);
fs = 1 / mean(diff(data.time));  % Sampling frequency
f = (0:n-1)*(fs/n);  % Frequency range
Y = fft(data.signal);
P2 = abs(Y/n);  % Two-sided spectrum
P1 = P2(1:n/2+1);  % Single-sided spectrum
P1(2:end-1) = 2*P1(2:end-1);
plot(f(1:n/2+1), P1);
title('Signal Spectrum');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;

f_low = 840;
f_high = 960;
% Apply the rectangular filter
Y_filtered = Y;
Y_filtered(f < f_low | f > f_high) = 0;
signal_filtered = ifft(Y_filtered, 'symmetric');

figure;
% Plot the filtered signal over time
subplot(3, 1, 1);
plot(data.time, data.signal);
title('Signal over Time');
xlabel('Time (s)');
ylabel('Signal (m/s)');
grid on;

subplot(3, 1, 2);
plot(data.time, signal_filtered);
title('Filtered Signal over Time');
xlabel('Time (s)');
ylabel('Signal (m/s)');
grid on;

% Compute and plot the filtered signal spectrum
subplot(3, 1, 3);
P2_filtered = abs(Y_filtered/n); % Two-sided spectrum
P1_filtered = P2_filtered(1:n/2+1); % Single-sided spectrum
P1_filtered(2:end-1) = 2*P1_filtered(2:end-1);
hold on
plot(f(1:n/2+1), P1, 'DisplayName', 'original');
plot(f(1:n/2+1), P1_filtered, 'DisplayName', 'filtered');
title('Signal Spectrum Comparison');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
legend;
grid on;

