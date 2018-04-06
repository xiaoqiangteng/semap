%createtxt.m
clc;
clear all;
 
RootPath = 'S:\ImageNet';
[dir_name, count, label] = importDataFiles(RootPath);

path_image = 'S:\ImageNet\JPEGImages1\';%ԴͼƬ���·��
path_xml = 'S:\ImageNet\Annotations1\';
path_label = 'S:\ImageNet\labels\';%txt�ļ����·��
subdir = dir(path_xml);
 
for i = 3 : length( subdir )
    if( isequal( subdir( i ).name, '.' ) || ...
        isequal( subdir( i ).name, '..' ) || ...
        ~subdir( i ).isdir )   % �������Ŀ¼����
        continue;
    end
      
    subdirpath = fullfile(path_xml, subdir( i ).name, '*.xml');
    xml_files1 = dir( subdirpath );   % ��������ļ������Һ�׺Ϊxml���ļ�
    
    %��xml�ļ���������
    for k = 1:length(xml_files1)
        xml_files2(k).name = xml_files1(k).name(11:end-4);
        int_xml_files(k) = str2num(xml_files2(k).name);
    end
    int_xml = sort(int_xml_files);
    
    for ii = 1:length(xml_files1)
        xml_files3 = strcat(subdir( i ).name, '_');
        xml_files4 = strcat(xml_files3, num2str(int_xml(ii)));
        xml_files(ii).name = strcat(xml_files4, '.xml');
    end
    
    % ������xml�ļ�
    for j = 1 : length(xml_files)
        disp(j);
        try
            pathtxt1 = strcat(path_label, subdir( i ).name);
            pathtxt2 = strcat(pathtxt1, '\');
            pathtxt = [pathtxt2 xml_files( j ).name(1:end-4) '.txt'];
            subdir_xml = fullfile(path_xml, subdir( i ).name, xml_files( j ).name);
            str = fileread(subdir_xml);
            v = xml_parse( str );
            xmin = v.object.bndbox.xmin;
            ymin = v.object.bndbox.ymin;
            xmax = v.object.bndbox.xmax;
            ymax = v.object.bndbox.ymax;
            filename = v.filename;
            fid = fopen(pathtxt,'wt');
            fprintf(fid,'%s%s',filename,'.jpg');
            fprintf(fid,'%c',' ');
            fprintf(fid,'%s', label{i-2});
            fprintf(fid,'%c',' ');
            fprintf(fid,'%c',xmin);
            fprintf(fid,'%c',' ');
            fprintf(fid,'%c',ymin);
            fprintf(fid,'%c',' ');
            fprintf(fid,'%c',xmax);
            fprintf(fid,'%c',' ');
            fprintf(fid,'%c',ymax);
            fclose(fid);
        catch
            delete_image1 = strcat(path_image, subdir( i ).name);
            delete_image2 = strcat(delete_image1, '\');
            delete_image = [delete_image2, xml_files( j ).name(1:end-4), '.jpg'];
            delete(delete_image);
            delete_xml1 = strcat(path_xml, subdir( i ).name);
            delete_xml2 = strcat(delete_xml1, '\');
            delete_xml = [delete_xml2, xml_files( j ).name(1:end-4), '.xml'];
            delete(delete_xml);
        end
    end
    xml_files = [];
end
