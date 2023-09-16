close all
clear
clc

figure('Units', 'centimeters', 'Position', [2, 2, 16, 18]); % Adjust the figure size and position


subplot(2, 1, 1); 
kresponse = 0.8072;
input_curve = load('../result/Measure_unknown.txt')/kresponse;
track_input = load('../result/KF_track_unknown_measure.txt')/kresponse;
time_axis = linspace(0, (length(input_curve)-1)*1e-3, length(input_curve));

distance = norm(input_curve-track_input);

% Convert the hexadecimal color code to RGB values
track_color = [237, 33, 41] / 255; % RGB values for #ED2129
input_color = [0.23, 0.27, 0.61];


hold on; % Enable holding multiple plots in the same figure
plot(time_axis, input_curve, 'Color', input_color, 'LineWidth', 1.5); % Plot the input_curve with a linewidth of 2
%plot(time_axis, track_input, 'Color', track_color, 'LineWidth', 1.5); % Plot the track_input with a linewidth of 2
scatter(time_axis(1:5:end), track_input(1:5:end), 'MarkerFaceColor', track_color, 'MarkerEdgeColor', track_color, 'SizeData', 6);


hold off; % Disable holding multiple plots

% Add labels and title to the plot
%xlabel('Time (s)', 'FontSize', 10); % Adjust font size
ylabel('Measurement (pT)', 'FontSize', 10); % Adjust font size
%title('Unknown Input Curve and Track Input', 'FontSize', 12); % Adjust font size and style
xticklabels({});
% Add grid to the plot
grid on;

% Set y-axis limits
ylim([-380, 330]);

% Adjust the legend position
legend('Measurement', 'KF estimate', 'Location', 'northeast','box','off','FontSize', 12);
%legend('boxoff');
% Get the handle to the legend
lgd1 = legend;

% Adjust the position of the legend
newLegendPosition = lgd1.Position + [-0.1, -0.05, 0.00, 0.00]; % Move slightly to the left
lgd1.Position = newLegendPosition;

% Adjust the tick labels font size
set(gca, 'FontSize', 10);

% Adjust the line widths for better visibility in print
%set(findobj(gca, 'Type', 'Line'), 'LineWidth', 1.5);

% Adjust the axes properties
ax = gca;
ax.LineWidth = 0.5;
ax.Box = 'on';

subplot(2, 1, 2); % Select the second subplot

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
%figure('Units', 'centimeters', 'Position', [2, 2, 16, 9]); % Adjust the figure size and position

hold on; % Enable holding multiple plots in the same figure
plot(time_axis, input_curve, 'k', 'LineWidth', 1.5); % Plot the input_curve with a linewidth of 2
hold on;
plot(time_axis, track_input, 'Color', track_color, 'LineWidth', 1.5); % Plot the track_input with a linewidth of 2
%scatter(time_axis(1:5:end), track_input (1:5:end), 'MarkerFaceColor', track_color, 'MarkerEdgeColor', track_color, 'SizeData', 6);
hold on;
a3 = plot(time_axis, track_knwon_input,'Color', 'b', 'LineWidth', 1.5); 
a3.Color(4) = 0.8;


hold off; % Disable holding multiple plots

% Add labels and title to the plot
xlabel('Time (s)', 'FontSize', 10); % Adjust font size
ylabel('Measurement (pT)', 'FontSize', 10); % Adjust font size
%title('Unknown Input Curve and Track Input', 'FontSize', 12); % Adjust font size and style

% Add grid to the plot
grid on;

% Set y-axis limits
ylim([-380, 320]);

% Adjust the legend position
legend('Applied Magnetic Filed', 'KF on Partially-known Signal','KF on Known Signal', 'Location', 'northeast','box','off','FontSize', 12);
%legend('boxoff');
% Get the handle to the legend
lgd = legend;

% Adjust the position of the legend
newLegendPosition = lgd.Position + [-0.03, 0.08, 0, 0.00]; % Move slightly to the left
lgd.Position = newLegendPosition;

% Adjust the tick labels font size
set(gca, 'FontSize', 10);

% Adjust the line widths for better visibility in print
%set(findobj(gca, 'Type', 'Line'), 'LineWidth', 1.2);

% Adjust the axes properties
ax = gca;
ax.LineWidth = 0.5;
ax.Box = 'on';

% Reduce the vertical spacing between the subplots
ax1 = subplot(2, 1, 1);
ax2 = subplot(2, 1, 2);
ax1.Position(2) = ax1.Position(2) - 0.05;
ax2.Position(4) = ax2.Position(4) + 0.06;
% Link the x-axis of both subplots
linkaxes([ax1, ax2], 'x');

%% add (a) , (b) lable
text(-0.07, 1.89, '(a)', 'Units', 'normalized', 'FontSize', 10, 'FontWeight', 'bold', 'HorizontalAlignment', 'right');
% Add label "(b)" outside the plot box
text(-0.07, 0.99, '(b)', 'Units', 'normalized', 'FontSize', 10, 'FontWeight', 'bold', 'HorizontalAlignment', 'right');


tightfig;

%print('../figures/Track_Unknown_twoFigures', '-dpng', '-r600'); % Specify the desired image format and resolution

