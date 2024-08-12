data = readmatrix('PAO_Normalized_and_Outlier_Corrected_Data.csv');

x_axis = data(1, 1:end-1);
data_rows = data(2:end, 1:end-1);

figure;

plot(x_axis, data_rows');
title('Outlier Corrected & Min-Max Normalized C. striatum Spectra');
xlabel('Wavenumber (cm^{-1})');
ylabel('Normalized au');

