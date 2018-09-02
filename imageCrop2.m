%用来对zi2zi生成的639结果进行裁剪，以便进行训练

clear
fpp=fopen('GB639.txt');
GB639=fgetl(fpp);
fclose(fpp);

image_size=300;

imgStandardDoc='E:\UbuntuWorkspace\PartsDetection\PartsDevkit\BMPImages';
imgInputDoc='E:\UbuntuWorkspace\zi2zi\experiment11\infer2\cropChar';
imgOutputDoc='E:\UbuntuWorkspace\zi2zi\experiment11\infer2\cropChar639';

for i=1:size(GB639,2)
    unicode=real(GB639(i));
    img_standardPath=sprintf('%s\\%s.bmp',imgStandardDoc,num2str(unicode));
    img_standard=imread(img_standardPath);
    [standard_r,standard_c]=size(img_standard);%注意位数
    img_inputPath=sprintf('%s\\%s.bmp',imgInputDoc,num2str(unicode));
    img_input=imread(img_inputPath);
    
    margin_left=floor((image_size-standard_c)/2);
    margin_up=floor((image_size-standard_r)/2);
    margin_right=image_size-standard_c-margin_left;
    margin_down=image_size-standard_r-margin_up;
    
    img_output=img_input(margin_up+1:image_size-margin_down,margin_left+1:image_size-margin_right);
    img_outputPath=sprintf('%s\\%s.bmp',imgOutputDoc,num2str(unicode));
    imwrite(img_output,img_outputPath);
end
disp('Done!');



