close all; % close any opened figures
clear; % clear any variables from your workspace
clc;
d=20;
level=4;
sigma=0.5;

%%%%%%%DIAVAZW
%image1=zeros(268,400,3);
image1 = imread('AIS405labnotes_2.jpg');
%PAIRNW XRWMA
image2=zeros(size(image1, 1),size(image1, 2),3);
image2=rgb2hsv (image1);
xrwma=zeros(268,400,1);
xrwma=image2(:,:,1);

hsize = [3, 3];  
gauss = fspecial('gaussian',hsize,sigma);
im = conv2(xrwma,gauss); 
colorim=im;
%  figure;
%  imshow(xrwma)
%  colormap(hsv);

histogramma = zeros(256, size(image2, 2));
histogramma =hist(im,256);                                               

%figure;
%bar(histogramma);
 maxx=zeros(level,1);
 minn=zeros(level,1);
 gigjdist=zeros(level,1);

for i=1:level
    
   [ maxx(i),gigjdist(i)]=max(max(histogramma(:, (d*(i-1)+1):d*i)));
    %[r, c]=find(histogramma(:, (20*(i-1)+1):20*i)==maxx(i))
    gigjdist(i)=gigjdist(i)+d*(i-1)+1;
end

for i = 1:level-1
    
[k,threshold(i)] = min(min(histogramma(:,gigjdist(i):gigjdist(i+1)))); % the lowest value between the peaks is the location of the threshold
 threshold(i) = threshold(i)+gigjdist(i) ;
end

im(im <= im(threshold(1)))=  10;                  
im(im > im(threshold(1)) & im <= im(threshold(2)) )  = 240;
%im(im > im(threshold(2)) & im <= im(threshold(3)) )  = 256;
im(im > im(threshold(2)) ) = 150;  
figure
imshow(im);
colormap(gray)
