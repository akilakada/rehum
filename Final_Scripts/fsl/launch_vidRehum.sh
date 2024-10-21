#!/bin/tcsh

## preprocessing ONLY
set data_path = /Users/akila/Desktop/OB_Data/fMRI
set data_path2 = /Users/akila/Desktop/OB_Data

set run = vidRehum
set dummy = 2

#foreach sub(003 004 005 006 007 008 009 010 011 012 013 014 015 016)
#foreach sub(17 20 22 23 24 25 26 27 29 31 33 34 35 36 37 38 39 40 41 42 44 45)
foreach sub(48)
#foreach sub(20 22 23 24 25 26 27 28 29 30 31 32 33 35 36 37 41)
echo $data_path
echo $sub
echo $run
echo $dummy 
#set data_path_out = $data_path/Sub${sub}/${run}/sts_uncorrected_.05.feat

set func_data = `ls ${data_path}/OB_0${sub}/vidRehum.nii.gz`

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
	-e "s/###VOLS###/${vols}/g" \
	-e "s/###DUMMY###/${dummy}/g" \
	-e "s|###FUNC_DATA###|${func_data}|g" \
	-e "s|###T1_DATA###|${t1_data}|g" \
	${data_path2}/Templates/Task_vid_rehum.fsf > ${data_path}/OB_0${sub}/${run}_1st_lvl.fsf
	end