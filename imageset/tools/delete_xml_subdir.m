clc;
clear all;
  
maindir = 'S:\ImageNet\Annotations\';
xml_path = 'S:\ImageNet\Annotations1\';
subdir =  dir( maindir );   % ��ȷ�����ļ���
 
for i = 1 : length( subdir )
    if( isequal( subdir( i ).name, '.' ) || ...
        isequal( subdir( i ).name, '..' ) || ...
        ~subdir( i ).isdir )   % �������Ŀ¼����
        continue;
    end
     
    subdirpath = fullfile( maindir, subdir( i ).name, '*.xml' );
    xml_files = dir( subdirpath );   % ��������ļ������Һ�׺Ϊjpeg���ļ�
    xml_path_subdir1 = strcat(maindir, subdir( i ).name);
    xml_path_subdir = strcat(xml_path_subdir1, '\');
    
     for j = 1 : length(xml_files)
         xml_path_subdir_name = strcat(xml_path_subdir, xml_files(j).name);
         copyfile(xml_path_subdir_name, xml_path);
     end
end