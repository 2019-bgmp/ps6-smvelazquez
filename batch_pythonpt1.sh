#!/bin/bash

#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --job-name=SV.PRACTICE.stats     ### Job Name
#SBATCH --time=0-01:00:00       ### Wall clock time limit in Days-HH:MM:SS
#SBATCH --nodes=1               ### Number of nodes needed for the job
#SBATCH --ntasks-per-node=1     ### Number of tasks to be launched per Node
#SBATCH --cpus-per-task=1

#/usr/bin/time -v python /projects/bgmp/smv/Bi621/ps6/PS6.py -f /projects/bgmp/smv/Bi621/ps6/fishy31/contigs.k31.unspecified.fa -k 31 > pt1_script.output.k31.cov_unspec.txt
#python /projects/bgmp/smv/Bi621/ps6/PS6.py -f /projects/bgmp/smv/Bi621/ps6/contigs.test.fa -k 31 > output.test.txt

#stats for plain(unspecified) kmers [31,41,49]
#/usr/bin/time -v python /projects/bgmp/smv/Bi621/ps6/PS6.py -f /projects/bgmp/smv/Bi621/ps6/fishy31.2/contigs.k31.unspecified.fa -k 31 > pt1_script.output.k31.cov_unspec.txt

#/usr/bin/time -v python /projects/bgmp/smv/Bi621/ps6/PS6.py -f /projects/bgmp/smv/Bi621/ps6/fishy41.2/contigs.k41.unspecified.fa -k 41 > pt1_script.output.k41.cov_unspec.txt

#/usr/bin/time -v python /projects/bgmp/smv/Bi621/ps6/PS6.py -f /projects/bgmp/smv/Bi621/ps6/fishy49.2/contigs.k49.unspecified.fa -k 49 > pt1_script.output.k49.cov_unspec.txt

#stats for k49 with cutoffs 20, 60, auto
#/usr/bin/time -v python /projects/bgmp/smv/Bi621/ps6/PS6.py -f /projects/bgmp/smv/Bi621/ps6/fishy49.2/contigs.20.fa -k 49 > pt1_script.output.k49.cov_20.txt
#/usr/bin/time -v python /projects/bgmp/smv/Bi621/ps6/PS6.py -f /projects/bgmp/smv/Bi621/ps6/fishy49.2/contigs.60.fa -k 49 > pt1_script.output.k49.cov_60.txt
#/usr/bin/time -v python /projects/bgmp/smv/Bi621/ps6/PS6.py -f /projects/bgmp/smv/Bi621/ps6/fishy49.2/contigs.auto.fa -k 49 > pt1_script.output.k49.cov_auto.txt

python /projects/bgmp/smv/Bi621/ps6/PS6.py -f /projects/bgmp/smv/Bi621/ps6/fishy49.2/contigs.mincont500.auto.fa -k 49 > pt1_script.output.mincont500.k49.cov_auto.txt
