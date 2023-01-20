function matched_files = match_files2(files1, files2)
    matched_files = struct('file1',{},'file2',{},'run_num',{});
    for i = 1:length(files1)
        subj_num1 = extract_subj_num(files1{i});
        run_num1 = extract_run_num(files1{i});
        for j = 1:length(files2)
            subj_num2 = extract_subj_num(files2{j});
            run_num2 = extract_run_num(files2{j});
            if (strcmp(subj_num1,subj_num2) && strcmp(run_num1, run_num2))
                matched_files(end+1) = struct('file1', files1{i}, 'file2', files2{j}, 'run_num', run_num1);
            end
        end
    end
end

function subj_num = extract_subj_num(file)
    subj_num = regexp(file,'(?<=SS)\d{2}','match','once');
end

function run_num = extract_run_num(file)
    run_num = regexp(file,'(?<=run)\d','match','once');
end
