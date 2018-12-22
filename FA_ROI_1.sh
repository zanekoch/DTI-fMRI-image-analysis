#!/bin/bash
#$ -S /bin/bash

subject=$1

## takes input of files and outputs ROi's and average ROI's##
## ENIGMA-DTI ##

#######
## part 1 - loop through all subjects to create a subject ROI file
#######
loc=/u/home/p/pamelita/project/Symmetry/CIDAR/DTI/zaneTBSS
#make an output directory for all files
mkdir $loc/ENIGMA_ROI_part1

cd $loc/enigmaDTI/TBSS/run_tbss/FA_individ

SubjectDirectory=$loc/enigmaDTI/TBSS/run_tbss/FA_individ/*
for subject2 in $SubjectDirectory
do
cp $subject2/stats/* $loc/ENIGMA_ROI_part1
done

enigma_dir=/u/home/p/pamelita/project/Symmetry/CIDAR/DTI/zane_FA_ROI/ROIextraction_info

cd $loc/ENIGMA_ROI_part1
subjects=*
for subject in $subjects
do
$enigma_dir/singleSubjROI_exe $enigma_dir/ENIGMA_look_up_table.txt $loc/enigmaDTI/TBSS/ENIGMA_targets/ENIGMA_DTI_FA_skeleton_mask_dst.nii.gz $enigma_dir/JHU-WhiteMatter-labels-1mm.nii.gz $loc/ENIGMA_ROI_part1/${subject}_ROIout ${subject}

done


#######
## part 2 - loop through all subjects to create ROI file
##                      removing ROIs not of interest and averaging others
#######

#make an output directory for all files
mkdir $loc/ENIGMA_ROI_part2

# you may want to automatically create a subjectList file
#    in which case delete the old one
#    and 'echo' the output files into a new name
#rm ./subjectList.csv
cd $loc/ENIGMA_ROI_part1
for subject3 in *out.csv
do
$enigma_dir/averageSubjectTracts_exe $subject3 $loc/ENIGMA_ROI_part2/${subject3}_ROIout_avg.csv


# can create subject list here for part 3!
#echo ${subject},${dirO2}/${subject}_ROIout_avg.csv >> ./subjectList.csv
done
