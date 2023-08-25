clear
clc
close all


N = 9;
filename1 = sprintf('../result/yMeasure_delay8_startN%d_135C_50Hz.txt', N);
filename2 = sprintf('../result/KF_y_delay8_startN%d_135C_50Hz.txt', N);

C1_sin_data = load(filename1);
C1_cos_data = load(filename2);

% Convert the hexadecimal color code to RGB values
measure_color = [0.9294,0.1294,0.1608]; % RGB values for #ED2129
track_color = [0.23, 0.27, 0.61];

% Set the figure size and position
figure('Units', 'centimeters', 'Position', [2, 2, 18, 16]);

% Sampling frequency
fs = 1000;

% Convert data to time and voltage
[C1_sin_time, adc_data_voltage] = LabView_data_conversion(C1_sin_data, fs);
C1_sin_adc_data_voltage = adc_data_voltage;
[C1_cos_time, adc_data_voltage] = LabView_data_conversion(C1_cos_data, fs);
C1_cos_adc_data_voltage = adc_data_voltage;

% response_max = max(C1_sin_adc_data_voltage);
% C1_sin_voltage = C1_sin_adc_data_voltage ./ response_max * 100 * 1e3 ; % fT
% C1_cos_voltage = C1_cos_adc_data_voltage ./ response_max * 100 * 1e3 ;


% Plot Power Spectral Density (PSD)
figure(1);
[C1_sin_fout_1Hz, C1_sin_PSD_1Hz] = My_PSD(C1_sin_adc_data_voltage, fs);
response_max = max(C1_sin_PSD_1Hz);
C1_sin_PSD_1Hz = C1_sin_PSD_1Hz / response_max * 100 * 1e3; %fT
semilogy(C1_sin_fout_1Hz, C1_sin_PSD_1Hz, 'LineWidth', 1.8, 'Color', track_color);

hold on;
[C1_cos_fout_1Hz, C1_cos_PSD_1Hz] = My_PSD(C1_cos_adc_data_voltage, fs);
C1_cos_PSD_1Hz = C1_cos_PSD_1Hz / response_max * 100 * 1e3; %fT
semilogy(C1_cos_fout_1Hz, C1_cos_PSD_1Hz, 'LineWidth', 1.8, 'Color', measure_color);
hold on;


% Add the dashed line y = 1.8824
semilogy(C1_cos_fout_1Hz, 1.8824 * ones(size(C1_cos_fout_1Hz)), '--', 'LineWidth', 1.8, 'Color', 'k');

hold off;

% Set x-axis limits and adjust the tick labels
xlim([1, 100]);
xticks([1, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100]);
xticklabels({'1', '10', '20', '30', '40', '50', '60', '70', '80', '90', '100'});

% Set y-axis limits and adjust the tick labels
% ylim([0.9*1e-2, 3e2]);
% yticks([1e-3,1e-1, 1e-0, 1e2]);
% yticklabels({'10^{-3}','10^{-1}','10^{0}','10^{2}'});

% Add grid and labels
grid on;
xlabel('Frequency (Hz)', 'FontSize', 10);
ylabel('Sensitivity (fT/Hz^{1/2})', 'FontSize', 10);

% Add legend
legend( 'Measurement','KF estimate', 'FontSize', 8,'box','off');

% Adjust the line widths for better visibility in print
set(findobj(gca, 'Type', 'Line'), 'LineWidth', 1.2);

% Adjust the axes properties
ax = gca;
ax.LineWidth = 0.8;
ax.Box = 'on';

% Adjust the tick labels font size
set(gca, 'FontSize', 8);
text(0.98, 0.09, 'Quantum Noise Limit', 'Units', 'normalized', 'FontSize', 8, 'HorizontalAlignment', 'right');
% Save the figure as a high-resolution image for the scientific paper
%print('../result/KF_track30Hz_sensitivity', '-dpng', '-r600'); % Specify the desired image format and resolution
