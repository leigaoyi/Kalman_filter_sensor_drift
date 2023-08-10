clear
clc
close all
C1_Ref = load('../result/ZRef_145C.txt');
C1_delay0 = load('../result/KF_y_delay0_145C_20Hz.txt');
C1_delay1 = load('../result/KF_y_delay1_145C_20Hz.txt');
C1_delay2 = load('../result/KF_y_delay2_145C_20Hz.txt');
C1_delay3 = load('../result/KF_y_delay3_145C_20Hz.txt');
C1_delay4 = load('../result/KF_y_delay4_145C_20Hz.txt');
C1_delay5 = load('../result/KF_y_delay5_145C_20Hz.txt');
C1_delay6 = load('../result/KF_y_delay6_145C_20Hz.txt');
C1_delay7 = load('../result/KF_y_delay7_145C_20Hz.txt');
C1_delay8 = load('../result/KF_y_delay8_145C_20Hz.txt');
C1_delay9 = load('../result/KF_y_delay9_145C_20Hz.txt');
C1_delay12 = load('../result/KF_y_delay12_145C_20Hz.txt');
C1_delay20 = load('../result/KF_y_delay20_145C_20Hz.txt');

%C1_L2_delay0 = L2_norm(C1_delay0, C1_Ref);


delay0_color = [2, 46, 89]/255;
delay1_color = [254, 199, 107]/255;
delay3_color = [251, 83, 82]/255;


% Convert the hexadecimal color code to RGB values
measure_color = [0.9294,0.1294,0.1608]; % RGB values for #ED2129
track_color = [0.23, 0.27, 0.61];

% Set the figure size and position
figure('Units', 'centimeters', 'Position', [2, 2, 10, 8]);

% Sampling frequency
fs = 1000;
figure(1);
% Convert data to time and voltage
[C1_sin_time, C1_delay0_data] = LabView_data_conversion(C1_delay0, fs);
[C1_sin_fout_1Hz, C1_delay0_1Hz] = My_PSD(C1_delay0_data, fs);
response_max = max(C1_delay0_1Hz);
C1_sin_delay0_PSD_1Hz = C1_delay0_1Hz / response_max * 100 * 1e3; %fT
semilogy(C1_sin_fout_1Hz, C1_sin_delay0_PSD_1Hz, 'LineWidth', 1.8,'Color',delay0_color);
hold on;

% % Convert data to time and voltage
% [C1_sin_time, C1_delay1_data] = LabView_data_conversion(C1_delay1, fs);
% [C1_sin_fout_1Hz, C1_delay1_1Hz] = My_PSD(C1_delay1_data, fs);
% C1_sin_delay1_PSD_1Hz = C1_delay1_1Hz / response_max * 100 * 1e3; %fT
% semilogy(C1_sin_fout_1Hz, C1_sin_delay1_PSD_1Hz, 'LineWidth', 1.8,'Color',delay1_color);
% hold on;
% 
% % Convert data to time and voltage
% [C1_sin_time, C1_delay2_data] = LabView_data_conversion(C1_delay2, fs);
% [C1_sin_fout_1Hz, C1_delay2_1Hz] = My_PSD(C1_delay2_data, fs);
% C1_sin_delay2_PSD_1Hz = C1_delay2_1Hz / response_max * 100 * 1e3; %fT
% semilogy(C1_sin_fout_1Hz, C1_sin_delay2_PSD_1Hz, 'LineWidth', 1.8);
% hold on;
% 
% % Convert data to time and voltage
% [C1_sin_time, C1_delay3_data] = LabView_data_conversion(C1_delay3, fs);
% [C1_sin_fout_1Hz, C1_delay3_1Hz] = My_PSD(C1_delay3_data, fs);
% C1_sin_delay3_PSD_1Hz = C1_delay3_1Hz / response_max * 100 * 1e3; %fT
% semilogy(C1_sin_fout_1Hz, C1_sin_delay3_PSD_1Hz, 'LineWidth', 1.8,'Color',delay3_color);
% hold on;

% Convert data to time and voltage
[C1_sin_time, C1_delay4_data] = LabView_data_conversion(C1_delay4, fs);
[C1_sin_fout_1Hz, C1_delay4_1Hz] = My_PSD(C1_delay4_data, fs);
C1_sin_delay4_PSD_1Hz = C1_delay4_1Hz / response_max * 100 * 1e3; %fT
semilogy(C1_sin_fout_1Hz, C1_sin_delay4_PSD_1Hz, 'LineWidth', 1.8);
hold on;

% Convert data to time and voltage
[C1_sin_time, C1_delay5_data] = LabView_data_conversion(C1_delay5, fs);
[C1_sin_fout_1Hz, C1_delay5_1Hz] = My_PSD(C1_delay5_data, fs);
C1_sin_delay5_PSD_1Hz = C1_delay5_1Hz / response_max * 100 * 1e3; %fT
semilogy(C1_sin_fout_1Hz, C1_sin_delay5_PSD_1Hz, 'LineWidth', 1.8);
hold on;
% Convert data to time and voltage
[C1_sin_time, C1_delay6_data] = LabView_data_conversion(C1_delay6, fs);
[C1_sin_fout_1Hz, C1_delay6_1Hz] = My_PSD(C1_delay6_data, fs);
C1_sin_delay6_PSD_1Hz = C1_delay6_1Hz / response_max * 100 * 1e3; %fT
semilogy(C1_sin_fout_1Hz, C1_sin_delay6_PSD_1Hz, 'LineWidth', 1.8);
hold on;

% Convert data to time and voltage
[C1_sin_time, C1_delay7_data] = LabView_data_conversion(C1_delay7, fs);
[C1_sin_fout_1Hz, C1_delay7_1Hz] = My_PSD(C1_delay7_data, fs);
C1_sin_delay7_PSD_1Hz = C1_delay7_1Hz / response_max * 100 * 1e3; %fT
semilogy(C1_sin_fout_1Hz, C1_sin_delay7_PSD_1Hz, 'LineWidth', 1.8);
hold on;
% Convert data to time and voltage
[C1_sin_time, C1_delay8_data] = LabView_data_conversion(C1_delay8, fs);
[C1_sin_fout_1Hz, C1_delay8_1Hz] = My_PSD(C1_delay8_data, fs);
C1_sin_delay8_PSD_1Hz = C1_delay8_1Hz / response_max * 100 * 1e3; %fT
semilogy(C1_sin_fout_1Hz, C1_sin_delay8_PSD_1Hz, 'LineWidth', 1.8);
hold on;

% Convert data to time and voltage
[C1_sin_time, C1_delay9_data] = LabView_data_conversion(C1_delay9, fs);
[C1_sin_fout_1Hz, C1_delay9_1Hz] = My_PSD(C1_delay9_data, fs);
C1_sin_delay9_PSD_1Hz = C1_delay9_1Hz / response_max * 100 * 1e3; %fT
semilogy(C1_sin_fout_1Hz, C1_sin_delay9_PSD_1Hz, 'LineWidth', 1.8);
hold on;

% Convert data to time and voltage
[C1_sin_time, C1_delay12_data] = LabView_data_conversion(C1_delay12, fs);
[C1_sin_fout_1Hz, C1_delay12_1Hz] = My_PSD(C1_delay12_data, fs);
C1_sin_delay12_PSD_1Hz = C1_delay12_1Hz / response_max * 100 * 1e3; %fT
semilogy(C1_sin_fout_1Hz, C1_sin_delay12_PSD_1Hz, 'LineWidth', 1.8);

hold on;



% response_max = max(C1_sin_adc_data_voltage);
% C1_sin_voltage = C1_sin_adc_data_voltage ./ response_max * 100 * 1e3 ; % fT
% C1_cos_voltage = C1_cos_adc_data_voltage ./ response_max * 100 * 1e3 ;

hold off;
% Plot Power Spectral Density (PSD)
% 
% [C1_sin_fout_1Hz, C1_sin_delay0_PSD_1Hz] = My_PSD(C1_sin_adc_data_voltage, fs);
% response_max = max(C1_sin_delay0_PSD_1Hz);
% C1_sin_delay0_PSD_1Hz = C1_sin_delay0_PSD_1Hz / response_max * 100 * 1e3; %fT
% semilogy(C1_sin_fout_1Hz, C1_sin_delay0_PSD_1Hz, 'LineWidth', 1.8, 'Color', track_color);
% hold on;
% 
% [C1_cos_fout_1Hz, C1_cos_PSD_1Hz] = My_PSD(C1_cos_adc_data_voltage, fs);
% C1_cos_PSD_1Hz = C1_cos_PSD_1Hz / response_max * 100 * 1e3; %fT
% semilogy(C1_cos_fout_1Hz, C1_cos_PSD_1Hz, 'LineWidth', 1.8, 'Color', measure_color);
% hold on;


% Add the dashed line y = 1.8824
%semilogy(C1_cos_fout_1Hz, 1.8824 * ones(size(C1_cos_fout_1Hz)), '--', 'LineWidth', 1.8, 'Color', 'magenta');


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
legend( '\tau = 0','\tau = 4','\tau = 5','\tau = 6','\tau=7','\tau = 8','\tau = 9','\tau=12','FontSize', 8,'box','off');

% Adjust the line widths for better visibility in print
set(findobj(gca, 'Type', 'Line'), 'LineWidth', 1.2);

% Adjust the axes properties
ax = gca;
ax.LineWidth = 0.8;
ax.Box = 'on';

% Adjust the tick labels font size
set(gca, 'FontSize', 8);

% Save the figure as a high-resolution image for the scientific paper
print('../result/KF_track30Hz_sensitivity', '-dpng', '-r600'); % Specify the desired image format and resolution
