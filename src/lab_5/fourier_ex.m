function interactive_fourier_series()
    % Define the function to be approximated (square wave) as an anonymous function
    %function_ex = @(x) sign(sin(x));
    %function_ex = @(x) x;
    %function_ex = @(x) x.^2;
    %function_ex = @(x) exp(x);
    %function_ex = @(x) x.^3;
    function_ex = @(x) x.^4;

    % Parameters
    x = linspace(-pi, pi, 1000);
    y = function_ex(x);

    % Create the figure and plot
    fig = figure('Name', 'Interactive Fourier Series Approximation');
    ax = axes('Parent', fig);
    plot(x, y, 'b', 'DisplayName', 'Original Function (Square Wave)');
    hold on;
    approx_plot = plot(x, y, 'r', 'DisplayName', 'FFT Approximation');
    title('FFT Approximation of a Square Wave');
    xlabel('x');
    ylabel('f(x)');
    legend;
    grid on;

    % Create the text display for the slider value
    text_display = uicontrol('Style', 'text', 'Units', 'normalized', ...
                             'Position', [0.82 0.01 0.1 0.05], 'String', 'N=10');

    % Create the slider
    slider = uicontrol('Style', 'slider', 'Min', 1, 'Max', 100, 'Value', 10, ...
                       'Units', 'normalized', 'Position', [0.1 0.01 0.7 0.05], ...
                       'Callback', @(src, event) update_plot(src, y, approx_plot, text_display));

    % Initial plot update
    update_plot(slider, y, approx_plot, text_display);
end

function update_plot(slider, y, approx_plot, text_display)
    N = round(get(slider, 'Value'));  % Get the current value of the slider
    y_approx = fft_approximation(y, N);
    set(approx_plot, 'YData', y_approx);  % Update the plot data
    set(text_display, 'String', sprintf('N=%d', N));  % Update the text display
    title(sprintf('FFT Approximation of a Square Wave (N=%d)', N));
end

function y_approx = fft_approximation(y, N)
    Y = fft(y);
    Y(N+1:end) = 0;  % Zero out all but the first N components
    y_approx = ifft(Y, 'symmetric');
end
