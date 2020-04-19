import os
import sys

if __name__=="__main__":
    infile = sys.argv[1]
    ofile = sys.argv[2]
    with open(infile, 'r') as fin, open(ofile, 'w') as fout:
        for line in fin:
            line = line.strip().split()
            id_ = os.path.basename(line[0]).split('.')[0]
            path = line[0]
            fout.write('{} {}\n'.format(id_, path))