
%clear all;

fid = fopen('C:\Users\alex\Desktop\fix_sdm\test2.sdm');

% read the first 5 lines as headers
headers = cell(10,1);
for i = 1:9
    headers{i} = fgetl(fid);
end

% use textscan to read in the remaining data
formatSpec = '%f %f %f %f %f %f %f %f %f %f %f %f';
data = textscan(fid, formatSpec, 'CollectOutput', true);
data = data{1};

new_vector1 = rand(173,1);
new_vector2 = rand(173,1);

% replace the 3rd column of data with the new vector1
data(:,3) = new_vector1;

% replace the 4th column of data with the new vector2
data(:,4) = new_vector2;
% close the file

% open the new file
fid = fopen('new_file2.sdm', 'w');

% write the headers to the new file
for i = 1:9
    fprintf(fid, '%s\n', headers{i});
end

%new_file = 'new_file2.csv'
% save the modified data to the new file
%writematrix(data, new_file);

% save the modified data to the new file
dlmwrite('new_file2.sdm', data, '-append', 'delimiter','\t','precision','%.6f');


% close the new file
fclose(fid);
%fclose(fid2);
