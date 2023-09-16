close all
clear
clc

% Load data, mV--> pT
input_curve = load('../result/ZRef_145C_MCG.txt') / 0.8072;
KF_track_input = load('../result/KF_y_delay4_startN0_145C_MCG.txt') / 0.8072;
ymeasure = load('../result/yMeasure_delay4_startN0_145C_MCG.txt') / 0.8072;
time_axis = linspace(0, (length(input_curve)-1)*1e-3, length(input_curve));

% Define colors
track_color = [237, 33, 41] / 255; % RGB values for #ED2129
input_color = [0.23, 0.27, 0.61];

% Create figure
fig = figure('Units', 'centimeters', 'Position', [2, 2, 16, 9]);
hold on;

% Plot curves
plot(time_axis, input_curve, 'k', 'LineWidth', 1.5);
plot(time_axis, KF_track_input, 'Color', track_color, 'LineWidth', 1.5);
plot(time_axis, ymeasure, 'Color', input_color,  'LineWidth', 1.5); % Use black color for measurements

hold off;

% Labels and title
xlabel('Time (s)', 'FontSize', 10);
ylabel('Measurement (pT)', 'FontSize', 10);
%title('System Response', 'FontSize', 12, 'FontWeight', 'bold');

% Grid and legend
grid on;
legend('Applied Magntic Field', 'KF estimate', 'Measurement', 'FontSize', 12, 'Location', 'northeast','box','off');

% Get the handle to the legend
lgd = legend;

% Adjust the position of the legend
newLegendPosition = lgd.Position + [-0.13, 0, 0, 0]; % Move slightly to the left
lgd.Position = newLegendPosition;

% Adjust axes properties
ax = gca;
%ax.FontSize = 8;
ax.LineWidth = 0.5;
ax.Box = 'on';
%ax.YLim = [-30, 30]; % Adjust the y-axis limits for better visualization
tightfig;
% % Save the figure as high-resolution images for the scientific paper
%print('plot_system_response', '-depsc', '-r300'); % Save as EPS format for vector quality
 print('../figures/plot_MCG', '-dpng', '-r300'); % Save as PNG for bitmap

% Calculate signal power
signal_power = mean(input_curve.^2);

% Calculate noise power for KF estimate
noise_power_KF = signal_power - mean(KF_track_input.^2);

% Calculate noise power for measurements
noise_power_measure = signal_power - mean(ymeasure.^2);

% Calculate SNR for KF estimate and measurements
SNR_KF = 10 * log10(signal_power / noise_power_KF);
SNR_Measure = 10 * log10(signal_power / noise_power_measure);

% Display the calculated SNR values
fprintf('SNR for KF estimate: %.2f dB\n', SNR_KF);
fprintf('SNR for Measurements: %.2f dB\n', SNR_Measure);

MaxMin_meausre = max(ymeasure) - min(ymeasure)
MaxMin_estiamte = max(KF_track_input) - min(KF_track_input)
MaxMin_ref = max(input_curve) - min(input_curve)



