#!/usr/bin/env python

import argparse

def get_args():
	parser = argparse.ArgumentParser(description="A program to set k-mer size and filepaths")
	parser.add_argument("-f", "--filepath", help="the absolute filepath you want to k-mer", required=True)
	parser.add_argument("-k", "--k_mer_size", help="the k_mer_size you need to input for calculations", required = True, type = int)
	return parser.parse_args()

args = get_args()

FILEPATH = args.filepath
k_mer_size = args.k_mer_size


#FILEPATH = "/Users/samanthavelazquez/desktop/Bi621_repo/2019_Bi621/ps6-smvelazquez/contigs.fa"

import re
K_MER_COV = []
K_MER_LEN = []
PHYS_lEN = []
sorted_phys = []
sorted_len = []
DIST_DICT = {}
#k_mer_size = 49 <--- for sanity checks

with open(FILEPATH, "r") as fh:
    for line in fh:
        if re.match('^>', line): #pulls out any lines that start with the thingy
            header_lines = line.strip()
			#print(header_lines)
            length = re.findall(r'length_(\d+)_cov_.*', header_lines) #specifically pulls out the things in the parentheses
            cov = re.findall(r'length_\d+_cov_(.*)', header_lines) #specifically pulls out the things in the parentheses
            for i in length:
                K_MER_LEN.append(float(i)) #since finall makes them strings, have to turn every number into an integer
            for i in cov:
                K_MER_COV.append(float(i)) #since finall makes them strings, have to turn every number into an integer
    #print("original", "\n", K_MER_COV) #sanity checks to make sure they are updating
#print("lengths","\n", K_MER_LEN, "\n", "coverages", "\n", K_MER_COV) ## sanity check
for i in range(len(K_MER_LEN)):
    PHYS_lEN.append(K_MER_LEN[i] + (k_mer_size - 1)) #adjusts k-mer length to the physical length
    sorted_phys = sorted(PHYS_lEN, reverse= True) #needs to be sorted to find n50 later
    num_contigs =len(sorted_phys)
    max_len = sorted_phys[0]
    mean_len = (sum(sorted_phys)/num_contigs)
    total_len_genome = sum(sorted_phys)
print("number of contigs:", num_contigs,"maximum contig lenth:", max_len,"mean:", mean_len, "total length of genome assembly:", total_len_genome) ## sanity check

for i in range(len(K_MER_COV)):
    num_cov = len(K_MER_COV)
    mean_cov = (sum(K_MER_COV)/num_cov) ##don't know why I did a loop, p sure this can be calculated physically but whatever
print("mean depth of coverage:", mean_cov) ##sanity check

N_VALUE = sum(sorted_phys)/2
#print(N_VALUE)
z = 0
contig_count = 0
for value in sorted_phys: #every number in your list
    contig_count += value
    if contig_count >= N_VALUE: #if your running sum gets larger than the n50 value, break out of the loop and report back the position of the value in list
        break
    z +=1
n_fif = sorted_phys[z] #z = the value reported back from the loop, sorted_phys[z] = where it broke out of the loop = n50 position
print("N_50",n_fif)

for i in range(0, int(sorted_phys[0]), 100):
    DIST_DICT[i] = 0
#print(DIST_DICT) <-- sanity check
print("# Contig Length", "Number of Contigs in this category")
for contig_len in sorted_phys:#
    for hundred in DIST_DICT.keys():
        if contig_len >= hundred:#
            bucket = hundred
    if bucket in DIST_DICT:
        DIST_DICT[bucket] +=1
#print(DIST_DICT, sorted_phys, sep= "\n") #< --- sanity check
for key, value in DIST_DICT.items():
    print(key, value)
