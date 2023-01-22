function modified_data = importfile_modify(file_path, col_index, new_vector)

% Import data from text file
data = importfile(file_path);

% Replace the vector in the specified column index with the new vector, starting from the 10th row
data(10:end,col_index) = new_vector;

% Save the modified data to a new file
[pathstr,name,ext] = fileparts(file_path);
new_file_name = [name, '_modified', ext];
new_file_path = fullfile(pathstr, new_file_name);
dlmwrite(new_file_path, data, 'delimiter', ' ');

modified_data = data;
end