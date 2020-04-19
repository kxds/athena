#!/bin/sh

stage=1
datadir=examples/asr/st_cmds/data
mkdir -p $datadir
data_name=ST-CMDS-20170001_1-OS

if [ $stage -le 0 ]; then
    wget -P /home/zyj/data/ http://www.openslr.org/resources/38/${data_name}.tar.gz 
    tar zvxf /home/zyj/data/${data_name}.tar.gz
fi

if [ $stage -le 1 ]; then
    find /home/zyj/data/${data_name} -name "*.wav" > $datadir/wavlst.txt
    find /home/zyj/data/${data_name} -name "*.txt" > $datadir/textlst.txt
    find /home/zyj/data/${data_name} -name "*.metadata" > $datadir/metadata.txt
    
    python3 examples/asr/st_cmds/local/get_name.py $datadir/wavlst.txt $datadir/wav.scp
    python3 examples/asr/st_cmds/local/get_name.py $datadir/textlst.txt $datadir/text.scp
    python3 examples/asr/st_cmds/local/get_name.py $datadir/metadata.txt $datadir/metadata.scp
    awk  ' {if (ARGIND==1) grade[$1] = $0}  {if (ARGIND>1 && ($1 in grade)) print grade[$1]} ' $datadir/wav.scp $datadir/text.scp > $datadir/wav.scp.new
    awk  ' {if (ARGIND==1) grade[$1] = $0}  {if (ARGIND>1 && ($1 in grade)) print grade[$1]} ' $datadir/wav.scp.new $datadir/metadata.scp > $datadir/wav.scp.new

    # cd $datadir
    mkdir -p $datadir/train $datadir/dev $datadir/test
    sed -n '1,92340p' $datadir/wav.scp  > $datadir/train/wav.scp
    sed -n '92340,100548p' $datadir/wav.scp  > $datadir/dev/wav.scp
    sed -n '100548,102600p' $datadir/wav.scp  > $datadir/test/wav.scp
    python3 examples/asr/st_cmds/local/prepare_data.py /home/zyj/data/${data_name} $datadir
fi