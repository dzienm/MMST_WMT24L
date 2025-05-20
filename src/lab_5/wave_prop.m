plot(squeeze(Vib(1,1,:)))

timeIndex = 1000; % Replace with your desired time index

% Extract the snapshot at the given time index
snapshot = Vib(:, :, timeIndex)';

% Plot the snapshot
figure;
imagesc(snapshot);
colorbar;
title(['Wave Propagation Snapshot at Time Index ', num2str(timeIndex)]);
xlabel('Spatial Dimension 1');


% Get the number of time frames
numFrames = size(Vib, 3);

% Create a figure for the animation
figure;

%frames to skip
k=50;

% Loop through the frames, skipping every k frames
for t = 1:k:numFrames
    % Extract the snapshot at the current time index
    snapshot = Vib(:, :, t)';
    
    % Plot the snapshot
    imagesc(snapshot);
    clim([-0.005 0.005]);
    colorbar;
    title(['Wave Propagation at Time Index ', num2str(t)]);
    xlabel('Spatial Dimension 1');
    ylabel('Spatial Dimension 2');
    axis equal;
    
    % Pause to create the animation effect
    pause(0.05); % Adjust the pause duration as needed
end



% Create a figure for the animation
figure;

% Set consistent color limits
globalMin = -0.005;
globalMax = 0.005;

% Preallocate movie structure
F(ceil(numFrames/k)) = struct('cdata', [], 'colormap', []);

% Loop through the frames, skipping every k frames
frameIndex = 1;
for t = 1:k:numFrames
    % Extract the snapshot at the current time index
    snapshot = Vib(:, :, t)';
    
    % Plot the snapshot
    imagesc(snapshot);
    colorbar;
    title(['Wave Propagation at Time Index ', num2str(t)]);
    xlabel('Spatial Dimension 1');
    ylabel('Spatial Dimension 2');
    axis equal;
    clim([globalMin globalMax]);
    
    % Capture the frame
    F(frameIndex) = getframe(gcf);
    frameIndex = frameIndex + 1;
end

% Play the movie
movie(gcf, F, 1, 10); % Play the movie once at 10 frames per second

fft3result = fftshift(fftn(Vib));

imagesc(abs(fft3result(:,:,2000)))


% Define spatial and temporal increments
dx = 1.3; % milimeters

sampling = 6.25*10^6;
dt = 1/sampling;

% Get the number of spatial points and time frames
Nx = size(Vib, 1);
Ny = size(Vib, 2);
Nt = size(Vib, 3);

% Calculate frequency vectors
f = (-Nt/2:Nt/2-1) * (1/(Nt*dt));

% Perform 3D FFT on the wave propagation data
fft3result = fftshift(fftn(Vib));

% Calculate wavenumber vectors
kx = (-Nx/2:Nx/2-1) * (2*pi/(Nx*dx));
ky = (-Ny/2:Ny/2-1) * (2*pi/(Ny*dx));

% Average the spectrum over the frequency dimension
avgSpectrum = mean(abs(fft3result), 3);

% Plot the averaged spectrum
figure;
imagesc(kx, ky, avgSpectrum);
colorbar;
title('Averaged Spectrum over Frequencies');
xlabel('Wavenumber in x (rad/m)');
ylabel('Wavenumber in y (rad/m)');
axis xy;



% Create meshgrid for kx and ky
[KX, KY] = meshgrid(kx, ky);

% Calculate the magnitude of the wave vector
k_magnitude = sqrt(KX.^2 + KY.^2);

% Define the threshold for the wave vector magnitude
threshold = 1.5; % Replace with your desired threshold value

% Create the filter mask
filter_mask = k_magnitude >= threshold;


% Initialize the filtered FFT result
filtered_fft3result = zeros(size(fft3result));

%Apply the filter mask to each frequency slice
for t = 1:Nt
% Extract the current frequency slice
slice = fft3result(:, :, t);

% Apply the filter mask
filtered_slice = slice.*filter_mask';

% Store the filtered slice
filtered_fft3result(:, :, t) = filtered_slice;
end

% Plot the filtered spectrum averaged over frequencies
avgFilteredSpectrum = mean(abs(filtered_fft3result), 3);

figure;
imagesc(kx, ky, avgFilteredSpectrum);
colorbar;
title('Filtered Spectrum Averaged over Frequencies');
xlabel('Wavenumber in x (rad/m)');
ylabel('Wavenumber in y (rad/m)');
axis xy;


% Perform the inverse FFT to transform back to the space-time domain
filtered_wavefield = ifftn(ifftshift(filtered_fft3result));

% Animate the filtered result
figure;
for t = 1:k:numFrames
    original_frame = real(Vib(:, :, t)');
    filtered_frame = real(filtered_wavefield(:, :, t)');
    
    % Plot the original wavefield
    subplot(1, 2, 1);
    imagesc(original_frame);
    clim([-0.003 0.003]);
    colorbar;
    title(['Original Wavefield at Time Index ', num2str(t)]);
    xlabel('Spatial Dimension 1');
    ylabel('Spatial Dimension 2');
    axis equal;
    
    % Plot the filtered wavefield
    subplot(1, 2, 2);
    imagesc(filtered_frame);
    clim([-0.003 0.003]);
    colorbar;
    title(['Filtered Wavefield at Time Index ', num2str(t)]);
    xlabel('Spatial Dimension 1');
    ylabel('Spatial Dimension 2');
    axis equal;
    
    % Pause to create the animation effect
    pause(0.1); % Adjust the pause duration as needed
end
