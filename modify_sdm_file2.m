function modify_sdm_file2(filepath, vector_number, new_vector)
    % Read the entire file into a string
    file_str = fileread(filepath);
    % Split the string into lines
    lines = splitlines(file_str);
    % Get the number of predictors and data points from the first two lines
    NrOfPredictors_line = lines{3};
    NrOfDataPoints_line = lines{4};
    NrOfPredictors = sscanf(NrOfPredictors_line, 'NrOfPredictors: %d');
    NrOfDataPoints = sscanf(NrOfDataPoints_line, 'NrOfDataPoints: %d');
    % Read the data from the lines
    data = cell( NrOfDataPoints, NrOfPredictors);
    for i = 1:NrOfPredictors
        line = lines{i+9};
        tmp=strsplit(line)
        data(i,:) = tmp{2:end};
    end

    % Modify the vector_number-th vector
    if vector_number > NrOfPredictors
        fprintf('Error: Vector number out of range (max %d)\n', NrOfPredictors);
        return;
    end
    if length(new_vector) ~= NrOfDataPoints
        fprintf('Error: New vector has a different number of elements (%d) than the existing vectors (%d)\n', length(new_vector), NrOfDataPoints);
        return;
    end
    data{vector_number} = new_vector;

    % convert cell array of strings to double
    data = cellfun(@str2double,data);
    % Save the modified data to a new file
    [filepath_folder, filepath_name, filepath_ext] = fileparts(filepath);
    new_filepath = fullfile(filepath_folder, [filepath_name '_modified' filepath_ext]);
    newFileID = fopen(new_filepath,'w');
    for i = 1:NrOfPredictors
        fwrite(newFileID, data(i,:), 'double');
        fprintf(newFileID, '\n');
    end
    fclose(newFileID);
    fprintf('File saved to %s\n', new_filepath);
end
