% Load data
close all
clc
clear

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

% Set the figure size and position
figure('Units', 'centimeters', 'Position', [2, 2, 16, 9]);

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
xlabel('Frequency (Hz)', 'FontSize', 12);
ylabel('Sensitivity (fT/Hz^{1/2})', 'FontSize', 12);
%title('Measurement and Tracking');
legend('Measurement Sensitivity', 'KF Estimate Sensitivity', 'FontSize', 8, 'Box', 'off');

% Adjust figure properties
grid on;
set(gca, 'FontSize', 10);
set(gca, 'LineWidth', 0.7);
set(gca, 'TickDir', 'in');
set(gca, 'Box', 'on');
set(gcf, 'Color', 'w');

xlim([19, 51]);
ylim([0, 36]);
text(0.98, 0.09, 'Quantum Noise Limit', 'Units', 'normalized', 'FontSize', 8, 'HorizontalAlignment', 'right');
% Annotations
%annotation('textbox', [0.15, 0.75, 0.1, 0.1], 'String', 'Data Source: XYZ', 'EdgeColor', 'none');

% Save the figure as a high-resolution image
%print('sensitivity_plot', '-dpng', '-r300');
print('../result/KF_sensitivity_errorBars', '-dpng', '-r600');






