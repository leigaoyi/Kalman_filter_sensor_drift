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

figure('Units', 'centimeters', 'Position', [2, 2, 20, 26]);
% First subplot: Plotting ideal response, measurement, and KF estimate
subplot(2, 1, 1); % Divide the figure into 1 row, 2 columns, and select the first subplot
% Plot reference curve as a line
plot(time_period, ref_curve, 'k-', 'LineWidth', 1);
hold on;

% Plot measured data with markers and no line
plot(time_period, measure_mean, 'Marker', 's', 'LineWidth', 1.5,'MarkerSize', 6, 'LineStyle', 'none', 'Color', measure_color);

% Plot tracked data with markers and no line
plot(time_period, track_mean, 'Marker', 'o', 'LineWidth', 1.2,'MarkerSize', 6, 'LineStyle', 'none', 'Color', track_color);
% Remove x-label from the first subplot
xticklabels({});
% Customize the plot
%xlabel('Time (ms)');
ylabel('Response (mV)');
% title('Measurement and Tracking');

% Create a legend
legend('Ideal Response', 'Measurement', 'KF estimate', 'FontSize', 14, 'Box', 'off');

grid on;
hold off;

% Adjust figure properties for publication quality
set(gca, 'FontSize', 16); % Increase font size
set(gca, 'LineWidth', 1.5); % Increase line width
set(gca, 'TickDir', 'in'); % Set tick direction
set(gca, 'Box', 'on'); % Remove box around the plot
set(gcf, 'Color', 'w'); % Set background color to white
xlim([0.5, 50.5]);
ylim([-240, 240]);

% Second subplot: Plotting measurement error and KF estimate error
subplot(2, 1, 2); % Select the second subplot

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

mean(abs(measure_norm))
mean(abs(track_norm))


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
xlabel('Time (ms)', 'FontSize', 16);
ylabel('\Deltay / \deltaB_{rms}', 'FontSize', 16);
legend('Measurement error', 'KF estimate error', 'FontSize', 14, 'Box', 'off');
grid on;
box on;
xlim([0.5, 50.5]);
%ylim([-2, 2]); % Adjust the y-axis limits as needed
yticks([-0.2,-0.1,0,0.1,0.2]);
% Adjust figure properties for publication quality
set(gca, 'FontSize', 16); % Decrease font size slightly for publication
set(gca, 'LineWidth', 1.5); % Increase line width
set(gca, 'TickDir', 'in'); % Set tick direction
set(gcf, 'Color', 'w'); % Set background color to white

% Reduce the vertical spacing between the subplots
ax1 = subplot(2, 1, 1);
ax2 = subplot(2, 1, 2);
ax1.Position(2) = ax1.Position(2) - 0.06;
ax2.Position(4) = ax2.Position(4) + 0.06;

% Link the x-axis of both subplots
linkaxes([ax1, ax2], 'x');


text(-0.08, 1.89, '(a)', 'Units', 'normalized', 'FontSize', 16, 'FontWeight', 'bold', 'HorizontalAlignment', 'right');
% Add label "(b)" outside the plot box
text(-0.08, 0.99, '(b)', 'Units', 'normalized', 'FontSize', 16, 'FontWeight', 'bold', 'HorizontalAlignment', 'right');


print('KF_track_error', '-dpng', '-r600'); % Specify the desired image format and resolution
