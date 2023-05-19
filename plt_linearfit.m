% Load data from text files
close all;
inputData = load('sweep_input.txt');
measureData = load('sweep_measure.txt');

% Plot scatter plot
scatter(inputData, measureData, 'b', 'filled');  % Blue dots for input and measure

% Add labels and title
xlabel('Input');
ylabel('Measure');
title('Input and Measure');

% Set grid on
grid on;

% Find linear fit line
coefficients = polyfit(inputData, measureData, 1);
slope = coefficients(1);
intercept = coefficients(2);
fitLine = slope * inputData + intercept;

% Plot linear fit line
hold on;
plot(inputData, fitLine, 'r');  % Red line for the linear fit

% Display the slope
slopeText = sprintf('Slope: %.2f', slope);
text(max(inputData), max(measureData), slopeText, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'top');

% Add legend
legend('Data', 'Linear Fit');

% Hold off the plot
hold off;
