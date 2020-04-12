#!/bin/sh

stage=0
datadir=data
mkdir -p $datadir
data_name=ST-CMDS-20170001_1-OS

if [ $stage le 0 ]; then
    wget -P /Users/yijing.zhou1022/http://www.openslr.org/resources/38/${data_name}.tar.gz 
    tar zvxf /Users/yijing.zhou1022/${data_name}.tar.gz
fi

if [ $stage le 1 ]; then
    cat `find /Users/yijing.zhou1022/${data_name} -name "*.wav"` > $datadir/wavlst.txt
    # cat `find /Users/yijing.zhou1022/${data_name} -name "*.txt"` > $datadir/textlst.txt
    python3 get_name.py $datadir/wavlst.txt $datadir/wav.scp
    # python3 get_name.py $datadir/textlst.txt $datadir/text.scp
    cd $datadir
    mkdir -p train dev text
    sed '1,92340p' wav.scp  > train/wav.scp
    sed '92341,100548p' wav.scp  > dev/wav.scp
    sed '100548,102600p' wav.scp  > test/wav.scp
    python3 prepare_data.py /Users/yijing.zhou1022/${data_name} $datadir
fi