close all
clear all

RootPath = 'S:\ImageNet';
[dir_name, count_labels, labels] = importDataFiles(RootPath);

maindir = 'S:\ImageNet\jpgImages\';
subdir =  dir( maindir );   % 先确定子文件夹
fp = fopen('S:\ImageNet\map_clsloc.txt','wt');

count = 1;
for i = 1 : length( subdir )
    if( isequal( subdir( i ).name, '.' ) || ...
        isequal( subdir( i ).name, '..' ) || ...
        ~subdir( i ).isdir )   % 如果不是目录跳过
        continue;
    end
    
    for j = 1:length(dir_name)
         if strcmp(subdir( i ).name, dir_name{j})
            fprintf(fp, '%s\t', subdir( i ).name);
            fprintf(fp, '%d\t', count);
            fprintf(fp, '%s\t\n', labels{j});
            count = count + 1;
            break;
         end
    end
end
sta = fclose(fp);