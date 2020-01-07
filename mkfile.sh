#########################################################################
# File Name: random-file.sh
# Author : szullc
# Created Time: 2018年12月03日 星期一 11时28分23秒
#########################################################################
#!/bin/bash -e
 
out_file_name=$1
file_size=$2
size_unit=$3
tmp_out_file_name=$out_file_name.tmp
 
function check_input_param()
{
    if [[ "a" == "a"$out_file_name || "a" == "a"$file_size || "a" == "a"$size_unit ]]; then
        echo "Error param input !"
        echo "Type in like this: $0 [out-file-name] [file-szie] [size-unit]"
        echo "param list as follow:"
        echo "[out-file-name]: input your output file name, Relative path and absolute path are OK."
        echo "[file-size]: The file size of output file, which must be an integer."
        echo "[size-unit]: Only support K/M/G. They mean xxxKB/xxxMB/xxxGB."
        exit
    fi
}
 
function check_file_size_if_integer()
{
    if [ -n "$file_size" -a "$file_size" = "${file_size//[^0-9]/}" ]; then
        echo "file_size=$file_size"
    else
        echo "[file-size] error: The file size of output file, which must be an integer."
    exit
    fi
}
 
function check_size_unit()
{
    if [[ "K" != $size_unit && "M" != $size_unit && "G" != $size_unit ]]; then
        echo "[size-unit] error: Only support K/M/G. They mean xxxKB/xxxMB/xxxGB."
        exit
    fi
}
 
function create_random_file()
{
    dd if=/dev/urandom of=$tmp_out_file_name bs=1$size_unit count=$file_size conv=notrunc
    mv $tmp_out_file_name $out_file_name
}
 
 
check_input_param
check_file_size_if_integer
check_size_unit
create_random_file