% Define the file name containing Chinese characters
file_name = '20230321_sensor1_标定正弦30Hz_15点43mVrms';

% Read the file and extract the data columns
data = load(file_name);
col1 = data(:, 1);
col2 = data(:, 2);

cropCol1 = col1(1000:1300);
cropCol2 = col2(1000:1300);

Binput = cropCol2 * 1000 * 4.608; % V --> mV --> pT 

% Plot the input data
figure
plot(cropCol2, 'LineWidth', 2, 'Color', 'red')
title('Input Data')
ylabel('Voltage (V)')

% Plot the measured data
figure
plot(cropCol1, 'LineWidth', 2, 'Color', 'blue')
title('Measured Data')
xlabel('Column 1')
ylabel('Voltage (V)')

% Define the scaling factor and phase shift for the reference curve
Kscale = 337.2;
Phi = 0.0;

% Define the state transition matrix
A = 0;

% Define the control input matrix
B = 0.0064;

% Define the measurement matrix
D = Kscale;

% Define the process noise covariance matrix
Q = 0.05;

% Define the measurement noise covariance matrix
R = 3;

% Initialize the state vector
x = 0;

% Initialize the state covariance matrix
P = 1;

% Define the constant term matrices
C = 0;
E = Phi;
zPred = [];

yMeasure = cropCol1 * 1000; % V --> mV
BInput = Binput;

% Run the Kalman filter
for i = 1:length(BInput)
    u = BInput(i);
    z = yMeasure(i);
    
    % Predict the next state estimate and covariance
    x = A * x + B * u + C;
    P = A * P * A' + Q;
    
    % Update the state estimate and covariance using the measurement
    [x,~,P] = kalmanfilter(D,x,z,P,[],R);
    
    zPred(i) = D*x + E;
end

zPred = zPred(:);
zRef = 2.158 * BInput;

% Plot the predicted and reference curves
timeRange = (1/1000) * (1:length(BInput));
figure
plot(timeRange, zRef, 'LineWidth', 2, 'Color', 'blue')
hold on
plot(timeRange, zPred, 'o-', 'MarkerSize', 5, 'LineStyle', '-', 'Color', 'red', 'MarkerFaceColor', 'red', 'MarkerEdgeColor', 'none', 'MarkerIndices', 1:2:length(BInput))
hold off
xlabel('Time (s)')
ylabel('Amplitude (pT)')
title('Comparison of Predicted and Reference Curves')
legend('Reference', 'Prediction')
