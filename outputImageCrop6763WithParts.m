inferDoc='E:\UbuntuWorkspace\zi2zi\experiment11\infer2\infer';
cropCharDoc='E:\UbuntuWorkspace\zi2zi\experiment11\infer2\cropChar';
cropPartsDoc='E:\UbuntuWorkspace\zi2zi\experiment11\infer2\cropParts';
GB6763Txt='E:\WorkSpace\Matlab\GB6763.txt';
fpp=fopen(GB6763Txt,'r');
GB6763=fgetl(fpp);
fclose(fpp);

csvPath='test-639.csv';
csvFile=csvread(csvPath,1,0);

canvas_size=300;

images=dir(inferDoc);
imageNames={images.name}';
imageNames=string(imageNames(3:length(imageNames)));

[~,I]=sort(imageNames);
imageNames=imageNames(I);

GBno=1;
parts_index=1;
for i=1:length(imageNames)
    disp(i)
    imagePath=sprintf('%s\\%s',inferDoc,imageNames(i));
    image=imread(imagePath);
    for j=1:256:size(image,2)-255
        for k=1:256:size(image,1)-255
            imageCrop=image(k:k+255,j:j+255,1);
            canvas=true(canvas_size);
            imageCropResize=imresize(imageCrop,[canvas_size,canvas_size]);
            for r=1:canvas_size
                for c=1:canvas_size
                    if(imageCropResize(r,c)<=128)
                        canvas(r,c)=0;
                    else
                        canvas(r,c)=1;
                    end
                end
            end

            if GBno<=size(GB6763,2)
                unicode=real(GB6763(GBno));
                imageCharCropPath=sprintf('%s\\%s.bmp',cropCharDoc,num2str(unicode));
                %imageCropPath=sprintf('%s\\%d.bmp',cropDoc,GBno);
                imwrite(canvas,imageCharCropPath);
                %imwrite(imageCrop,imageCropPath);
                GBno=GBno+1;
            elseif parts_index<=size(csvFile,1)
                unicode=real(csvFile(parts_index,1));
                parts_order=csvFile(parts_index,3);
                imagePartsCropPath=sprintf('%s\\%s_%d.bmp',cropPartsDoc,num2str(unicode),parts_order);
                [r,c]=find(canvas==0);
                maxr=max(r);
                maxc=max(c);
                minr=min(r);
                minc=min(c);
                canvas=(canvas(minr:maxr,minc:maxc));
                imwrite(canvas,imagePartsCropPath);
                parts_index=parts_index+1;
            else
                break
            end
        end
    end
end
disp('Done!')