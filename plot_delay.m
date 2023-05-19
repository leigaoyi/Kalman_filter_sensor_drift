close all
clear

% Convert the hexadecimal color code to RGB values
track_color = [237, 33, 41] / 255; % RGB values for #ED2129
measure_color = [0.23, 0.27, 0.61];

figure('Units', 'inches', 'Position', [1, 1, 10, 7]); % Width: 6.5 inches, Height: 4.5 inches
ref_curve = load('./data/KF_ref_delay.txt');
delay0 = load('./data/KF_y_delay0.txt');
delay1 = load('./data/KF_y_delay1.txt');
delay2 = load('./data/KF_y_delay2.txt');
delay3 = load('./data/KF_y_delay3.txt');

show_num = 95;
time_axis = 0:1e-3:1e-3*(show_num-1);

% Plotting the reference curve with measure_color and increased linewidth
plot(time_axis, ref_curve(1:show_num), '-', 'Color', measure_color, 'LineWidth', 2.5);
hold on;

% Plotting delay0, delay1, delay2, and delay3 as dashed lines
plot(time_axis, delay0(1:show_num), '--', 'Color', [0.5, 0.5, 0.6], 'LineWidth', 2.5);
% plot(time_axis, delay1(1:show_num), '--', 'LineWidth', 1.5);
% plot(time_axis, delay2(1:show_num), '--', 'LineWidth', 1.5);
plot(time_axis, delay3(1:show_num), '--', 'Color', track_color, 'LineWidth', 2.5);

legend('Ideal Response', '\tau = 0', '\tau = 3', 'FontSize', 14, 'Box', 'off');
xlabel('Time (s)', 'FontSize', 12);
ylabel('Response (mV)', 'FontSize', 12);


% Set the number of grid lines you want on the x and y axes
numXGridLines = 3;
numYGridLines = 5;

% Adjust the tick positions and labels on the x-axis
xTickPositions = linspace(0.01, 0.09, numXGridLines);
set(gca, 'XTick', xTickPositions);

% Adjust the tick positions and labels on the y-axis
yTickPositions = linspace(-240, 240, numYGridLines);
set(gca, 'YTick', yTickPositions);


grid on;

%set(gca, 'FontName', 'Times New Roman', 'FontSize', 12);
xlim([0, 0.095]);

% Adjust figure properties for publication quality
set(gca, 'FontSize', 12); % Decrease font size slightly for publication
set(gca, 'LineWidth', 1.5); % Increase line width
set(gca, 'TickDir', 'in'); % Set tick direction
set(gcf, 'Color', 'w'); % Set background color to white

print('KF_track_delay', '-dpng', '-r600'); % Specify the desired image format and resolution

