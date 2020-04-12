import os

if __name__=="__main__":
    infile = sys.argv[1]
    ofile = sys.argv[2]
    with open(infile, 'r') as fin, open(ofine, 'w') as fout:
        for line in fin:
            line = line.strip().split()
            id_ = os.path.basename(line)[:-4]
            path = line
            fout.write('{} {}'.format(id_, path))
