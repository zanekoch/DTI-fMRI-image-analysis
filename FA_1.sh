#!/bin/bash

#Zane Koch 6/29/18 UCLA

#dti processing starting after step 4 using inputs from Kevins preprocessed data

#each item is either named ADHD_CIDAR_#number#_FA_FA_to_target.nii.gz or control_CIDAR_#number#_FA_FA_to_target.nii.gz

#assuming each subject has undergone pre-processing and:
	  #ENIGMA-DTI standards maps etc put in correct /enigmaDTI/TBSS/ENIGMA_targets directory
	  #images from step 4 are in a ./FA folder inside /enigmaDTI/TBSS/run_tbss/

#then start with step 7 because 5&6 are unnecessary (i believe):



subj=$1 #rename the input subject to something more logical
loc=/u/home/p/pamelita/project/Symmetry/CIDAR/DTI/zaneTBSS #location of the directory that contains enigmaDTI


#step 7
cd $loc/enigmaDTI/TBSS/run_tbss/

mkdir -p ./FA_individ/${subj}/stats/
mkdir -p ./FA_individ/${subj}/FA/

cp ./FA/${subj} ./FA_individ/${subj}/FA/

fslmaths ./FA_individ/${subj}/FA/${subj} -mas $loc/enigmaDTI/TBSS/ENIGMA_targets/ENIGMA_DTI_FA_skeleton_mask_dst ./FA_individ/${subj}/FA/${subj}_masked_FA.nii.gz
#step 8
tbss_skeleton -i ./FA_individ/${subj}/FA/${subj}_masked_FA.nii.gz -p 0.049 $loc/enigmaDTI/TBSS/ENIGMA_targets/ENIGMA_DTI_FA_skeleton_mask_dst ${FSLDIR}/data/standard/LowerCingulum_1mm.nii.gz ./FA_individ/${subj}/FA/${subj}_masked_FA.nii.gz ./FA_individ/${subj}/stats/${subj}_masked_FAskel.nii.gz -s $loc/enigmaDTI/TBSS/ENIGMA_targets/ENIGMA_DTI_FA.nii.gz
