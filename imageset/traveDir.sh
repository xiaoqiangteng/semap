#! /bin/bash
function read_dir(){
for file in `ls $1`       #注意此处这是两个反引号，表示运行系统命令
do
if [ -d $1"/"$file ]  #注意此处之间一定要加上空格，否则会报错
then
echo $1$file
read_dir $1"/"$file
else
mv $1"/"$file /home/teng/programmings/datasets/imagenet/imagenet/Annotations
fi
done
}   

function delete_dir(){
for file in `ls $1`
do
if [ -d $1"/"$file ]
then
echo $1$"/"file
rm -rf $1"/"$file
fi
done
}

    #读取第一个参数
read_dir $1
delete_dir $1
