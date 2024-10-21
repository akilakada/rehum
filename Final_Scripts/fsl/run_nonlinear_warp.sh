#!/bin/bash


BASE_DIR="/Users/akila/Desktop/OB_Data/fMRI"

STANDARD_IMAGE="/usr/local/fsl/data/standard/MNI152_T1_2mm_brain.nii.gz"

SUBJECTS="005 006 007 008 009 010 011 012 013 014 015 016 017 018 019 020 022 023 024 025 026 027 028 029 030 031 032 033 034 035 036 037 038 039 040 041 042 044 045 048"

#SUBJECTS="005 006 007"

# Loop through subjects
for SUB in $SUBJECTS; do
    echo "Sub OB_${SUB}..."

    # Path to feat
    FEAT_DIR="${BASE_DIR}/OB_${SUB}/rehum_post_pp.feat"
    
    # Path to structural
    HIGHRES="${FEAT_DIR}/reg/highres.nii.gz"
    
    # Output warp file name
    OUT_WARP="${FEAT_DIR}/reg/highres2standard_warp.nii.gz"
    
    # Check if the highres image exists
    if [[ -f "${HIGHRES}" ]]; then
        # Run FNIRT to create the warp file
        echo "Running FNIRT for subject OB_${SUB}..."
        fnirt --in=${HIGHRES} --aff=${FEAT_DIR}/reg/highres2standard.mat --cout=${OUT_WARP} --config=T1_2_MNI152_2mm --ref=${STANDARD_IMAGE}
        
        echo "Warp file OB_${SUB} generated."
    else
        echo "Highres image OB_${SUB} not found."
    fi
done

echo "All subjects processed."
