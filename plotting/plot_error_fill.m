close all
clear
clc

ref_load = load('../result/zRef_100epoch_mean.txt');
ref_curve = ref_load;
measure_mean = load('../result/yMeasure_100epoch_mean.txt');
measure_std = 1 * load('../result/yMeasure_100epoch_std.txt');
track_mean = load('../result/KF_y_100epoch_mean.txt');
track_std = 1 * load('../result/KF_y_100epoch_std.txt'); % 2 std


measure_mean = circshift(measure_mean, [3]); % 正值向右移，负值向左移
track_mean = circshift(track_mean, [0]);


kresponse = 0.8072 ; % 145C, mV/pT

measure_mean = abs(measure_mean - ref_curve)/kresponse;
track_mean = abs(track_mean - ref_curve)/kresponse;

measure_std = measure_std/kresponse;
track_std = track_std/kresponse;

time_period = 1:50; % Example range from 1 to 50
time_period = reshape(time_period, 1, 50);

% Convert the hexadecimal color code to RGB values
track_color = [237, 33, 41] / 255; % RGB values for #ED2129
measure_color = [0.23, 0.27, 0.61];

measure_lower = measure_mean - measure_std ;
measure_upper = measure_mean + measure_std ;

track_lower = track_mean - track_std ;
track_upper = track_mean + track_std ;

% Normalize the data
% rms_value = rms(ref_curve);
% ref_norm = ref_curve / rms_value;
% measure_norm = (measure_mean) / rms_value - ref_norm;
% track_norm = (track_mean) / rms_value - ref_norm;

% % Create vectors for filling the error areas
% measure_lower = measure_norm - measure_std / rms_value;
% measure_upper = measure_norm + measure_std / rms_value;
% track_lower = track_norm - track_std / rms_value;
% track_upper = track_norm + track_std / rms_value;

% mean(abs(measure_norm))
% mean(abs(track_norm))


measure_lower = reshape(measure_lower, 1, 50);
measure_upper = reshape(measure_upper, 1, 50);

track_lower = reshape(track_lower, 1, 50);
track_upper = reshape(track_upper, 1, 50);

a = cat(2, time_period, fliplr(time_period));
b = cat(2, measure_lower, fliplr(measure_upper));

% Plot the curves with error areas
fill(a, b, measure_color, 'FaceAlpha', 0.5, 'EdgeColor', measure_color);
hold on;
track_area = [track_lower, fliplr(track_upper)];
track_area = reshape(track_area, [1, 100]);
fill([time_period, fliplr(time_period)], track_area, track_color, 'FaceAlpha', 0.5, 'EdgeColor', track_color);
plot(time_period, measure_mean, 'LineWidth', 1.5, 'Color', measure_color);
plot(time_period, track_mean, 'LineWidth', 1.5, 'Color', track_color);

% Customize the plot
xlabel('Time (ms)', 'FontSize', 16);
ylabel('Residual Measurement (pT)', 'FontSize', 16);
legend('Measurement error', 'KF estimate error', 'FontSize', 14, 'Box', 'off');
grid on;
box on;
xlim([0.5, 50.5]);
%ylim([0, 0.7]); % Adjust the y-axis limits as needed
%yticks([-0.2,-0.1,0,0.1,0.2]);
% Adjust figure properties for publication quality
set(gca, 'FontSize', 16); % Decrease font size slightly for publication
set(gca, 'LineWidth', 1.5); % Increase line width
set(gca, 'TickDir', 'in'); % Set tick direction
set(gcf, 'Color', 'w'); % Set background color to white



