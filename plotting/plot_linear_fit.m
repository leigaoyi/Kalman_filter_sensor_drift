close all;
clear

output_signal = 1000*[-0.21333163, -0.19551727, -0.16902607, -0.13298353, -0.09805645, -0.06653739, -0.03396135, -0.00069394, 0.03189366, 0.06463162, 0.09472103, 0.12440308, 0.15536378, 0.18118032, 0.20497607, 0.22515883];
input_signal = 1000*[-0.02397438, -0.02054708, -0.01747318, -0.01418403, -0.01105037, -0.00779206, -0.00464684, -0.00139431, 0.00175349, 0.00500858, 0.00814738, 0.01141726, 0.01453293, 0.0178375, 0.02087863, 0.0243644];

% Set the figure size and position
figure('Units', 'centimeters', 'Position', [2, 2, 10, 8]);

% Plot the input-output relationship
plot(input_signal, output_signal, 'ko','LineWidth', 1.5, 'MarkerSize', 6, 'MarkerFaceColor', 'w', 'MarkerEdgeColor', 'r'); % Adjust marker size, marker face color, and marker edge color
hold on;

% Perform linear fitting
coefficients = polyfit(input_signal, output_signal, 1);
fit_line = polyval(coefficients, input_signal);

% Plot the linear fitting line
plot(input_signal, fit_line, 'b-', 'LineWidth', 1.5); % Adjust line color and width

% Add labels and title
xlabel('\deltaB_x (mV)', 'FontSize', 10); % Adjust font size
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
xlim([min(input_signal)-1.5, max(input_signal)+1.5]);
ylim([min(output_signal)-30, max(output_signal)+30]);

% Set y-ticks in increments of 5
yticks([-200,-100,0,100,200]);
%yticklabels(min(output_signal)-30:5:max(output_signal)+30);

% Extract the slope
% Extract the slope and intercept
slope = coefficients(1);
intercept = coefficients(2);

disp(['The slope (k) of the linear line is: ' num2str(slope)]);
disp(['The intercept (b) of the linear line is: ' num2str(intercept)]);
print('./result/fig3', '-dpng', '-r600'); % Specify the desired image format and resolution
