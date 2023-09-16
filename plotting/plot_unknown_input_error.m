close all;
clear

plot_num = 1000;
input_curve = load('../result/Input_unknown.txt')*9.2393;
track_input = load('../result/KF_track_in.txt')*9.2393;
track_knwon_input = load('../result/KF_y_delay3_startN0_145C_dampedSine.txt')/0.8072;

input_curve = input_curve(1:plot_num);
track_input  = track_input (1:plot_num);
track_knwon_input = track_knwon_input(1:plot_num);

time_axis = linspace(0, (length(input_curve)-1)*1e-3, length(input_curve));

distance = norm(input_curve-track_input);

% Convert the hexadecimal color code to RGB values
track_color = [237, 33, 41] / 255; % RGB values for #ED2129
input_color = [0.23, 0.27, 0.61];
track_known_color = [13, 141, 204]/255;


diff = input_curve - track_input;
diff2 = input_curve - track_knwon_input;
time_axis = linspace(0, (length(diff)-1)*1e-3, length(diff));


figure('Units', 'centimeters', 'Position', [2, 2, 16, 9]);
%plot(diff);
plot(time_axis, diff, 'Color',track_color, 'LineWidth', 1.5);
hold on;
%plot(diff2);
plot(time_axis, diff2, 'Color',input_color, 'LineWidth', 1.5);
hold off;

% Add labels and title to the plot
xlabel('Time (s)', 'FontSize', 10); % Adjust font size
ylabel('Measurement Error (pT)', 'FontSize', 10); % Adjust font size
%title('Unknown Input Curve and Track Input', 'FontSize', 12); % Adjust font size and style
% Add grid to the plot
grid on;

legend('KF estimate error on Partially-Known Signal', 'KF estimate error on Known Signal', 'Location', 'northeast','box','off','FontSize', 10);

% Adjust the axes properties
ax = gca;
ax.LineWidth = 0.5;
ax.Box = 'on';


figure('Units', 'centimeters', 'Position', [2, 2, 16, 9]);

KF_known_curve = load('../result/KF_known_100epoch_std.txt')/0.8072;
KF_unknown_curve = load('../result/KF_unknown_100epoch_std.txt')/0.8072;
y_unknown_curve = load('../result/KF_unknown_y_100epoch_std.txt')/0.8072;
time_axis = linspace(0, (length(KF_known_curve)-1)*1e-3, length(KF_known_curve));

%plot(KF_known_curve);
plot(time_axis, KF_known_curve, 'Color',input_color, 'LineWidth', 1.5);
hold on;
%plot(KF_unknown_curve);
plot(time_axis, KF_unknown_curve, 'Color',track_color, 'LineWidth', 1.5);
hold on;
%plot(y_unknown_curve);
plot(time_axis, y_unknown_curve, 'k', 'LineWidth', 1.5);
hold off;

% Add labels and title to the plot
xlabel('Time (s)', 'FontSize', 10); % Adjust font size
ylabel('Measurement Uncertainty (pT)', 'FontSize', 10); % Adjust font size
%title('Unknown Input Curve and Track Input', 'FontSize', 12); % Adjust font size and style
% Add grid to the plot
grid on;

legend('KF estimate uncertainty on known signal', 'KF estimate uncertainty on partially-known signal', 'measure uncertainty', 'Location', 'northeast','box','off','FontSize', 10);

% Adjust the axes properties
ax = gca;
ax.LineWidth = 0.5;
ax.Box = 'on';

