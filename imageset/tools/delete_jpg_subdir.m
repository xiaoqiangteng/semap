clc;
clear all;
  
maindir = 'S:\ImageNet\JPEGImages\';
xml_path = 'S:\ImageNet\jpgImages1\';
subdir =  dir( maindir );   % 先确定子文件夹
 
for i = 1 : length( subdir )
    if( isequal( subdir( i ).name, '.' ) || ...
        isequal( subdir( i ).name, '..' ) || ...
        ~subdir( i ).isdir )   % 如果不是目录跳过
        continue;
    end
     
    subdirpath = fullfile( maindir, subdir( i ).name, '*.jpg' );
    xml_files = dir( subdirpath );   % 在这个子文件夹下找后缀为jpeg的文件
    xml_path_subdir1 = strcat(maindir, subdir( i ).name);
    xml_path_subdir = strcat(xml_path_subdir1, '\');
    
     for j = 1 : length(xml_files)
         xml_path_subdir_name = strcat(xml_path_subdir, xml_files(j).name);
         copyfile(xml_path_subdir_name, xml_path);
     end
end