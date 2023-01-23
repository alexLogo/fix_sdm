function modify_sdm_file4(filepath, vector_number, new_vector)
    % read in the file
    fid = fopen(filepath);

    % read the first 10 lines as headers
    headers = cell(10,1);
    for i = 1:9
        headers{i} = fgetl(fid);
    end

    % use textscan to read in the remaining data
    formatSpec = '%f %f %f %f %f %f %f %f %f %f %f %f';
    sdmdata = textscan(fid, formatSpec, 'CollectOutput', true);
    sdmdata = sdmdata{1};
    
    % replace the specified vector_number column of data with the new vector
    sdmdata(:,3) = new_vector;

    % close the file
    fclose(fid);

    % open the new file
    fid = fopen('new_file.sdm', 'w');

    % write the headers to the new file
    for i = 1:9
        fprintf(fid, '%s\n', headers{i});
    end

    % save the modified data to the new file
    dlmwrite('new_file.sdm', sdmdata, '-append', 'delimiter','\t','precision','%.6f');

    % close the new file
    fclose(fid);
end