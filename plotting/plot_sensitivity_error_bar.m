
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

% Plot measured data with error bars
h1 = errorbar(freq_range, measure_mean, measure_std, 'Marker', 's', 'MarkerSize', 8, 'LineWidth', 1.8);
h1.MarkerFaceColor = 'none'; % Set marker face color to 'none' for the blank center
%h1.MarkerEdgeColor = input_color; % Set marker edge color for the outer markers
h1.LineStyle = 'none';
% Remove the end line of the error bar
h1.CapSize = 0;
hold on;

% Plot tracked data with error bars
h2 = errorbar(freq_range, KF_mean, KF_std, 'Marker', 's', 'MarkerSize', 8, 'LineWidth', 1.8);
h2.MarkerFaceColor = 'none'; % Set marker face color to 'none' for the blank center
%h2.MarkerEdgeColor = track_color; % Set marker edge color for the outer markers
h2.LineStyle = 'none';
h2.CapSize = 0;
% Customize the plot
xlabel('Frequency (Hz)');
ylabel('Sensitivity (fT/Hz^{1/2})');
%title('Measurement and Tracking');
legend('Measurement Sensitivity', 'KF estimate Sensitivity', 'FontSize', 12, 'Box', 'off');
% Increase legend marker size
hL = findobj(gcf,'tag','legend');

grid off;
hold off;

% Adjust figure properties for publication quality
set(gca, 'FontSize', 14); % Increase font size
set(gca, 'LineWidth', 0.7); % Increase line width
set(gca, 'TickDir', 'in'); % Set tick direction
set(gca, 'Box', 'on'); % Remove box around the plot
set(gcf, 'Color', 'w'); % Set background color to white

xlim([19, 51]);
ylim([0,35]);


