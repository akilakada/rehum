#!/bin/tcsh

set data_path = /Users/akila/Desktop/OB_Data/fMRI


set run = rehum_post
set dummy = 0

#foreach sub(48)
#foreach sub(48)
foreach sub(20 22 23 24 25 26 27 28 29 30 31 32 33 35 36 37 41)
echo $data_path
echo $sub
echo $run
echo $dummy 
#set data_path_out = $data_path/Sub${sub}/${run}/sts_uncorrected_.05.feat
if ( ${run} == rehum_pre ) then
	set reg_1 = Sub${sub}_reHum_home_base_1.csv
	set reg_1_name = home
	set reg_2 = Sub${sub}_reHum_pride_base_1.csv
	set reg_2_name = pride
	set func_data = `ls ${data_path}/OB_0${sub}/*_pre.nii.gz`
else if ( ${run} == rehum_post) then
	set reg_1 = Sub${sub}_reHum_home_base_2.csv
	set reg_1_name = home
	set reg_2 = Sub${sub}_reHum_pride_base_2.csv
	set reg_2_name = pride
	set func_data = `ls ${data_path}/OB_0${sub}/*_post.nii.gz`
endif

echo "$reg_1" $reg_1_name


set t1_data = `ls ${data_path}/OB_0${sub}/T1_c*`
echo $func_data
echo $t1_data

set tr = `fslval ${func_data} pixdim4`
set vols = `fslval ${func_data} dim4` 

echo $tr $vols

sed -e "s|###PATH###|${data_path}|g" \
	-e "s/###RUN###/${run}/g" \
	-e "s/###TR###/${tr}/g" \
	-e "s/###SUB###/${sub}/g" \
	-e "s/###REG_1###/${reg_1}/g" \
	-e "s/###REG_1_NAME###/${reg_1_name}/g" \
	-e "s/###REG_2###/${reg_2}/g" \
	-e "s/###REG_2_NAME###/${reg_2_name}/g" \
	-e "s/###VOLS###/${vols}/g" \
	-e "s/###DUMMY###/${dummy}/g" \
	-e "s|###FUNC_DATA###|${func_data}|g" \
	-e "s|###T1_DATA###|${t1_data}|g" \
	${data_path}/Templates/Rehum_1st_lvl.fsf > ${data_path}/OB_0${sub}/${run}_1st_lvl.fsf
	end