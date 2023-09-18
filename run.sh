#!/bin/bash
#SBATCH -N 1 # 2 - number of nodes to allocate
#SBATCH --ntasks-per-node=8 # 16 -number of processes per compute node
#SBATCH --cpus-per-task=1 # 2 number of cores allocated per process
#SBATCH --gres=gpu:1 # number of gpus per node
#SBATCH -t 1:00:00 # total run time of the job allocation
#SBATCH --mem=52GB # memory request per node
#SBATCH -o out/out_%A_%J.out
job.out # for stdout redirection
#SBATCH -e err/out_%A_%J.err # for stderr redirection
#SBATCH -p boost_usr_prod # partition for resource allocation
#SBATCH -A tra23_ELLIS # account name 
#SBATCH --reservation s_tra_Ellis1809 # after monday change to s_tra_Ellis

module load deeplrn
module av cineca-ai
export OMP_PROC_BIND=true
python demo_watermark.py --model_name_or_path facebook/opt-6.7b
