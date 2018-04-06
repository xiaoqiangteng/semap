%writeanno.m
clc;
clear all;
 
path_image='S:\ImageNet\jpgImages3\';
path_label='S:\ImageNet\labels3/';%txt文件存放路径
% subdir = dir(path_image);
% 
% for i = 3 : length( subdir )
%     if( isequal( subdir( i ).name, '.' ) || ...
%         isequal( subdir( i ).name, '..' ) || ...
%         ~subdir( i ).isdir )   % 如果不是目录跳过
%         continue;
%     end
%       
%     subdirpath = fullfile(path_xml, subdir( i ).name, '*.xml');
%     xml_files1 = dir( subdirpath );   % 在这个子文件夹下找后缀为xml的文件
% end

files_all=dir(path_image);
for i = 3:length(files_all)
    msg = textread(strcat(path_label, files_all(i).name(1:end-4),'.txt'),'%s');
    clear rec;
    path = ['S:\ImageNet\Annotations3\' files_all(i).name(1:end-4) '.xml'];
    fid=fopen(path,'w');
    rec.annotation.folder = 'VOC2007';%鏁版嵁闆嗗悕

    rec.annotation.filename = files_all(i).name(1:end-4);%鍥剧墖鍚?
    rec.annotation.source.database = 'The VOC2007 Database';%闅忎究鍐?    
    rec.annotation.source.annotation = 'PASCAL VOC2007';%闅忎究鍐?    
    rec.annotation.source.image = 'flickr';%闅忎究鍐?   
    rec.annotation.source.flickrid = '0';%闅忎究鍐?
    rec.annotation.owner.flickrid = 'I do not know';%闅忎究鍐?    
    rec.annotation.owner.name = 'I do not know';%闅忎究鍐?
    img = imread(['S:\ImageNet\jpgImages3/' files_all(i).name]);
    rec.annotation.size.width = int2str(size(img,2));
    rec.annotation.size.height = int2str(size(img,1));
    rec.annotation.size.depth = int2str(size(img,3));

    rec.annotation.segmented = '0';%涓嶇敤浜庡垎鍓?    
    rec.annotation.object.name = msg{2};%绫诲埆鍚?    
    rec.annotation.object.pose = 'Left';%涓嶆寚瀹氬Э鎬?    
    rec.annotation.object.truncated = '1';%娌℃湁琚垹鑺?    
    rec.annotation.object.difficult = '0';%涓嶆槸闅句互璇嗗埆鐨勭洰鏍?    
    rec.annotation.object.bndbox.xmin = msg{3};%鍧愭爣x1
    rec.annotation.object.bndbox.ymin = msg{4};%鍧愭爣y1
    rec.annotation.object.bndbox.xmax = msg{5};%鍧愭爣x2
    rec.annotation.object.bndbox.ymax = msg{6};%鍧愭爣y2
    writexml(fid,rec,0);
    fclose(fid);
end
