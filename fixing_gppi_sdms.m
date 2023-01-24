clear all;

parametricdatapath='C:\Users\alogovin1\Documents\GitHub\fix_sdm';
gPPIdatapath='C:\Users\alogovin1\Documents\GitHub\fix_sdm';
addpath 'C:\Users\alogovin1\Documents\GitHub\fix_sdm';
addpath (gPPIdatapath)
addpath (parametricdatapath)

 gPPI_files =  findfiles('sdm', gPPIdatapath);
 parametric_files =  findfiles('sdm', parametricdatapath);

 matched_pairs = match_files2( gPPI_files, parametric_files);

for matched_pair=1:length(matched_pairs)
   
 
voi_tc=import_timecourse(matched_pairs(matched_pair).file1);

plot(voi_tc)

runum = matched_pairs(matched_pair).run_num;

if str2double(runum) == 1

parametric_pred=import_para_run1(matched_pairs(matched_pair).file2);

index_vec_to_replace  = 3;

else if str2double(runum) == 2;

    parametric_pred=import_para_run2(matched_pairs(matched_pair).file2);

index_vec_to_replace  = 4;

else
    parametric_pred=import_para_run3(matched_pairs(matched_pair).file2);


index_vec_to_replace  = 5;
end
end

plot(parametric_pred)
%gPPI_correct_pred = multiply_elementwise(voi_tc,parametric_pred);
gPPI_correct_pred = times(voi_tc,parametric_pred);



plot(gPPI_correct_pred)
modify_sdm_file4('gPPI_SS02_run2_VM-02-S1R1_SCCTBL_3DMCTS_LTR_THPGLMF2c_256_trilin_3x1.0_MNI_SD3DVSS6.00mm_L_Ins.sdm', 3, gPPI_correct_pred)

%modify_sdm_file(matched_pairs(matched_pair).file1, index_vec_to_replace, gPPI_correct_pred)
%a = createSDMStruct('FileVersion:',1,'NrOfPredictors:',12,'NrOfDataPoints:',173,'IncludesConstant:',1,'FirstConfoundPredictor:',1,'showArray',gPPI_correct_pred);
close all;
end
