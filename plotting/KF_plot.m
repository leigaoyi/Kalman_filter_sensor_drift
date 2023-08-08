clear
clc
close all
C1_sin_data = load('./paper_data/KF_y_30Hz.txt');
C1_cos_data = load('./paper_data/yMeasure_30Hz.txt');

% Convert the hexadecimal color code to RGB values
track_color = [237, 33, 41] / 255; % RGB values for #ED2129
measure_color = [0.23, 0.27, 0.61];

% Set the figure size and position
figure('Units', 'centimeters', 'Position', [2, 2, 10, 8]);

% Sampling frequency
fs = 1000;

% Convert data to time and voltage
[C1_sin_time, adc_data_voltage] = LabView_data_conversion(C1_sin_data, fs);
C1_sin_adc_data_voltage = adc_data_voltage;
[C1_cos_time, adc_data_voltage] = LabView_data_conversion(C1_cos_data, fs);
C1_cos_adc_data_voltage = adc_data_voltage;

% Plot Power Spectral Density (PSD)
figure(1);
[C1_sin_fout_1Hz, C1_sin_PSD_1Hz] = My_PSD(C1_sin_adc_data_voltage, fs);
semilogy(C1_sin_fout_1Hz, C1_sin_PSD_1Hz, 'LineWidth', 1.8, 'Color', track_color);
hold on;
[C1_cos_fout_1Hz, C1_cos_PSD_1Hz] = My_PSD(C1_cos_adc_data_voltage, fs);
semilogy(C1_cos_fout_1Hz, C1_cos_PSD_1Hz, 'LineWidth', 1.8, 'Color', measure_color);
hold off;

% Set x-axis limits and adjust the tick labels
xlim([1, 100]);
xticks([1, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100]);
xticklabels({'1', '10', '20', '30', '40', '50', '60', '70', '80', '90', '100'});

% Set y-axis limits and adjust the tick labels
ylim([0.9*1e-2, 3e2]);
yticks([1e-2,1e-1, 1e-0, 1e2]);
yticklabels({'10^{-2}','10^{-1}','10^{0}','10^{2}'});

% Add grid and labels
grid on;
xlabel('Frequency (Hz)', 'FontSize', 10);
ylabel('Amplitude (mV/Hz^{1/2})', 'FontSize', 10);

% Add legend
legend('KF estimate', 'Measurement', 'FontSize', 8,'box','off');

% Adjust the line widths for better visibility in print
set(findobj(gca, 'Type', 'Line'), 'LineWidth', 1.2);

% Adjust the axes properties
ax = gca;
ax.LineWidth = 0.8;
ax.Box = 'on';

% Adjust the tick labels font size
set(gca, 'FontSize', 8);

% Save the figure as a high-resolution image for the scientific paper
print('KF_track30Hz_sensitivity', '-dpng', '-r600'); % Specify the desired image format and resolution
