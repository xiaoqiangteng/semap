clc;
clear all;
 
path_image = 'S:\ImageNet\jpgImages\';%ԴͼƬ���·��
path_xml = 'S:\ImageNet\Annotations\';
path_image_final = 'S:\ImageNet\jpgImages_final\';
subdir = dir(path_xml);

for i = 3 : length( subdir )
    if( isequal( subdir( i ).name, '.' ) || ...
        isequal( subdir( i ).name, '..' ) || ...
        ~subdir( i ).isdir )   % �������Ŀ¼����
        continue;
    end
    
    % ��������ļ������Һ�׺Ϊxml���ļ�
    subdirpath_xml = fullfile(path_xml, subdir( i ).name, '*.xml');
    xml_files = dir(subdirpath_xml);
        
    % ��������ļ������Һ�׺Ϊjpg���ļ�
    subdirpath_jpg = fullfile(path_image, subdir( i ).name, '*.jpg');
    jpg_files = dir(subdirpath_jpg);
    
    %��Ϊxml�ļ��ĸ���С��jpg�ļ��ĸ�����������xml�ļ�������Ϊ��׼
    %�õ�ÿ�����ļ��µ�xml�ļ���int����
    xml_files2 = [];
    int_xml_files = [];
    for k = 1:length(xml_files)
        xml_files2(k).name = xml_files(k).name(11:end-4);
        int_xml_files(k) = str2num(xml_files2(k).name);
    end

    %�õ�ÿ�����ļ��µ�jpg�ļ���int����
    jpg_files2 = [];
    int_jpg_files = [];
    for k = 1:length(jpg_files)
        jpg_files2(k).name = jpg_files(k).name(11:end-4);
        int_jpg_files(k) = str2num(jpg_files2(k).name);
    end
 
    %��jpg��int�����е�Ԫ������xml��int���Ͻ����ж���������������Ӧjpg�ļ���ָ���ļ����ڣ�
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