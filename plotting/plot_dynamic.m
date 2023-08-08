close all
clear

input_curve = load('../data/Input_unknown.txt');
track_input = load('../data/KF_track_in.txt');
time_axis = linspace(0, (length(input_curve)-1)*1e-3, length(input_curve));

% Convert the hexadecimal color code to RGB values
track_color = [237, 33, 41] / 255; % RGB values for #ED2129
input_color = [0.23, 0.27, 0.61];

% Create figure (a)
figure('Units', 'centimeters', 'Position', [2, 2, 14, 10]); % Adjust the figure size and position
subplot(2, 1, 1);
hold on; % Enable holding multiple plots in the same subplot
plot(time_axis, input_curve, 'Color', input_color, 'LineWidth', 1.5); % Plot the input_curve with a linewidth of 2
plot(time_axis, track_input, 'Color', track_color, 'LineWidth', 1.5);

hold off; % Disable holding multiple plots in the subplot

% Add labels and title to the subplot
xlabel('Time (s)', 'FontSize', 10); % Adjust font size
ylabel('Response (mV)', 'FontSize', 10); % Adjust font size


% Add grid to the subplot
grid on;

% Set y-axis limits in the subplot
ylim([-17, 15.5]);

% Adjust the tick labels font size in the subplot
set(gca, 'FontSize', 8);

% Adjust the line widths for better visibility in print
set(findobj(gca, 'Type', 'Line'), 'LineWidth', 1.2);

% Adjust the axes properties
ax = gca;
ax.LineWidth = 0.8;
ax.Box = 'on';

% Create figure (b)
subplot(2, 1, 2);
measure_curve = load('../data/Measure_unknown.txt');
track_measure = load('../data/KF_track_unknown_measure.txt');


hold on; % Enable holding multiple plots in the same subplot
plot(time_axis, track_measure, 'Color', track_color, 'LineWidth', 1.5); % Plot the track_input with a linewidth of 2
scatter(time_axis(1:3:end), measure_curve(1:3:end), 'MarkerFaceColor', input_color, 'MarkerEdgeColor', input_color, 'SizeData', 8); % Plot the scatter points
hold off; % Disable holding multiple plots in the subplot

% Add labels and title to the subplot
xlabel('Time (s)', 'FontSize', 10); % Adjust font size
ylabel('Response (mV)', 'FontSize', 10); % Adjust font size


% Add grid to the subplot
grid on;

% Set y-axis limits in the subplot
ylim([-24, 21]);

% Adjust the tick labels font size in the subplot
set(gca, 'FontSize', 8);

% Adjust the line widths for better visibility in print
set(findobj(gca, 'Type', 'Line'), 'LineWidth', 1.2);

% Adjust the axes properties
ax = gca;
ax.LineWidth = 0.8;
ax.Box = 'on';

% Save the figure as high-resolution images for the scientific paper
print('plot_track_dynamic', '-dpng', '-r600'); % Specify the desired image format and resolution

