clc;
clear all;
  
path_image = 'S:\ImageNet\jpgImages\';%源图片存放路径
path_xml = 'S:\ImageNet\Annotations\';
subdir_jpg = dir(path_image);
subdir_xml = dir(path_xml);

count_jpg = 1;
for i = 3 : length(subdir_jpg)
    if( isequal( subdir_jpg( i ).name, '.' ) || ...
        isequal( subdir_jpg( i ).name, '..' ) || ...
        ~subdir_jpg( i ).isdir )   % 如果不是目录跳过
        continue;
    end
    int_subdir_jpg(count_jpg) = str2num(subdir_jpg( i ).name(2:end));
    count_jpg = count_jpg + 1; 
end

count_xml = 1;
for j = 3 : length(subdir_xml)
    if( isequal( subdir_xml(j).name, '.' ) || ...
        isequal( subdir_xml(j).name, '..' ) || ...
        ~subdir_xml(j).isdir )   % 如果不是目录跳过
        continue;
    end
    int_subdir_xml(count_xml) = str2num(subdir_xml(j).name(2:end));
    count_xml = count_xml + 1; 
end

for k = 1:length(int_subdir_xml)
    if ismember(int_subdir_xml(k), int_subdir_jpg);
        disp('Belong');
    else
        delete_path_xml = strcat(path_xml, subdir_xml(k+2).name);
        rmdir(delete_path_xml, 's');
    end
end