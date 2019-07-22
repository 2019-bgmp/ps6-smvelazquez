#!/bin/bash

#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --job-name=SV.VELVETH      ### Job Name
#SBATCH --time=0-01:00:00       ### Wall clock time limit in Days-HH:MM:SS
#SBATCH --nodes=1               ### Number of nodes needed for the job
#SBATCH --ntasks-per-node=1     ### Number of tasks to be launched per Node
#SBATCH --cpus-per-task=5

conda deactivate
conda activate bgmp_py3

FPONE='/projects/bgmp/shared/Bi621/800_3_PE5_interleaved.fq_1'
FPTWO='/projects/bgmp/shared/Bi621/800_3_PE5_interleaved.fq_2'
FPTHREE='/projects/bgmp/shared/Bi621/800_3_PE5_interleaved.fq.unmatched'

/usr/bin/time -v velveth /projects/bgmp/smv/Bi621/ps6/fishy49.2 49 -fastq -short $FPONE $FPTWO -long $FPTHREE
/usr/bin/time -v velvetg fishy49.2/ -cov_cutoff auto -min_contig_lgth 500
mv /projects/bgmp/smv/Bi621/ps6/fishy49.2/contigs.fa /projects/bgmp/smv/Bi621/ps6/fishy49.2/contigs.mincont500.auto.fa
