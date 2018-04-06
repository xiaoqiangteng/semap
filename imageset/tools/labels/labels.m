close all
clear all

RootPath = '/home/ubuntu/sim/imagenet/labels';
[dir_name, count_labels, labels] = importDataFiles(RootPath);
fp = fopen('/home/ubuntu/sim/imagenet/labels/label.txt','wt');

for i = 1:length(labels)
    fprintf(fp, '''');
    fprintf(fp, '%s', labels{i}, '''', 'delimiter');
    fprintf(fp, );
end
sta = fclose(fp);