% Define the grid
N = 256; % Grid size
x = linspace(-pi, pi, N);
y = linspace(-pi, pi, N);
[X, Y] = meshgrid(x, y);

% Standing wave in x direction
wave_x = sin(5 * X);
% Standing wave in y direction
wave_y = sin(5 * Y);
% Circular wave from the origin
wave_circular = sin(30 * sqrt(X.^2 + Y.^2));

% Compute 2D Fourier Transforms
F_wave_x = fftshift(fft2(wave_x));
F_wave_y = fftshift(fft2(wave_y));
F_wave_circular = fftshift(fft2(wave_circular));

% Plotting
figure;

% Plot standing wave in x direction
subplot(3, 2, 1);
imagesc(x, y, wave_x);
title('Standing Wave in X Direction');
axis image;
colormap gray;

% Plot 2D Fourier Spectrum of standing wave in x direction
subplot(3, 2, 2);
imagesc(log(abs(F_wave_x) + 1));
title('2D Fourier Spectrum (X Direction)');
axis image;
colormap gray;

% Plot standing wave in y direction
subplot(3, 2, 3);
imagesc(x, y, wave_y);
title('Standing Wave in Y Direction');
axis image;
colormap gray;

% Plot 2D Fourier Spectrum of standing wave in y direction
subplot(3, 2, 4);
imagesc(log(abs(F_wave_y) + 1));
title('2D Fourier Spectrum (Y Direction)');
axis image;
colormap gray;

% Plot circular wave from the origin
subplot(3, 2, 5);
imagesc(x, y, wave_circular);
title('Circular Wave from Origin');
axis image;
colormap gray;

% Plot 2D Fourier Spectrum of circular wave
subplot(3, 2, 6);
imagesc(log(abs(F_wave_circular) + 1));
title('2D Fourier Spectrum (Circular Wave)');
axis image;
colormap gray;


% Cut the upper right quarter of the Fourier spectrum
cut_F_wave_circular = F_wave_circular;
cut_F_wave_circular(1:N/2, N/2+1:end) = 0;
cut_F_wave_circular(N/2+1:end, 1:N/2) = 0;

% Perform inverse Fourier Transform
inverse_wave_circular = ifft2(ifftshift(cut_F_wave_circular));


% Plot cut Fourier Spectrum
figure
imagesc(log(abs(cut_F_wave_circular) + 1));
title('Cut 2D Fourier Spectrum (Upper Right Quarter - symmetric)');
axis image;
colormap gray


% Plot inverse of cut Fourier Spectrum
figure
imagesc(x, y, real(inverse_wave_circular));
title('Inverse of Cut Fourier Spectrum');
axis image;
colormap gray;

