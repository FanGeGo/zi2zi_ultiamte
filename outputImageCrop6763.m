inferDoc='E:\UbuntuWorkspace\zi2zi\experiment0\infer';
cropDoc='E:\UbuntuWorkspace\zi2zi\experiment0\crop';
GB6763Txt='E:\WorkSpace\Matlab\GB6763.txt';
fpp=fopen(GB6763Txt,'r');
GB6763=fgetl(fpp);
fclose(fpp);
canvas_size=256;

images=dir(inferDoc);
imageNames={images.name}';
imageNames=string(imageNames(3:length(imageNames)));

[~,I]=sort(imageNames);
imageNames=imageNames(I);

GBno=1;
for i=1:length(imageNames)
        imagePath=sprintf('%s\\%s',inferDoc,imageNames(i));
        image=imread(imagePath);
        for j=0:256:256*9
            for k=0:256:256*15
                imageCrop=image(k+1:k+256,j+1:j+256,1);
                if GBno<=size(GB6763,2)
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
                    unicode=real(GB6763(GBno));
                    imageCropPath=sprintf('%s\\%s.bmp',cropDoc,num2str(unicode));
                    %imageCropPath=sprintf('%s\\%d.bmp',cropDoc,GBno);
                    imwrite(canvas,imageCropPath);
                    %imwrite(imageCrop,imageCropPath);
                    GBno=GBno+1;
                else
                    return
                end
            end
        end
end
disp('Done!')