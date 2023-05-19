% Load data
close all
clear
ref_load = load('./result/ref_errbar.txt');
ref_curve = ref_load;
measure_mean = load('./result/measure_mean.txt');
measure_std = 2*load('./result/measure_err.txt');
track_mean = load('./result/track_mean.txt');
track_std = 2*load('./result/track_err.txt'); % 2 std

time_period = 1:50; % Example range from 1 to 50

% Convert the hexadecimal color code to RGB values
track_color = [237, 33, 41] / 255; % RGB values for #ED2129
input_color = [0.23, 0.27, 0.61];
% Define figure size
figure('Units', 'inches', 'Position', [1, 1, 16, 9]); % Width: 8 inches, Height: 6 inches


% Plot reference curve
plot(time_period, ref_curve, 'k-', 'LineWidth', 2);
hold on;

% Plot measured data with error bars
h1 = errorbar(time_period, measure_mean, measure_std, 'Marker', 'o', 'MarkerSize', 8, 'LineWidth', 1.8, 'Color', input_color);
h1.MarkerFaceColor = 'none'; % Set marker face color to 'none' for the blank center
h1.MarkerEdgeColor = input_color; % Set marker edge color for the outer markers
h1.LineStyle = 'none';
% Remove the end line of the error bar
h1.CapSize = 0;

% Plot tracked data with error bars
h2 = errorbar(time_period, track_mean, track_std, 'Marker', 's', 'MarkerSize', 8, 'LineWidth', 1.8, 'Color', track_color);
h2.MarkerFaceColor = 'none'; % Set marker face color to 'none' for the blank center
h2.MarkerEdgeColor = track_color; % Set marker edge color for the outer markers
h2.LineStyle = 'none';
h2.CapSize = 0;
% Customize the plot
xlabel('Time (ms)');
ylabel('Response (mV)');
%title('Measurement and Tracking');
legend('Ideal Response', 'Measurement', 'KF estimate', 'FontSize', 24, 'Box', 'off');
% Increase legend marker size
hL = findobj(gcf,'tag','legend');


grid on;
hold off;


% Adjust figure properties for publication quality
set(gca, 'FontSize', 14); % Increase font size
set(gca, 'LineWidth', 1.5); % Increase line width
set(gca, 'TickDir', 'in'); % Set tick direction
set(gca, 'Box', 'on'); % Remove box around the plot
set(gcf, 'Color', 'w'); % Set background color to white
xlim([0, 51]);
ylim([-240,240]);

print('KF_error_bar', '-dpng', '-r600'); % Specify the desired image format and resolution