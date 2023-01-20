
function replace_nth_vector(file, n, new_vector)
    % Read the text file into a cell array
    data = importdata(file);

    % Replace the nth vector in the cell array with the new vector
    data{n} = new_vector;

    % Write the updated cell array to a new text file
    [pathstr,name,ext] = fileparts(file);
    new_file = fullfile(pathstr,['new_',name,ext]);
    dlmwrite(new_file, data, 'delimiter', '\n');
end
