function [dir_name, count, label]=importDataFiles(RootPath)
%<=============================数据批量导入===============================>%
DirOutput = dir(fullfile(RootPath));           %读取式样编号文件名,dir
SimpleName = {DirOutput(3:end).name}';           %函数读出的结果为结构数组，
LenSimFile = length(SimpleName);%得到所有txt文件的个数

for i=1:LenSimFile
    fileName = fullfile(RootPath,SimpleName{i});
    switch SimpleName{i}
        case 'map_clsloc.txt'
            [dir_name, count, label] = textread(fileName,'%s%d%s');
    end    
end

end
