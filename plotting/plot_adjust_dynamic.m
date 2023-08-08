close all
clear

input_curve = load('./data/Input_unknown.txt');
track_input = load('./data/KF_track_in.txt');
time_axis = linspace(0, (length(input_curve)-1)*1e-3, length(input_curve));

% Convert the hexadecimal color code to RGB values
track_color = [237, 33, 41] / 255; % RGB values for #ED2129
input_color = [0.23, 0.27, 0.61];

% Create figure
figure('Units', 'centimeters', 'Position', [2, 2, 20, 26]);; % Adjust the figure size and position

% Create the first subplot
subplot(2, 1, 1);
hold on; % Enable holding multiple plots in the same subplot
plot(time_axis, input_curve, 'Color', input_color, 'LineWidth', 1.5); % Plot the input_curve with a linewidth of 2
plot(time_axis, track_input, 'Color', track_color, 'LineWidth', 1.5);
ylabel('Amplitude (mV)', 'FontSize', 16); % Adjust font size
hold off; % Disable holding multiple plots in the subplot

% Remove x-label from the first subplot
xticklabels({});
legend('Applied waveform', 'KF estimate','FontSize', 10, 'Box', 'off','Location', 'northeast');
% Add grid to the subplot
grid on;

% Set y-axis limits in the subplot
ylim([-20, 20.5]);

% Adjust the tick labels font size in the subplot
set(gca, 'FontSize', 16);

% Adjust the line widths for better visibility in print
set(findobj(gca, 'Type', 'Line'), 'LineWidth', 1.5);

% Adjust the axes properties
ax = gca;
ax.LineWidth = 0.8;
ax.Box = 'on';

% Create the second subplot
subplot(2, 1, 2);
measure_curve = load('./data/Measure_unknown.txt');
track_measure = load('./data/KF_track_unknown_measure.txt');

hold on; % Enable holding multiple plots in the same subplot
scatter(time_axis(1:3:end), measure_curve(1:3:end), 'MarkerFaceColor', input_color, 'MarkerEdgeColor', input_color, 'SizeData', 8); % Plot the scatter points
plot(time_axis, track_measure, 'Color', track_color, 'LineWidth', 1.5); % Plot the track_input with a linewidth of 2

hold off; % Disable holding multiple plots in the subplot

% Add labels and title to the subplot
xlabel('Time (s)', 'FontSize', 16); % Adjust font size
ylabel('Response (mV)', 'FontSize', 16); % Adjust font size
% Add grid to the subplot
grid on;
legend('Measurement', 'KF estimate','FontSize', 10, 'Box', 'off','Location', 'northeast');
% Set y-axis limits in the subplot
ylim([-24, 25]);

% Adjust the tick labels font size in the subplot
set(gca, 'FontSize', 16);

% Adjust the line widths for better visibility in print
set(findobj(gca, 'Type', 'Line'), 'LineWidth', 1.5);

% Adjust the axes properties
ax = gca;
ax.LineWidth = 0.8;
ax.Box = 'on';

% Add label "(a)" outside the plot box
text(-0.08, 1.89, '(a)', 'Units', 'normalized', 'FontSize', 16, 'FontWeight', 'bold', 'HorizontalAlignment', 'right');

% Add label "(b)" outside the plot box
text(-0.08, 0.99, '(b)', 'Units', 'normalized', 'FontSize', 16, 'FontWeight', 'bold', 'HorizontalAlignment', 'right');


% Reduce the vertical spacing between the subplots
ax1 = subplot(2, 1, 1);
ax2 = subplot(2, 1, 2);
ax1.Position(2) = ax1.Position(2) - 0.06;
ax2.Position(4) = ax2.Position(4) + 0.06;

% Link the x-axis of both subplots
linkaxes([ax1, ax2], 'x');

print('KF_track_dynamic', '-dpng', '-r600'); % Specify the desired image format and resolution


