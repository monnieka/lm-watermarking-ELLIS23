#!/bin/bash
#SBATCH -N 1 # 2 - number of nodes to allocate
#SBATCH --ntasks-per-node=8 # 16 -number of processes per compute node
#SBATCH --cpus-per-task=1 # 2 number of cores allocated per process
#SBATCH --gres=gpu:1 # number of gpus per node
#SBATCH -t 1:00:00 # total run time of the job allocation
#SBATCH --mem=52GB # memory request per node
#SBATCH -o out/out_%A_%j.out 
#SBATCH -e err/out_%A_%j.err # for stderr redirection
#SBATCH -p boost_usr_prod # partition for resource allocation
#SBATCH -A tra23_ELLIS # account name 
#SBATCH --reservation s_tra_Ellis # after monday change to s_tra_Ellis

export OMP_PROC_BIND=true

export HUGGINGFACE_HUB_CACHE='/leonardo_work/tra23_ELLIS/watermarking_group_2/models_w'
export HF_HOME='/leonardo_work/tra23_ELLIS/watermarking_group_2/models_w'
export TRANSFORMERS_CACHE='/leonardo_work/tra23_ELLIS/watermarking_group_2/models_w'

module load profile/deeplrn
module load cineca-ai/3.0.0
source ellis/bin/activate

python experiments/run_watermarking.py \
	    --model_name facebook/opt-6.7b \
	    --dataset_name c4 \
	    --dataset_config_name realnewslike \
	    --max_new_tokens 200 \
	    --min_prompt_tokens 50 \
	    --limit_indices 500 \
	    --input_truncation_strategy completion_length \
	    --input_filtering_strategy prompt_and_completion_length \
	    --output_filtering_strategy max_new_tokens \
	    --dynamic_seed markov_1 \
	    --bl_proportion 0.5 \
	    --bl_logit_bias 2.0 \
	    --bl_type soft \
	    --store_spike_ents True \
	    --num_beams 1 \
	    --use_sampling True \
	    --sampling_temp 0.7 \
    	    --oracle_model_name facebook/opt-6.7b \
	    --run_name example_run \
	    --output_dir ./all_runs \
	    --no_wandb True

