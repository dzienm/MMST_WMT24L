function rlc_filter_gui
    % Create the main figure
    fig = figure('Position', [100, 100, 900, 700], 'Name', 'RLC Filter Characteristics', 'NumberTitle', 'off', 'MenuBar', 'none', 'ResizeFcn', @resize_callback);

    % Create UI controls for input parameters
    uicontrol('Style', 'text', 'Position', [20, 350, 100, 20], 'String', 'Resistance (R):');
    R_input = uicontrol('Style', 'edit', 'Position', [130, 350, 100, 20], 'String', '10');

    uicontrol('Style', 'text', 'Position', [20, 320, 100, 20], 'String', 'Inductance (L):');
    L_input = uicontrol('Style', 'edit', 'Position', [130, 320, 100, 20], 'String', '1');

    uicontrol('Style', 'text', 'Position', [20, 290, 100, 20], 'String', 'Capacitance (C):');
    C_input = uicontrol('Style', 'edit', 'Position', [130, 290, 100, 20], 'String', '0.01');

    uicontrol('Style', 'text', 'Position', [20, 260, 100, 20], 'String', 'Freq Range (Hz):');
    freq_range_input = uicontrol('Style', 'edit', 'Position', [130, 260, 100, 20], 'String', '0.1, 10');

    % Create a button to calculate and plot the characteristics
    uicontrol('Style', 'pushbutton', 'Position', [130, 230, 100, 30], 'String', 'Calculate', 'Callback', @calculate_callback);

    % Create axes for plotting
    ax = axes('Units', 'normalized', 'Position', [0.3, 0.1, 0.65, 0.8]);

    function calculate_callback(~, ~)
        % Get input values
        R = str2double(get(R_input, 'String'));
        L = str2double(get(L_input, 'String'));
        C = str2double(get(C_input, 'String'));
        freq_range = str2num(get(freq_range_input, 'String')); %#ok<ST2NM>

        % Time vector
        t = linspace(0, 200, 20000); % extended time (s)

        % Define the differential equation for the RLC circuit in terms of charge
        rlc_circuit_charge = @(t, y, omega) [y(2); (1*cos(omega*t) - R*y(2) - y(1)/C)/L];

        % Frequency range for the excitation in Hertz
        frequencies_hz = linspace(freq_range(1), freq_range(2), 100);
        frequencies_rad_s = 2 * pi * frequencies_hz;

        % Store the steady-state amplitudes
        steady_state_amplitudes = zeros(size(frequencies_hz));

        % Solve the differential equation for each frequency and calculate the steady-state amplitude
        for i = 1:length(frequencies_rad_s)
            omega = frequencies_rad_s(i);
            [t, y] = ode45(@(t, y) rlc_circuit_charge(t, y, omega), t, [0; 0]);

            % Analyze the amplitude over time to ensure steady-state
            segment_length = round(length(t) / 10); % analyze last 10% of the time vector
            steady_state_amplitude = max(y(end-segment_length:end, 2)) - min(y(end-segment_length:end, 2));
            steady_state_amplitudes(i) = steady_state_amplitude;
        end

        % Plot the filter characteristics with frequency in Hertz
        plot(ax, frequencies_hz, steady_state_amplitudes);
        title(ax, 'Amplitude Dependence of Voltage Drop on Resistor in RLC Circuit');
        xlabel(ax, 'Excitation Frequency (Hz)');
        ylabel(ax, 'Normalized Steady-State Amplitude');
        grid(ax, 'on');
    end

    function resize_callback(~, ~)
        % Get the current figure size
        fig_pos = get(fig, 'Position');
        
        % Adjust the axes position to fill the figure
        set(ax, 'Position', [0.3, 0.1, 0.65, 0.8]);
    end
end
