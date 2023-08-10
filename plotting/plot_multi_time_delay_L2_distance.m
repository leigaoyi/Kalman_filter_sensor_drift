clear
clc
close all

% Load data
C1_Ref = load('../result/ZRef_145C.txt');
C1_delays = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9,10,11, 12];

% Initialize array to store L2 norm distances
L2_distances = zeros(size(C1_delays));
count_num = 150;
kslope = 7.45818; %mV/mV, 9.2393 pT/mV
kresponse = kslope/9.2393 ; % mV/pT
% Calculate L2 norm distances
for i = 1:length(C1_delays)
    delay = C1_delays(i);
    filename = sprintf('../result/KF_y_delay%d_145C_20Hz.txt', delay);
    C1_delay = load(filename);
    C1_delay = C1_delay(1:count_num);
    C1_Ref = C1_Ref(1:count_num);
    L2_distances(i) = norm(C1_delay - C1_Ref, 2)/count_num/kresponse;
end

% Create and customize the plot
figure('Units', 'centimeters', 'Position', [2, 2, 10, 8]);
plot(C1_delays, L2_distances, 'o-'); % You can adjust the marker style as needed
xlabel('\tau (ms)', 'FontSize', 10);
ylabel('mean L2 Norm Distance (pT)', 'FontSize', 10);
%title('L2 Norm Distance vs. Delay');
grid on;
% Adjust figure properties for publication quality
set(gca, 'FontSize', 8); % Decrease font size slightly for publication
set(gca, 'LineWidth', 1.5); % Increase line width
set(gca, 'TickDir', 'in'); % Set tick direction
set(gcf, 'Color', 'w'); % Set background color to white


% Optionally, adjust axis limits if needed
% xlim([min(C1_delays) - 1, max(C1_delays) + 1]);
% ylim([min(L2_distances) - 1, max(L2_distances) + 1]);

% Display the plot
%show;
