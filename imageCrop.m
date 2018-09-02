clear
imgName='C:\Users\YCIrving\Desktop\19969_1.bmp';
imgNewName='C:\Users\YCIrving\Desktop\19969_1_new.bmp';
img=imread(imgName);
img=imresize(img,[300,300]);
[r,c]=find(img(:,:,1)==0);
maxr=max(r);
maxc=max(c);
minr=min(r);
minc=min(c);

imgNew=img(minr:maxr,minc:maxc,:);
imwrite(imgNew,imgNewName);



