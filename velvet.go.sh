#!/bin/bash

#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --job-name=SV.VELVETH/G      ### Job Name
#SBATCH --time=0-01:00:00       ### Wall clock time limit in Days-HH:MM:SS
#SBATCH --nodes=1               ### Number of nodes needed for the job
#SBATCH --ntasks-per-node=1     ### Number of tasks to be launched per Node
#SBATCH --cpus-per-task=5

conda deactivate
conda activate bgmp_py3

FPONE='/projects/bgmp/shared/Bi621/800_3_PE5_interleaved.fq_1'
FPTWO='/projects/bgmp/shared/Bi621/800_3_PE5_interleaved.fq_2'
FPTHREE='/projects/bgmp/shared/Bi621/800_3_PE5_interleaved.fq.unmatched'



#velveth with ksizes = [31,41,49]
/usr/bin/time -v velveth /projects/bgmp/smv/Bi621/ps6/fishy31.2 31 -fastq -short $FPONE $FPTWO -long $FPTHREE
/usr/bin/time -v velveth /projects/bgmp/smv/Bi621/ps6/fishy41.2 41 -fastq -short $FPONE $FPTWO -long $FPTHREE
/usr/bin/time -v velveth /projects/bgmp/smv/Bi621/ps6/fishy49.2 49 -fastq -short $FPONE $FPTWO -long $FPTHREE

#velvetg for plain kmersizes, no coverage cutoffs
/usr/bin/time -v velvetg fishy31.2/
mv /projects/bgmp/smv/Bi621/ps6/fishy31.2/contigs.fa /projects/bgmp/smv/Bi621/ps6/fishy31.2/contigs.k31.unspecified.fa
/usr/bin/time -v velvetg fishy41.2/
mv /projects/bgmp/smv/Bi621/ps6/fishy41.2/contigs.fa /projects/bgmp/smv/Bi621/ps6/fishy41.2/contigs.k41.unspecified.fa
/usr/bin/time -v velvetg fishy49.2/
mv /projects/bgmp/smv/Bi621/ps6/fishy49.2/contigs.fa /projects/bgmp/smv/Bi621/ps6/fishy49.2/contigs.k49.unspecified.fa

#velvetg for k49 with 20x, 40x, auto coverage
/usr/bin/time -v velvetg fishy49.2/ -cov_cutoff 20
mv /projects/bgmp/smv/Bi621/ps6/fishy49.2/contigs.fa /projects/bgmp/smv/Bi621/ps6/fishy49.2/contigs.20.fa

/usr/bin/time -v velvetg fishy49.2/ -cov_cutoff 60
mv /projects/bgmp/smv/Bi621/ps6/fishy49.2/contigs.fa /projects/bgmp/smv/Bi621/ps6/fishy49.2/contigs.60.fa

/usr/bin/time -v velvetg fishy49.2/ -cov_cutoff auto
mv /projects/bgmp/smv/Bi621/ps6/fishy49.2/contigs.fa /projects/bgmp/smv/Bi621/ps6/fishy49.2/contigs.auto.fa
