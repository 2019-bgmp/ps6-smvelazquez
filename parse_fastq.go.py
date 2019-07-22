#!/usr/bin/env python

FP1 = "/projects/bgmp/shared/Bi621/800_3_PE5_interleaved.fq_1"
FP2 = "/projects/bgmp/shared/Bi621/800_3_PE5_interleaved.fq_2"
FP3 = "/projects/bgmp/shared/Bi621/800_3_PE5_interleaved.fq.unmatched"

file_list = [FP1, FP2, FP3]
k_sizes = [31, 41, 49]

NT_TOTAL = 0
RECORDS_TOTAL = 0



for file in file_list:
    with open(file, "r") as fh:
        i = 0
        records = 0
        nt_count= 0
        for line in fh:
            i+=1
            line = line.strip('\n')
            if i%4 == 2:
                records += 1
                RECORDS_TOTAL += 1
                for letter in line:
                    nt_count +=1
                    NT_TOTAL +=1

        ###### Sanity checks, shows each variable in each file
        #print("Number of Reads:", records)
        #print("number of nucleotides:", nt_count)
        #print("length of reads:", nt_count/records)
        #print("coverage:", (records * (nt_count/records) / 2000000))
COVERAGE = (RECORDS_TOTAL *(NT_TOTAL/RECORDS_TOTAL)/2000000)
AVG_LEN_READS = (NT_TOTAL/RECORDS_TOTAL)

print("TOTAL NUMBER OF READS:", RECORDS_TOTAL)
print("TOTAL NUMBER OF NUCLEOTIDES:", NT_TOTAL)
print("TOTAL LENGTH OF READS:", AVG_LEN_READS)
print("EXPECTED COVERAGE:", COVERAGE)

z = 0
for size in k_sizes:
    k_cov = ((COVERAGE) * (AVG_LEN_READS - size +1)/AVG_LEN_READS)
    z += k_cov
    print(k_cov)
print((z/len(k_sizes)))
