function modify_sdm_file4(filepath, vector_number, new_vector)
    % read in the file
    fid = fopen(filepath);

    % first 10 lines as headers
    headers = cell(10,1);
    for i = 1:9
        headers{i} = fgetl(fid);
    end

    % use textscan to read in the remaining sdm data
    formatSpec = '%f %f %f %f %f %f %f %f %f %f %f %f';
    sdmdata = textscan(fid, formatSpec, 'CollectOutput', true);
    sdmdata = sdmdata{1};
    
    % replace the specified vector_number column of data with the new vector
    %sdmdata(:,vector_number) = new_vector;
    sdmdata(:, vector_number) = new_vector;
    % close the file
    fclose(fid);

    % open the new file
    %fid = fopen('new_file.sdm', 'w');
    % Save the modified data to a new file
    [filepath_folder, filepath_name, filepath_ext] = fileparts(filepath);
    new_filepath = fullfile(filepath_folder, [filepath_name '_modified' filepath_ext]);
    fid = fopen(new_filepath,'w');
    fprintf('File saved to %s\n', new_filepath);
    % write the headers to the new file
    for i = 1:9
        fprintf(fid, '%s\n', headers{i});
    end

    % save the modified sdm vectors data to the new file
    dlmwrite(new_filepath, sdmdata, '-append', 'delimiter','\t','precision','%.6f');

    % close the new file
    fclose(fid);
end