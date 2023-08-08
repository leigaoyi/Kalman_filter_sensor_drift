% Load data
close all
clear
ref_load = load('./result/ref_errbar.txt');
ref_curve = ref_load;
measure_mean = load('./result/measure_mean.txt');
measure_std = 1 * load('./result/measure_err.txt');
track_mean = load('./result/track_mean.txt');
track_std = 1 * load('./result/track_err.txt'); % 2 std

time_period = 1:50; % Example range from 1 to 50
time_period = reshape(time_period, 1, 50);

% Convert the hexadecimal color code to RGB values
track_color = [237, 33, 41] / 255; % RGB values for #ED2129
measure_color = [0.23, 0.27, 0.61];

% Define figure size
figure('Units', 'inches', 'Position', [1, 1, 8, 5]); % Width: 8 inches, Height: 5 inches

% Normalize the data
rms_value = rms(ref_curve);
ref_norm = ref_curve / rms_value;
measure_norm = (measure_mean) / rms_value - ref_norm;
track_norm = (track_mean) / rms_value - ref_norm;

% Create vectors for filling the error areas
measure_lower = measure_norm - measure_std / rms_value;
measure_upper = measure_norm + measure_std / rms_value;
track_lower = track_norm - track_std / rms_value;
track_upper = track_norm + track_std / rms_value;

measure_lower = reshape(measure_lower, 1, 50);
measure_upper = reshape(measure_upper, 1, 50);

track_lower = reshape(track_lower, 1, 50);
track_upper = reshape(track_upper, 1, 50);

a = cat(2, time_period, fliplr(time_period));
b = cat(2, measure_lower, fliplr(measure_upper));

% Plot the curves with error areas
fill(a, b, measure_color, 'FaceAlpha', 0.3);
hold on;
track_area = [track_lower, fliplr(track_upper)];
track_area = reshape(track_area, [1, 100]);
fill([time_period, fliplr(time_period)], track_area, track_color, 'FaceAlpha', 0.3);
plot(time_period, measure_norm, 'LineWidth', 1.5, 'Color', measure_color);
plot(time_period, track_norm, 'LineWidth', 1.5, 'Color', track_color);

% Customize the plot
xlabel('Time (ms)', 'FontSize', 12);
ylabel('\Deltay / \deltaB_{rms}', 'FontSize', 12);
legend('Measurement error', 'KF estimate error', 'FontSize', 12, 'Box', 'off');
grid on;
box on;
xlim([1, 50]);
%ylim([-2, 2]); % Adjust the y-axis limits as needed

% Adjust figure properties for publication quality
set(gca, 'FontSize', 12); % Decrease font size slightly for publication
set(gca, 'LineWidth', 1.5); % Increase line width
set(gca, 'TickDir', 'in'); % Set tick direction
set(gcf, 'Color', 'w'); % Set background color to white

% Save the plot as an EPS file for high-quality printing
print(gcf, 'error_plot.png', '-depsc', '-r600');
