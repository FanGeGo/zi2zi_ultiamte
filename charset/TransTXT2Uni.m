%���ڽ�txt�ļ��е�����ת��Ϊ��ʵ����Ҫ��unicode��ʽ
GB6763File='E:\WorkSpace\Matlab\GB639.txt';
GBOutputFile='E:\WorkSpace\Matlab\Uni-GB639.txt';

%��ȡ�Ż��б�
fpp=fopen(GB6763File);
txt_OptimizeList=fgetl(fpp);
fclose(fpp);

fpp=fopen(GBOutputFile,'w');

for i=1:639
    uni_current=real(txt_OptimizeList(i));
    uni_current=dec2hex(uni_current);
    fprintf(fpp,'\"\\u%s\", ',lower(uni_current));
end
fclose(fpp);