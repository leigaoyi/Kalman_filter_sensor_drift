% Load data
close all
clear
ref_load = load('./result/ref_errbar.txt');
ref_curve = ref_load;
measure_mean = load('./result/measure_mean.txt');
measure_std = 2 * load('./result/measure_err.txt');
track_mean = load('./result/track_mean.txt');
track_std = 2 * load('./result/track_err.txt'); % 2 std

time_period = 1:50; % Example range from 1 to 50

% Convert the hexadecimal color code to RGB values
track_color = [237, 33, 41] / 255; % RGB values for #ED2129
measure_color = [0.23, 0.27, 0.61];
% Define figure size
figure('Units', 'inches', 'Position', [1, 1, 8, 5]); % Width: 8 inches, Height: 6 inches

% Plot reference curve as a line
plot(time_period, ref_curve, 'k-', 'LineWidth', 1);
hold on;

% Plot measured data with markers and no line
plot(time_period, measure_mean, 'Marker', 's', 'LineWidth', 1.5,'MarkerSize', 8, 'LineStyle', 'none', 'Color', measure_color);

% Plot tracked data with markers and no line
plot(time_period, track_mean, 'Marker', 'o', 'LineWidth', 1.2,'MarkerSize', 8, 'LineStyle', 'none', 'Color', track_color);

% Customize the plot
xlabel('Time (ms)');
ylabel('Response (mV)');
% title('Measurement and Tracking');

% Create a legend
legend('Ideal Response', 'Measurement', 'KF estimate', 'FontSize', 16, 'Box', 'off');

grid on;
hold off;

% Adjust figure properties for publication quality
set(gca, 'FontSize', 12); % Increase font size
set(gca, 'LineWidth', 1.5); % Increase line width
set(gca, 'TickDir', 'in'); % Set tick direction
set(gca, 'Box', 'on'); % Remove box around the plot
set(gcf, 'Color', 'w'); % Set background color to white
xlim([0, 51]);
ylim([-240, 240]);

print('KF_track_mean', '-dpng', '-r600'); % Specify the desired image format and resolution
