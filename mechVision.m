close all; % close any opened figures
clear; % clear any variables from your workspace
clc;
d=20;
level=4;
sigma=0.5;

%%%%%%%DIAVAZW
%image1=zeros(268,400,3);
image1 = imread('image_0001.jpg');
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
