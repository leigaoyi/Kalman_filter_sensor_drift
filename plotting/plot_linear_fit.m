close all;
clear


input_signal = 1000*load('../result/145C_large_sweep_x.txt')*9.2393/1000; % nT
output_signal = 1000*load('../result/145C_large_sweep_y.txt');
input_signal = input_signal(2:end); 
output_signal = output_signal(2:end);

% Set the figure size and position
figure('Units', 'centimeters', 'Position', [2, 2, 10, 8]);

% Plot the input-output relationship
plot(input_signal, output_signal, 'b','LineWidth', 1.5); % Adjust marker size, marker face color, and marker edge color
hold on;

% Add labels and title
xlabel('\deltaB_x (nT)', 'FontSize', 10); % Adjust font size
ylabel('Response (mV)', 'FontSize', 10); % Adjust font size
%title('Linear Fitting', 'FontSize', 12, 'FontWeight', 'bold'); % Adjust font size and add bold font weight

% Add legend
legend('Magnetic Response Curve', 'FontSize', 8, 'Box', 'off', 'Location', 'northwest'); % Adjust font size

% Customize grid appearance
grid on;
gridLineColor = [0.8, 0.8, 0.8]; % RGB values for grid line color
gridLineWidth = 0.5;
set(gca, 'GridColor', gridLineColor, 'LineWidth', gridLineWidth, 'FontSize', 8); % Adjust font size

% Adjust axis limits if needed
xlim([min(input_signal)-1.5, max(input_signal)+1.5]);
ylim([min(output_signal)-30, max(output_signal)+30]);


input_signal2 = 1000*load('../result/145C_small_sweep_x.txt')*9.2393;
output_signal2 = 1000*load('../result/145C_small_sweep_y.txt');
 



% Set the figure size and position
figure('Units', 'centimeters', 'Position', [2, 2, 10, 8]);

% Plot the input-output relationship
plot(input_signal2, output_signal2, 'ko','LineWidth', 1.5, 'MarkerSize', 6, 'MarkerFaceColor', 'w', 'MarkerEdgeColor', 'r'); % Adjust marker size, marker face color, and marker edge color
hold on;

% % Perform linear fitting
coefficients = polyfit(input_signal2, output_signal2, 1);
fit_line = polyval(coefficients, input_signal2);

% % Plot the linear fitting line
plot(input_signal2, fit_line, 'k-', 'LineWidth', 1.5); % Adjust line color and width

% Add labels and title
xlabel('\deltaB_x (pT)', 'FontSize', 10); % Adjust font size
ylabel('Response (mV)', 'FontSize', 10); % Adjust font size
%title('Linear Fitting', 'FontSize', 12, 'FontWeight', 'bold'); % Adjust font size and add bold font weight

% Add legend
legend('Experimental Data', 'Linear Fitting', 'FontSize', 8, 'Box', 'off', 'Location', 'northwest'); % Adjust font size

% Customize grid appearance
grid on;
gridLineColor = [0.8, 0.8, 0.8]; % RGB values for grid line color
gridLineWidth = 0.5;
set(gca, 'GridColor', gridLineColor, 'LineWidth', gridLineWidth, 'FontSize', 8); % Adjust font size

% Adjust axis limits if needed
% xlim([min(input_signal2)-1.5, max(input_signal2)+1.5]);
% ylim([min(output_signal2)-30, max(output_signal2)+30]);

% Set y-ticks in increments of 5
%yticks([-200,-100,0,100,200]);
%yticklabels(min(output_signal)-30:5:max(output_signal)+30);

% % Extract the slope
% % Extract the slope and intercept
% slope = coefficients(1);
% intercept = coefficients(2);

% disp(['The slope (k) of the linear line is: ' num2str(slope)]);
% disp(['The intercept (b) of the linear line is: ' num2str(intercept)]);
% print('../result/fig3', '-dpng', '-r600'); % Specify the desired image format and resolution
