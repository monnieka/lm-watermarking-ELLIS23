#!/bin/bash
#SBATCH -N _ # 2 - number of nodes to allocate
#SBATCH --ntasks-per-node=_ # 16 -number of processes per compute node
#SBATCH --cpus-per-task=_ # 2 number of cores allocated per process
#SBATCH --gres=gpu:_ # number of gpus per node
#SBATCH -t 1:00:00 # total run time of the job allocation
#SBATCH --mem=_GB # memory request per node
#SBATCH -o job.out # for stdout redirection
#SBATCH -e job.err # for stderr redirection
#SBATCH -p boost_usr_prod # partition for resource allocation
#SBATCH -A tra23_ELLIS # account name 
#SBATCH --reservation s_tra_Ellis1809 # after monday change to s_tra_Ellis1809

module load deeplrn
module av cineca-ai
export OMP_PROC_BIND=true
python demo_watermark.py --model_name_or_path facebook/opt-6.7b
