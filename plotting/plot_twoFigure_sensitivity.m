close all
clear
clc

C1_sin_data = load('../result/yMeasure_delay8_145C_30Hz.txt');
C1_cos_data = load('../result/KF_y_delay8_145C_30Hz.txt');

% Convert the hexadecimal color code to RGB values
measure_color = [0.9294,0.1294,0.1608]; % RGB values for #ED2129
track_color = [0.23, 0.27, 0.61];

% Set the figure size and position
figure('Units', 'centimeters', 'Position', [2, 2, 16, 20]);

subplot(2, 1, 1); 

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
semilogy(C1_sin_fout_1Hz, C1_sin_PSD_1Hz, 'LineWidth', 1.5, 'Color', track_color);

hold on;
[C1_cos_fout_1Hz, C1_cos_PSD_1Hz] = My_PSD(C1_cos_adc_data_voltage, fs);
C1_cos_PSD_1Hz = C1_cos_PSD_1Hz / response_max * 100 * 1e3; %fT
semilogy(C1_cos_fout_1Hz, C1_cos_PSD_1Hz, 'LineWidth', 1.5, 'Color', measure_color);
hold on;


% Add the dashed line y = 1.8824
semilogy(C1_cos_fout_1Hz, 1.8824 * ones(size(C1_cos_fout_1Hz)), '--', 'LineWidth', 1.5, 'Color', 'k');

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
legend( 'Measurement','KF estimate', 'FontSize', 12,'box','off');

% Adjust the line widths for better visibility in print
set(findobj(gca, 'Type', 'Line'), 'LineWidth', 0.5);

% Adjust the axes properties
ax = gca;
ax.LineWidth = 0.5;
ax.Box = 'on';

% Adjust the tick labels font size
set(gca, 'FontSize', 10);
text(0.98, 0.09, 'Quantum Noise Limit', 'Units', 'normalized', 'FontSize', 10, 'HorizontalAlignment', 'right');
% Save the figure as a high-resolution image for the scientific paper

subplot(2, 1, 2); 

KF_mean = [6.2359	6.2605	6.1764	5.9655	5.2693	5.4951	5.8687
];
KF_std = [0.49411165	0.765431215	0.561017171	0.756930387	0.634260733	0.564037124	0.75863665
];

measure_mean = [27.506	28.667	27.282	27.062	23.999	24.67	26.45
];
measure_std = [2.790600095	2.671237957	2.930054228	3.614086022	2.783640502	2.598396942	3.528455753
];

freq_range = [20 25 30 35 40 45 50];

% Define custom colors
measurement_color = [0.9294,0.1294,0.1608];
kf_color = [0.23, 0.27, 0.61];


% Plot measured data with error bars
h1 = errorbar(freq_range, measure_mean, measure_std, 'Marker', 's', 'MarkerSize', 6, 'LineWidth', 1.8,'Color', measurement_color);
h1.MarkerFaceColor = measurement_color;
h1.LineStyle = 'none';
h1.CapSize = 0;
% m_color = [0.2, 0.4, 0.6, 0.5];
% set(h1.Edge, 'ColorBinding', 'interpolated', 'ColorData', uint8(255 * m_color));

hold on;

% Plot tracked data with error bars
h2 = errorbar(freq_range, KF_mean, KF_std, 'Marker', 's', 'MarkerSize', 6, 'LineWidth', 1.8,'Color', kf_color);
h2.MarkerFaceColor = kf_color;
h2.LineStyle = 'none';
h2.CapSize = 0;

hold on;
freq_axis = 1:52;
plot(freq_axis, 1.8824 * ones(size(freq_axis)), '--', 'LineWidth', 1.8, 'Color', 'k');

% Customize the plot
xlabel('Frequency (Hz)', 'FontSize', 10);
ylabel('Sensitivity (fT/Hz^{1/2})', 'FontSize', 10);
%title('Measurement and Tracking');
legend('Measurement Sensitivity', 'KF estimate Sensitivity', 'FontSize', 12, 'Box', 'off');

% Adjust figure properties
grid on;
set(gca, 'FontSize', 10);
set(gca, 'LineWidth', 0.5);
set(gca, 'TickDir', 'in');
set(gca, 'Box', 'on');
set(gcf, 'Color', 'w');

xlim([19, 51]);
ylim([0, 36]);
text(0.98, 0.09, 'Quantum Noise Limit', 'Units', 'normalized', 'FontSize', 10, 'HorizontalAlignment', 'right');
% Annotations
%annotation('textbox', [0.15, 0.75, 0.1, 0.1], 'String', 'Data Source: XYZ', 'EdgeColor', 'none');

% Reduce the vertical spacing between the subplots
ax1 = subplot(2, 1, 1);
ax2 = subplot(2, 1, 2);
ax1.Position(2) = ax1.Position(2) - 0.02;
ax2.Position(4) = ax2.Position(4) + 0.04;
% Link the x-axis of both subplots
%linkaxes([ax1, ax2], 'x');

%% add (a) , (b) lable
text(-0.06, 2.09, '(a)', 'Units', 'normalized', 'FontSize', 10, 'FontWeight', 'bold', 'HorizontalAlignment', 'right');
% Add label "(b)" outside the plot box
text(-0.06, 0.99, '(b)', 'Units', 'normalized', 'FontSize', 10, 'FontWeight', 'bold', 'HorizontalAlignment', 'right');

tightfig;

print('../figures/sensitivity_twoFigure_plot', '-dpng', '-r300');
