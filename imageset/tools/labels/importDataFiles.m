function [dir_name, count ,labels]=importDataFiles(RootPath)
%<=============================�����������===============================>%
DirOutput = dir(fullfile(RootPath));           %��ȡʽ�����ļ���,dir
SimpleName = {DirOutput(3:end).name}';           %��������Ľ��Ϊ�ṹ���飬
LenSimFile = length(SimpleName);%�õ�����txt�ļ��ĸ���

for i=1:LenSimFile
    fileName = fullfile(RootPath,SimpleName{i});
    switch SimpleName{i}
        case 'map_clsloc.txt'
            [dir_name, count, labels] = textread(fileName,'%s%d%s');
    end    
end

end
