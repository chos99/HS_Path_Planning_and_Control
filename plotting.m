close all;

% Extract signals from the dataset
wp_signal = wp_yp_plot.get(1).Values;  % Assuming the reference position signal is the first element
yp_signal = wp_yp_plot.get(2).Values;  % Assuming the actual position signal is the second element

% Check the size of the signal data
wp_size = size(wp_signal.Data);
yp_size = size(yp_signal.Data);

wp_data = squeeze(wp_signal.Data);  % Removes the singleton dimensions
yp_data = squeeze(yp_signal.Data);  % Removes the singleton dimensions

% Open a new figure
figure(1), clf;

% Plot the signals
% Plotting the first dimension against the second
plot(wp_signal.Time, wp_data, yp_signal.Time, yp_data);
grid on;

% Set font sizes
fontSize = 14;  % You can adjust this value as needed

% Set labels and title with a custom font size
xlabel('Time (seconds)', 'FontSize', fontSize);
ylabel('m', 'FontSize', fontSize);
title('Reference position wp(t) and actual position yp(t)=𝑥(𝑡) for xManeuverEnd=0.5 and vmax=1', 'FontSize', fontSize);

% Add legend to clarify which line is which
legend('Reference position wp(t)', 'Actual position yp(t)');
