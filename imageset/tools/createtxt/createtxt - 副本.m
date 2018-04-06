%createtxt.m
clc;
clear all;
 
path_image='S:\ImageNet\JPEGImages1\';%ԴͼƬ���·��
path_label='S:\ImageNet\JPEGImages1\labels/';%txt�ļ����·��
files_all=dir(path_image);

for i = 3:length(files_all)
    sprintf('i = %d',i)
    clear rec;
    pathSrcXml = ['./n00007846/' files_all(i).name(1:end-4) '.xml'];%����imageNetĳһ����xml�ļ���Ŀ¼
    sprintf('%s', pathSrcXml)
    pathtxt = ['./labels/' files_all(i).name(1:end-4) '.txt'];
    sprintf('%s', pathtxt)
    str = fileread( pathSrcXml );
    v = xml_parse( str );
    xmin = v.object.bndbox.xmin
    ymin = v.object.bndbox.ymin
    xmax = v.object.bndbox.xmax
    ymax = v.object.bndbox.ymax
    filename = v.filename
    %filename = 
    fid = fopen(pathtxt,'wt')
    fprintf(fid,'%s%s',filename,'.jpg')
    fprintf(fid,'%c',' ');
    fprintf(fid,'%s','ship')
    fprintf(fid,'%c',' ');
    fprintf(fid,'%c',xmin);
    fprintf(fid,'%c',' ');
    fprintf(fid,'%c',ymin);
    fprintf(fid,'%c',' ');
    fprintf(fid,'%c',xmax);
    fprintf(fid,'%c',' ');
    fprintf(fid,'%c',ymax);
    fclose(fid);
end