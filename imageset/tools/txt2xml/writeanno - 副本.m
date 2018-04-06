%writeanno.m
clc;
clear all;
 
path_image='S:\ImageNet\jpgImages3\';
path_label='S:\ImageNet\labels3/';%txt�ļ����·��
% subdir = dir(path_image);
% 
% for i = 3 : length( subdir )
%     if( isequal( subdir( i ).name, '.' ) || ...
%         isequal( subdir( i ).name, '..' ) || ...
%         ~subdir( i ).isdir )   % �������Ŀ¼����
%         continue;
%     end
%       
%     subdirpath = fullfile(path_xml, subdir( i ).name, '*.xml');
%     xml_files1 = dir( subdirpath );   % ��������ļ������Һ�׺Ϊxml���ļ�
% end

files_all=dir(path_image);
for i = 3:length(files_all)
    msg = textread(strcat(path_label, files_all(i).name(1:end-4),'.txt'),'%s');
    clear rec;
    path = ['S:\ImageNet\Annotations3\' files_all(i).name(1:end-4) '.xml'];
    fid=fopen(path,'w');
    rec.annotation.folder = 'VOC2007';%数据集名

    rec.annotation.filename = files_all(i).name(1:end-4);%图片�?
    rec.annotation.source.database = 'The VOC2007 Database';%随便�?    
    rec.annotation.source.annotation = 'PASCAL VOC2007';%随便�?    
    rec.annotation.source.image = 'flickr';%随便�?   
    rec.annotation.source.flickrid = '0';%随便�?
    rec.annotation.owner.flickrid = 'I do not know';%随便�?    
    rec.annotation.owner.name = 'I do not know';%随便�?
    img = imread(['S:\ImageNet\jpgImages3/' files_all(i).name]);
    rec.annotation.size.width = int2str(size(img,2));
    rec.annotation.size.height = int2str(size(img,1));
    rec.annotation.size.depth = int2str(size(img,3));

    rec.annotation.segmented = '0';%不用于分�?    
    rec.annotation.object.name = msg{2};%类别�?    
    rec.annotation.object.pose = 'Left';%不指定姿�?    
    rec.annotation.object.truncated = '1';%没有被删�?    
    rec.annotation.object.difficult = '0';%不是难以识别的目�?    
    rec.annotation.object.bndbox.xmin = msg{3};%坐标x1
    rec.annotation.object.bndbox.ymin = msg{4};%坐标y1
    rec.annotation.object.bndbox.xmax = msg{5};%坐标x2
    rec.annotation.object.bndbox.ymax = msg{6};%坐标y2
    writexml(fid,rec,0);
    fclose(fid);
end
