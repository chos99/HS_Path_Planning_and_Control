close all;

plot(psi_test)
% Extract signals from the dataset
t = psi_test.get(1).Values;  % Assuming the reference position signal is the first element
psi = psi_test.get(2).Values;  % Assuming the actual position signal is the second element

% Check the size of the signal data
wp_size = size(t.Data);
yp_size = size(psi.Data);

wp_data = squeeze(t.Data);  % Removes the singleton dimensions
yp_data = squeeze(psi.Data);  % Removes the singleton dimensions

% Open a new figure
figure(1), clf;

% Plot the signals
% Plotting the first dimension against the second
plot(t.Time, wp_data, psi.Time, yp_data);
grid on;

% Set font sizes
fontSize = 14;  % You can adjust this value as needed

% Set labels and title with a custom font size
xlabel('Time (seconds)', 'FontSize', fontSize);
ylabel('m', 'FontSize', fontSize);
title('Reference position wp(t) and actual position yp(t)=x(t) for xManeuverEnd=0.5 and vmax=1', 'FontSize', fontSize);

% Add legend to clarify which line is which
legend('Reference position wp(t)', 'Actual position yp(t)');
