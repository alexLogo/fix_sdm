% open the new file
fid = fopen('C:\Users\alex\Desktop\fix_sdm\test.sdm', 'w');

% write the headers to the new file
for i = 1:10
    fprintf(fid, '%s\n', headers{i})
end

% save the modified data to the new file
%writematrix(data, 'new_file.sdm', '-append', 'Delimiter', '\t', 'Precision', '%.6f');

% close the new file
fclose(fid);