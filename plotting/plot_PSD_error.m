clear
clc
close all
C1_sin_data = load('../result/yMeasure_delay8_145C_30Hz.txt');
C1_cos_data = load('../result/KF_y_delay8_145C_30Hz.txt');

% Convert the hexadecimal color code to RGB values
measure_color = [0.9294,0.1294,0.1608]; % RGB values for #ED2129
track_color = [0.23, 0.27, 0.61];

% Set the figure size and position

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

[C1_sin_fout_1Hz, C1_sin_PSD_1Hz] = My_PSD(C1_sin_adc_data_voltage, fs);
response_max = max(C1_sin_PSD_1Hz);
C1_sin_PSD_1Hz = C1_sin_PSD_1Hz / response_max * 100 * 1e3; %fT
%semilogy(C1_sin_fout_1Hz, C1_sin_PSD_1Hz, 'LineWidth', 1.5, 'Color', track_color);

[C1_cos_fout_1Hz, C1_cos_PSD_1Hz] = My_PSD(C1_cos_adc_data_voltage, fs);
C1_cos_PSD_1Hz = C1_cos_PSD_1Hz / response_max * 100 * 1e3; %fT

figure('Units', 'centimeters', 'Position', [2, 2, 16, 9]); % Adjust the figure size and position


residual_data = C1_sin_PSD_1Hz - C1_cos_PSD_1Hz;
plot(residual_data,'k', 'LineWidth', 1.5);
xlim([1, 100]);
% Add labels and title to the plot
xlabel('Frequency (Hz)', 'FontSize', 10); % Adjust font size
ylabel('Sensitivity Improvement (fT/Hz^{1/2})', 'FontSize', 10); % Adjust font size
% Adjust the line widths for better visibility in print
title('Sensitivity Difference of Blue curve and Red Curve','FontSize', 12);
%set(findobj(gca, 'Type', 'Line'), 'LineWidth', 0.5);

grid;
% Adjust the axes properties
ax = gca;
ax.LineWidth = 0.8;
ax.Box = 'on';


% figure;
% semilogy(residual_data);
% xlim([1,100]);
