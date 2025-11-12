################################################################################################################################################
################################                TRANSCRIPTION AND TRANSLATION EXERCISES         ################################################
################################################################################################################################################

# Getting to the directory
import os
os.getcwd()


# # Reading the text file
with open("c:/Users/Pablo/Desktop/MHEDAS/1 Semester/Biomedicine for Engineers/Activities/Transcription and Translation exercises/Seq_gene.txt") as file: 
    lines = file.readlines()

# Converting the list of lines into a single string sequence
string_seq = "" # initialize the empty string
for i in range(1, len(lines)-1):  # going through all lines except for the first one
    string_seq = string_seq + lines[i] #adding the lines to the string

# a) Indicate the sequence of the complementary chain in the 3’ to 5’ sense

# For this the function needs to compute the complementary nucleotides and then complete the chain (3' to 5')

def complem_seq(sequence, RNA):
    '''This function computes the complementary genomic sequence.'''
    complem_sequence = ""
    for letter in sequence:
        if letter == "A": # exchanging Adenine by Thymine or Uracil
            if RNA:
                complem_sequence += "U"
            else: 
                complem_sequence += "T"
        elif letter == "T": # viceversa
            complem_sequence += "A"
        elif letter == "C": # Exchanging Citosine by Guanine
            complem_sequence += "G"
        elif letter == "G": # viceversa
            complem_sequence += "C"
    return complem_sequence

complementary_sequence = complem_seq(string_seq, False) # reversing the sequence 
print("This is the complementary sequence: \n {seq}".format(seq = complementary_sequence))

# b) Indicate the position of the initiation transcription site and the final transcription site

# These are the exons indexes: 
exons_set = {(1,118), (3944,4031), (5276,5380), (7575,7674), (9017,9095), (10367, 10502), (11195,13596)}

print("The position of the transcription starting site (TSS) is {pos1} and the position of the final transcrition site (FTS) is {pos2}".format(pos1 = 1, pos2 = 13596))

# c) Indicate the sequence of the m-RNA

# For obtaining the sequence we have to perform the splicing and replace Adenine by Uracil

def mRNA(sequence, exons_set):
    '''This function constructs the mRNA from the DNA sequence.'''
    coding_seq = ""
    for idxs in sorted(exons_set): # going through the exons 
        coding_seq += sequence[idxs[0]-1:idxs[1]] # adding the exons and discarding the introns -> splicing

    complementary_sequence = complem_seq(coding_seq, True)
    return complementary_sequence

mRNA_seq = mRNA(complementary_sequence, exons_set)
print("This is the mRNA sequence: \n {seq}".format(seq= mRNA_seq))

# d) If the coding region in the m-RNA is from 126 to 716, indicate the sequence of the 5’UTR, the 3’UTR and the coding region.

def sequence_UTR(sequence, init_idx, final_idx):
    '''This function serves to extract the unstranlated regions from the mRNA'''
    utr = sequence[init_idx-1:final_idx-1]
    return utr

utr_5 = sequence_UTR(mRNA_seq, 1, 126)
utr_3 = sequence_UTR(mRNA_seq, 716, len(mRNA_seq))
coding_seq = sequence_UTR(mRNA_seq, 126, 715)

print("The UTR in 5' is: \n {utr5} \n The UTR in 3' is: \n {utr3}".format(utr5 = utr_5, utr3 = utr_3))
print("The CDS is: \n {cds}".format(cds = coding_seq))

print(len(utr_5), len(utr_3), len(coding_seq), len(mRNA_seq))

# e) Indicate the sequence of the proitein

from Bio.Seq import Seq

rna_sequence = Seq(coding_seq)
protein_seq = rna_sequence.translate()
print("This is the protein sequence: \n {prot}".format(prot = protein_seq))