% Define the system matrices
A = [1 1; 0 1]; % State transition matrix
B = [0.5; 1];   % Control input matrix (if applicable)
H = [1 0];      % Measurement matrix

% Define the process and measurement noise covariances
Q = [0.01 0; 0 0.01]; % Process noise covariance
R = 0.1;              % Measurement noise covariance

% Initialize state and covariance matrices
x_hat = [0; 0];        % Initial state estimate [position; velocity]
P = eye(2);            % Initial state covariance matrix

% Simulate some measurements
true_state = [10; 2];  % True state [position; velocity]
num_steps = 1000;        % Number of time steps
measurements = H * true_state + sqrt(R) * randn(1, num_steps); % Simulated measurements

% Kalman filter loop
estimated_states = zeros(2, num_steps);
for k = 1:num_steps
    % Prediction step
    x_hat_minus = A * x_hat + B * 0; % Assuming no control input
    P_minus = A * P * A' + Q;

    % Update step
    K = P_minus * H' / (H * P_minus * H' + R);
    x_hat = x_hat_minus + K * (measurements(k) - H * x_hat_minus);
    P = (eye(2) - K * H) * P_minus;

    % Store the estimated state
    estimated_states(:, k) = x_hat;
end

% Plot the true state and estimated state
time_steps = 1:num_steps;
figure;
plot(time_steps, true_state(1) * ones(1, num_steps), 'b--', time_steps, measurements, 'ro', time_steps, estimated_states(1, :), 'g-');
xlabel('Time step');
ylabel('Position');
legend('True Position', 'Measurements', 'Estimated Position');
title('Kalman Filter - Position Estimation');


% Calculate the PSD of measurements and estimated states
fs = 1; % Sampling frequency (1 Hz in this case)
nfft = 2^nextpow2(num_steps); % Next power of 2 from the number of samples
freq = (0:nfft/2-1) * fs / nfft;

% PSD of measurements
[P_meas, f_meas] = pwelch(measurements, [], [], nfft, fs);

% PSD of estimated position
[P_est_pos, f_est_pos] = pwelch(estimated_states(1, :), [], [], nfft, fs);

% PSD of estimated velocity
[P_est_vel, f_est_vel] = pwelch(estimated_states(2, :), [], [], nfft, fs);

% Plot the PSD
figure;
semilogy(f_meas, P_meas);
hold on;
semilogy(f_est_pos, P_est_pos);
hold off;
xlabel('Frequency (Hz)');
ylabel('PSD');
title('Power Spectral Density - Measurements vs. Estimated Position');
legend('Measurements', 'Estimated Position');


