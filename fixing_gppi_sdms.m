

parametricdatapath='C:\Users\User\Documents\MRHI\Fix\parametric_sdm\SDM_VM_SOA_parametric'
gPPIdatapath='C:\Users\User\Documents\MRHI\Fix\gPPI_sdm\VM_SA_gPPI'
addpath 'C:\Users\User\Documents\matlab_code'
addpath (gPPIdatapath)
addpath (parametricdatapath)

 gPPI_files =  findfiles('sdm', gPPIdatapath);
 parametric_files =  findfiles('sdm', parametricdatapath);

 matched_pairs = match_files2( gPPI_files, parametric_files)

for matched_pair=1:length(matched_pairs)
   
 
voi_tc=import_timecourse(matched_pairs(matched_pair).file1);

plot(voi_tc)

runum = matched_pairs(matched_pair).run_num

if str2num(runum) == 1

parametric_pred=import_para_run1(matched_pairs(matched_pair).file2);

index_vec_to_replace  = 3

else if str2num(runum) == 2

    parametric_pred=import_para_run2(matched_pairs(matched_pair).file2);

index_vec_to_replace  = 4

else
    parametric_pred=import_para_run3(matched_pairs(matched_pair).file2);


index_vec_to_replace  = 5
end
end

plot(parametric_pred)
gPPI_correct_pred = multiply_elementwise(voi_tc,parametric_pred);

plot(gPPI_correct_pred )
modify_sdm_file2(matched_pairs(matched_pair).file1, index_vec_to_replace, gPPI_correct_pred)

end
