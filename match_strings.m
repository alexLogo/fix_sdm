function match = match_strings(str1, str2)
    % Split the first string by the '\' character
    parts1 = strsplit(str1, '\');
    % Get the last part of the split string (the file name)
    filename1 = parts1{end};
    % Extract the subject number from the first string gPPI
    subj_num_1 = filename1(8:9);
    % Extract the run number from the first string
    run_num_1 = filename1(19:20);

    % Split the second string by the '\' character
    parts2 = strsplit(str2, '\');
    % Get the last part of the split string (the file name)
    filename2 = parts2{end};
    % Extract the subject number from the second string parametric sdm
    subj_num_2 = filename2(3:4);
    % Extract the run number from the second string
    run_num_2 = filename2(14:15);
    % Check if the subject numbers and run numbers match
    if strcmp(subj_num_1, subj_num_2) && strcmp(run_num_1, run_num_2)
        match = true;
    else
        match = false;
    end
end
