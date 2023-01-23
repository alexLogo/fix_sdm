function modify_sdm_file(filepath, vector_number, new_vector)
    fileID = fopen(filepath,'r');
    if fileID == -1
        fprintf('Error: Could not open file %s\n', filepath);
        return;
    end
    NrOfPredictors = fscanf(fileID, 'NrOfPredictors: %d\n', 1);
    NrOfDataPoints = fscanf(fileID, 'NrOfDataPoints: %d\n', 1);
    data = cell(1, NrOfPredictors);
    for i = 1:NrOfPredictors
        line = fgetl(fileID);
        data(i) = strsplit(line);
    end
    % Close the file
    status = fclose(fileID);
    if status ~= 0
        fprintf('Error: Could not close file %s\n', filepath);
        return;
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
        % Open new file for writing
    newFileID = fopen(new_filepath,'w');
    if newFileID == -1
        fprintf('Error: Could not open file %s\n', new_filepath);
        return;
    end
    % Write the modified data to the new file
    for i = 1:NrOfPredictors
        fwrite(newFileID, data(i,:),'double');
        fprintf(newFileID, '\n');
    end
    % Close the new file
    status = fclose(newFileID);
    if status ~= 0
        fprintf('Error: Could not close file %s\n', new_filepath);
        return;
    end
    fprintf('File saved to %s\n', new_filepath);
end

