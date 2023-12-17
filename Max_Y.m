%go to specified directory and open all files ending in '.mat'
cd("Bacteria Spectra\");
files =dir('*.mat');

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

        LargestVal = max(Y(:));

        disp(['Largest values for ', variableName, ' in file ', files(i).name, ':']);
        disp(LargestVal);
    end
    
    %plot each graph
    %figure(i);
    %plot(X,Y)

    %title(variableName);
        
end