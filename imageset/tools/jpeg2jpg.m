clc;
clear all;
 
maindir = 'S:\ImageNet\jpgImages\';
subdir =  dir( maindir );   % 先确定子文件夹
 
for i = 1 : length( subdir )
    if( isequal( subdir( i ).name, '.' ) || ...
        isequal( subdir( i ).name, '..' ) || ...
        ~subdir( i ).isdir )   % 如果不是目录跳过
        continue;
    end
     
    subdirpath = fullfile( maindir, subdir( i ).name, '*.JPEG' ); %subdir( i ).name = 'n00007846'; subdirpath = S:\ImageNet\JPEGImages1\n00007846\*.JPEG;
    images = dir( subdirpath );   % 在这个子文件夹下找后缀为jpeg的文件
     
    % 遍历每张图片
    for j = 1 : length( images )
        imagepath = fullfile(maindir, subdir( i ).name, images( j ).name);
        imgdata = imread( imagepath);   % 这里进行你的读取操作
        subdirpath1 = strcat(maindir, subdir( i ).name);
        subdirpath = strcat(subdirpath1, '\');
        jpgPath = [subdirpath, images( j ).name(1:end-5), '.jpg'];
        imwrite(imgdata, jpgPath);
        delete(imagepath, images( j ).name);
    end
end

% path_image='D:\BaiduYunDownload\ImageNet\JPEGImages\';
% path_image1='D:\BaiduYunDownload\ImageNet\JPEGImages1\';
% file_all = dir(path_image);
% for i = 3:length(file_all)
%     JPEGPath = [path_image,file_all(i).name];
%     fprintf('JPEGPath = %s\n',JPEGPath)
%     img = imread(JPEGPath);
%     
%     jpgPath = [path_image1,file_all(i).name(1:end-5),'.jpg'];
%     fprintf('jpgPath = %s\n',jpgPath)
%     
%     imwrite(img,jpgPath)
% end