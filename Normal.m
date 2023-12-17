%go to specified directory and open all files ending in '.mat'
cd("Bacteria Spectra\");
files =dir('*.mat');

Q1_vals = zeros(1,100);
%load each file, iterate through each file and extract x and y data
for i = 1:numel(files)
    filename = fullfile(files(i).folder,files(i).name);
    
    matContents = load(filename);

    variableNames = fieldnames(matContents);
    
    for j = 1:numel(variableNames)
        variableName = variableNames{j};
        
        struct = matContents.(variableName);

        cell = struct2cell(struct);
        Y = cell2mat(cell(3));
        Y = Y(:, 154 + 1:944);
      
        xStruct = cell{4};
        X = xStruct{2};
        X = X(154+1:944);
        
        Q1_vals = quantile(Y,0.25,1);
        
        Q3_vals = quantile(Y,0.75,1);
        columnAve = mean(Y);

        belowQ1 = Y < Q1_vals;
        aboveQ3 = Y > Q3_vals;

        for col = 1:size(Y,2)
            Y(belowQ1(:,col),col) = columnAve(col);
            Y(aboveQ3(:,col),col) = columnAve(col);
        end

        LargestVal = max(Y(:));
        disp(['Largest values for ', variableName, ' in file ', files(i).name, ':']);
        disp(LargestVal);

        Y = Y /LargestVal;
        
    end

    
    %plot each graph
    figure(i);
    plot(X,Y)
    fig = gcf;
    fig.Position = [((1920-800)/2), ((1080-600)/2), 800, 600]; % Adjust the width and height as needed
        

    title('Normalized',variableName);
    
        
end