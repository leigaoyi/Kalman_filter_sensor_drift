close all
clear

% Convert the hexadecimal color code to RGB values

kslope = 7.45818; %mV/mV, 9.2393 pT/mV
kresponse = kslope/9.2393 ; % mV/pT

delay3_color = [251, 83, 82]/255;
delay1_color = [254, 199, 107]/255;
delay0_color = [2, 46, 89]/255;
curve_color = [12, 143, 215]/255;


figure('Units', 'centimeters', 'Position', [2, 2, 10, 8]);
ref_curve = load('../result/ZRef_145C.txt');
delay0 = load('../result/KF_y_delay0_145C_20Hz.txt');
delay1 = load('../result/KF_y_delay4_145C_20Hz.txt');
%delay2 = load('../result/KF_y_delay6_145C_20Hz.txt');
delay3 = load('../result/KF_y_delay8_145C_20Hz.txt');

ref_curve = ref_curve/kresponse;
delay0 = delay0/kresponse;
delay1 = delay1/kresponse;
delay3 = delay3/kresponse;

show_num = 150;
time_axis = 0:1:1*(show_num-1);

% Plotting the reference curve with measure_color and increased linewidth
plot(time_axis, ref_curve(1:show_num), '-', 'Color', curve_color, 'LineWidth', 1.5);
hold on;

% Plotting delay0, delay1, delay2, and delay3 as dashed lines
plot(time_axis, delay0(1:show_num), '--', 'Color', delay0_color, 'LineWidth', 1.5);
plot(time_axis, delay1(1:show_num), '--','Color', delay1_color, 'LineWidth', 1.5);
% plot(time_axis, delay2(1:show_num), '--', 'LineWidth', 1.5);
plot(time_axis, delay3(1:show_num), '--', 'Color', delay3_color, 'LineWidth', 1.5);

legend('Ref', '\tau = 0', '\tau = 4','\tau = 8', 'FontSize', 8, 'Box', 'off' ,'Location', 'southeast');
xlabel('Time (ms)', 'FontSize', 10);
ylabel('Measurement (pT)', 'FontSize', 10);


% Set the number of grid lines you want on the x and y axes
numXGridLines = 7;
numYGridLines = 5;

% Adjust the tick positions and labels on the x-axis
xTickPositions = linspace(0, 150, numXGridLines);
set(gca, 'XTick', xTickPositions);

% Adjust the tick positions and labels on the y-axis
yTickPositions = linspace(-130, 130, numYGridLines);
set(gca, 'YTick', yTickPositions);


grid on;

%set(gca, 'FontName', 'Times New Roman', 'FontSize', 12);
%xlim([0, 94]);

% Adjust figure properties for publication quality
set(gca, 'FontSize', 8); % Decrease font size slightly for publication
set(gca, 'LineWidth', 0.7); % Increase line width
set(gca, 'TickDir', 'in'); % Set tick direction
set(gcf, 'Color', 'w'); % Set background color to white

print('KF_track_delay', '-dpng', '-r600'); % Specify the desired image format and resolution

