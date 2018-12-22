#!/bin/bash

subj_dir=/u/home/p/pamelita/project/Symmetry/CIDAR/DTI/zaneTBSS/enigmaDTI/TBSS/run_tbss/FA
script_dir=/u/home/p/pamelita/project/Symmetry/CIDAR/DTI/zane_scripts

cd $subj_dir

for subj in *;
do 
    cd $script_dir
    ./FA_1.sh $subj
done