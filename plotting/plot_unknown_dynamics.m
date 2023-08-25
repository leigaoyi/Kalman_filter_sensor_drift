close all
clear

input_curve = load('../result/Measure_unknown.txt');
track_input = load('../result/KF_track_unknown_measure.txt');
time_axis = linspace(0, (length(input_curve)-1)*1e-3, length(input_curve));

% Convert the hexadecimal color code to RGB values
track_color = [237, 33, 41] / 255; % RGB values for #ED2129
input_color = [0.23, 0.27, 0.61];
figure('Units', 'centimeters', 'Position', [2, 2, 10, 6]); % Adjust the figure size and position

hold on; % Enable holding multiple plots in the same figure
plot(time_axis, input_curve, 'Color', input_color, 'LineWidth', 1.5); % Plot the input_curve with a linewidth of 2
plot(time_axis, track_input, 'Color', track_color, 'LineWidth', 1.5); % Plot the track_input with a linewidth of 2
hold off; % Disable holding multiple plots

% Add labels and title to the plot
xlabel('Time (s)', 'FontSize', 10); % Adjust font size
ylabel('Response (mV)', 'FontSize', 10); % Adjust font size
%title('Unknown Input Curve and Track Input', 'FontSize', 12); % Adjust font size and style

% Add grid to the plot
grid on;

% Set y-axis limits
%ylim([-17, 15.5]);

% Adjust the legend position
legend('Measurement', 'KF estimate', 'Location', 'best');
%legend('boxoff');

% Adjust the tick labels font size
set(gca, 'FontSize', 8);

% Adjust the line widths for better visibility in print
set(findobj(gca, 'Type', 'Line'), 'LineWidth', 1.2);

% Adjust the axes properties
ax = gca;
ax.LineWidth = 0.8;
ax.Box = 'on';

% Save the figure as a high-resolution image for the scientific paper
%print('plot_track_dynamic_input', '-dpng', '-r600'); % Specify the desired image format and resolution
