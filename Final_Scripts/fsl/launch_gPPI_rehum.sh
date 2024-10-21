#!/bin/tcsh

## This script launches the roi-based gPPI analysis (scripted for FSL)

set data_path = /Users/akila/Desktop/OB_Data/fMRI
set data_path_t =  /Users/akila/Desktop/OB_Data


set run = rehum_post
set dummy = 2
set sphere = 8
set ROI_name = l_postcentral_nn

set ROI = ${ROI_name}_${sphere}mm

set participants = (005 006 007 008 009 010 011 012 013 014 015 016 017 018 019 020 022 023 024 025 026 027 028 029 030 031 032 033 034 035 036 037 038 039 040 041 042 044 045 048)

#set participants = (017)
foreach sub (${participants})

@ sub_num = $sub # remove leading zero
    set sub_str = "$sub_num"

echo $data_path
echo $sub
echo $run
echo $dummy 


#set data_path_out = $data_path/Sub${sub}/${run}/sts_uncorrected_.05.feat
if ( ${run} == rehum_pre ) then
	set reg_1 = Sub${sub_str}_reHum_home_base_1.csv
	set reg_1_name = home
	set reg_2 = Sub${sub_str}_reHum_pride_base_1.csv
	set reg_2_name = pride
	set func_data = `ls ${data_path}/OB_${sub}/*_pre.feat/filtered_func_data.nii.gz`
else if ( ${run} == rehum_post) then
	set reg_1 = Sub${sub_str}_reHum_home_base_2.csv
	set reg_1_name = home
	set reg_2 = Sub${sub_str}_reHum_pride_base_2.csv
	set reg_2_name = pride
	set func_data = `ls ${data_path}/OB_${sub}/*_post.feat/filtered_func_data.nii.gz`
endif


echo "$reg_1" $reg_1_name


set t1_data = `ls ${data_path}/OB_${sub}/T1_c*`
echo $func_data
echo $t1_data

set tr = `fslval ${func_data} pixdim4`
set vols = `fslval ${func_data} dim4` 

echo $tr $vols

sed -e "s|###PATH###|${data_path}|g" \
	-e "s/###RUN###/${run}/g" \
	-e "s/###TR###/${tr}/g" \
	-e "s/###SUB###/${sub}/g" \
	-e "s/###ROI###/${ROI}/g" \
	-e "s/###REG_1###/${reg_1}/g" \
	-e "s/###REG_1_NAME###/${reg_1_name}/g" \
	-e "s/###REG_2###/${reg_2}/g" \
	-e "s/###REG_2_NAME###/${reg_2_name}/g" \
	-e "s/###VOLS###/${vols}/g" \
	-e "s/###DUMMY###/${dummy}/g" \
	-e "s|###FUNC_DATA###|${func_data}|g" \
	-e "s|###T1_DATA###|${t1_data}|g" \
	${data_path_t}/Templates/Task_1st_lvl_gPPI_r.fsf > ${data_path}/OB_${sub}/Connectivity/PPI/${run}_gPPI_1st_lvl.fsf
	end