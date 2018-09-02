clear
label=0;

csvPath='639TrainFull.csv';
csvFile=csvread(csvPath,1,0);

imgDocSource='E:\UbuntuWorkspace\PartsClassification\dataset\ShuSPadding\GB639\6763';
imgDocTarget='E:\UbuntuWorkspace\PartsClassification\dataset\KaiTPadding\GB639\6763';

outputDoc='E:\UbuntuWorkspace\zi2zi\experiment11\FontImage2_withParts';

counter=639;
for i=1:size(csvFile,1)
    unicode=real(csvFile(i,1));
    GBno=csvFile(i,2);
    PartsOrder=csvFile(i,3);
    imgName=sprintf('%s_%d.bmp',num2str(unicode),PartsOrder);
    imgPathSource=sprintf('%s\\%s',imgDocSource,imgName);
    imgPathTarget=sprintf('%s\\%s',imgDocTarget,imgName);
    imgSource=imread(imgPathSource);
    imgTarget=imread(imgPathTarget);
    imgSource=imresize(imgSource,[256,256]);
    imgTarget=imresize(imgTarget,[256,256]);
    canvas=zeros(256,512,3);
    for j=1:3
        canvas(:,1:256,j)=imgTarget;
        canvas(:,257:512,j)=imgSource;
    end
    
    imgNameOutput=sprintf('%d_%s.jpg',label,num2str(counter,'%04d'));
    imgPathOutput=sprintf('%s\\%s',outputDoc,imgNameOutput);
    imwrite(canvas,imgPathOutput);
    counter=counter+1;
end

disp('Done!');