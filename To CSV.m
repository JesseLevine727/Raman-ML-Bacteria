
cd("Spectra Trials\");
files =dir('*.mat');


for i = 1:numel(files)
    filename = fullfile(files(i).folder,files(i).name);
    
    matContents = load(filename);

    variableNames = fieldnames(matContents);
    
    for j = 1:numel(variableNames)
        variableName = variableNames{j};
        
        struct = matContents.(variableName);

        cell = struct2cell(struct);
        Y = cell2mat(cell(3));
        xStruct = cell{4};
        X = xStruct{2};

        myStruct.field1 = X;
        myStruct.field2 = Y;

        xData = [myStruct.field1];
        yData = [myStruct.field2];
    
        dataTable = table(xData',yData', 'VariableNames',{'x','y'});

        csvFilename = sprintf('%s_%s.csv',files(i).name,variableName);
        writetable(dataTable,csvFilename);
        
        
        
    end
    
    
    %figure(i);
    %plot(X,Y)
        
end

