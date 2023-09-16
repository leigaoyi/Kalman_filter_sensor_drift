close all
clear
clc

plot_num = 1000;
input_curve = load('../result/Input_unknown.txt')*9.2393;
track_input = load('../result/KF_track_in.txt')*9.2393;
track_knwon_input = load('../result/KF_y_delay8_startN0_145C_dampedSine.txt')/0.8072;

input_curve = input_curve(1:plot_num);
track_input  = track_input (1:plot_num);
track_knwon_input = track_knwon_input(1:plot_num);

time_axis = linspace(0, (length(input_curve)-1)*1e-3, length(input_curve));

distance = norm(input_curve-track_input);

% Convert the hexadecimal color code to RGB values
track_color = [237, 33, 41] / 255; % RGB values for #ED2129
input_color = [0.23, 0.27, 0.61];
track_known_color = [13, 141, 204]/255;
figure('Units', 'centimeters', 'Position', [2, 2, 16, 9]); % Adjust the figure size and position

hold on; % Enable holding multiple plots in the same figure
plot(time_axis, input_curve, 'k', 'LineWidth', 1.2); % Plot the input_curve with a linewidth of 2
hold on;
plot(time_axis, track_input, 'Color', track_color, 'LineWidth', 1.2); % Plot the track_input with a linewidth of 2
%scatter(time_axis(1:5:end), track_input (1:5:end), 'MarkerFaceColor', track_color, 'MarkerEdgeColor', track_color, 'SizeData', 6);
hold on;
a3 = plot(time_axis, track_knwon_input,'Color', 'b', 'LineWidth', 1.2); 
a3.Color(4) = 0.8;


hold off; % Disable holding multiple plots

% Add labels and title to the plot
xlabel('Time (s)', 'FontSize', 10); % Adjust font size
ylabel('Measurement (pT)', 'FontSize', 10); % Adjust font size
%title('Unknown Input Curve and Track Input', 'FontSize', 12); % Adjust font size and style

% Add grid to the plot
grid on;

% Set y-axis limits
ylim([-380, 360]);

% Adjust the legend position
legend('Applied Magnetic Filed', 'KF on Partially-known Signal','KF on Known Signal', 'Location', 'northeast','box','off','FontSize', 10);
%legend('boxoff');
% Get the handle to the legend
lgd = legend;

% Adjust the position of the legend
newLegendPosition = lgd.Position + [0, 0.04, 0, 0.00]; % Move slightly to the left
lgd.Position = newLegendPosition;

% Adjust the tick labels font size
set(gca, 'FontSize', 10);

% Adjust the line widths for better visibility in print
set(findobj(gca, 'Type', 'Line'), 'LineWidth', 1.2);

% Adjust the axes properties
ax = gca;
ax.LineWidth = 1.5;
ax.Box = 'on';

% Save the figure as a high-resolution image for the scientific paper
%print('../figures/plot_track_unknown_input', '-dpng', '-r300'); % Specify the desired image format and resolution
