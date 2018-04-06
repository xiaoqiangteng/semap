clc;
clear all;
 
path_image = 'S:\ImageNet\jpgImages\';%源图片存放路径
path_xml = 'S:\ImageNet\Annotations\';
path_image_final = 'S:\ImageNet\jpgImages_final\';
subdir = dir(path_xml);

for i = 3 : length( subdir )
    if( isequal( subdir( i ).name, '.' ) || ...
        isequal( subdir( i ).name, '..' ) || ...
        ~subdir( i ).isdir )   % 如果不是目录跳过
        continue;
    end
    
    % 在这个子文件夹下找后缀为xml的文件
    subdirpath_xml = fullfile(path_xml, subdir( i ).name, '*.xml');
    xml_files = dir(subdirpath_xml);
        
    % 在这个子文件夹下找后缀为jpg的文件
    subdirpath_jpg = fullfile(path_image, subdir( i ).name, '*.jpg');
    jpg_files = dir(subdirpath_jpg);
    
    %因为xml文件的个数小于jpg文件的个数，所以以xml文件的数量为基准
    %得到每个子文件下的xml文件的int集合
    xml_files2 = [];
    int_xml_files = [];
    for k = 1:length(xml_files)
        xml_files2(k).name = xml_files(k).name(11:end-4);
        int_xml_files(k) = str2num(xml_files2(k).name);
    end

    %得到每个子文件下的jpg文件的int集合
    jpg_files2 = [];
    int_jpg_files = [];
    for k = 1:length(jpg_files)
        jpg_files2(k).name = jpg_files(k).name(11:end-4);
        int_jpg_files(k) = str2num(jpg_files2(k).name);
    end
 
    %对jpg的int集合中的元素利用xml的int集合进行判定，若存在则复制相应jpg文件至指定文件夹内；
    path_jpg_old1 = strcat(path_image, subdir( i ).name);
    path_jpg_old2 = strcat(path_jpg_old1, '\');
    mkdir(path_image_final, subdir( i ).name);
    path_jpg_new1 = strcat(path_image_final, subdir( i ).name);
    path_jpg_new2 = strcat(path_jpg_new1, '\');
    for ii = 1:length(int_jpg_files)
        if ismember(int_jpg_files(ii), int_xml_files);
            path_jpg_old = strcat(path_jpg_old2,  jpg_files(ii).name);
            imgdata = imread(path_jpg_old);
            path_jpg_new = strcat(path_jpg_new2,  jpg_files(ii).name);
            imwrite(imgdata, path_jpg_new);
        end
    end
end