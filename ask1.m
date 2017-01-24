close all; % close any opened figures
clear; % clear any variables from your workspace
clc;
%imview close all;
sigma =0.5;


[imagee,map] = imread('AIS405labnotes_3.jpg');
gmap = rgb2gray(imagee);
figure, imshow(gmap);
[r,c] = size(gmap);


%Gaussian
hsize = [3, 3];  
gauss = fspecial('gaussian',hsize,sigma);
im = conv2(double(gauss),double(gmap));        % Smooth
% im=imfilter(gmap, gauss);
figure
imagesc(im)
colormap(gray)

%Gradients
Gx=[-1 1;-1 1]
Gy=[1 1;-1 -1]
derx=conv2(double(im), double(Gx));
dery=conv2(double(im), double(Gy));
%derx=imfilter(double(im), double(Gx));
%dery=imfilter(double(im), double(Gy));
figure
imshow(derx)
figure
imshow(dery)
M=sqrt(derx.*derx + dery.*dery);
theta = atan2(derx, dery)*(180/pi); %briskw moires
figure (45)
imshow(M)

threshold=[22.5 67.5 112.5 157.5];
theta(abs(theta) <= threshold(1))=  0;                  
theta(abs(theta) > threshold(1) & abs(theta) <= threshold(2) )  = 1;
theta(abs(theta) > threshold(2) & abs(theta) <= threshold(3) )  = 2;
theta(abs(theta) > threshold(3) & abs(theta) <= threshold(4) )=  3;  
theta(abs(theta) > threshold(4)) = 0;


%non maxima suppression
for i=2:c-1
    for k=2:r-1
        if theta(k, i) ==0
            if M(k, i)<M(k, i-1) || M(k, i)<M(k, i+1)
                M(k, i)=0;
            end
        end
        if theta(k, i) ==1
            if M(k, i)<M(k-1, i+1) || M(k, i)<M(k+1, i-1)
                M(k, i)=0;
            end
        end
        if theta(k, i) ==2
            if M(k, i)<M(k-1, i) || M(k, i)<M(k+1, i)
                M(k, i)=0;
            end
        end
        if theta(k, i) ==3
            if M(k, i)<M(k-1, i-1) || M(k, i)<M(k+1, i+1)
                M(k, i)=0;
            end
        end
    end
end

%  figure              
%imshow(M)


%thresholding\
T1=0.05*max(max(M));
T2=0.15*max(max(M));
M1=M;
M2=M;
M1((M>=T2))=256;
M1((M<T2))=0;
figure (55)             
imshow(M1)

M2((M>=T1))=256;
M2((M<T1))=0;
 figure (56)             
imshow(M2)


%linking
for i=2:size(M1, 1)%grammes
    for k=2:size(M1, 2)%sthles
        if(M1(i, k)==256)
            if(M1(i-1, k)==256 | M1(i+1, k)==256 | M1(i, k+1)==256 | M1(i, k-1)==256 | M1(i+1, k+1)==256 | M1(i+1, k-1)==256 | M1(i-1, k+1)==256 | M1(i-1, k-1)==256)%panw
                continue;
            else 
                if(M2(i-1, k)==256)%panw
                    M1(i-1, k)=256;              
                elseif M2(i+1, k)==256%katw
                    M1(i+1, k)=256;
                elseif M2(i, k+1)==256%dexia
                    M1(i, k+1)=256;
                elseif M2(i, k-1)==256%aristera
                    M1(i, k-1)=256;
                elseif M2(i+1, k+1)==256%katw dexia
                    M1(i+1, k+1)=256;
                elseif M2(i+1, k-1)==256%katw aristera
                    M1(i+1, k-1)=256; 
                elseif M2(i-1, k+1)==256%panw dexia
                    M1(i-1, k+1)=256;
                elseif M2(i-1, k-1)==256%panw aristera
                    M1(i-1, k-1)=256;
                end
            end
        end
    end
end
       figure (33) 
      imshow(M1)         










