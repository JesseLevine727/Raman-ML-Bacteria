cd("Bacteria_Spectra 2.0\");

xAxisData = load('x-axis.mat');
x = xAxisData.X;

files = dir('*_Y.mat');

allYData = [];
        
for i = 1:numel(files)
    % Load Y-data from the current file
    filename = fullfile(files(i).folder, files(i).name);
    loadedData = load(filename);
    
    variableNames = fieldnames(loadedData);
    Y = loadedData.(variableNames{1});

    Q1_vals = quantile(Y, 0.25, 1);
    Q3_vals = quantile(Y, 0.75, 1);
    columnAve = mean(Y, 1);
    belowQ1 = Y < Q1_vals;
    aboveQ3 = Y > Q3_vals;

    for col = 1:size(Y, 2)
        Y(belowQ1(:, col), col) = columnAve(col);
        Y(aboveQ3(:, col), col) = columnAve(col);
    end

    LargestVal = max(Y(:));
    MinimumVal = min(Y(:));
    Y_normed = (Y - MinimumVal) ./ (LargestVal - MinimumVal);

    normy_Y = sprintf('%s_normed.csv',files(i).name(1:end-4));
    writematrix(Y_normed,normy_Y);

    allYData = [allYData; Y_normed]; %save all the 

    % Plot each row of the Y-data against the X-axis
    figure;  % Create a new figure for each file
    for row = 1:size(Y_normed, 1)
        plot(X, Y_normed(row, :));
        hold on;  % Hold on to plot multiple lines in the same figure
    end
    title('Min-Max Normalized',variableName);
    hold off;

    combinedcsvFileName = 'All_Y.csv';
    writematrix(allYData, combinedcsvFileName);
        

    
end