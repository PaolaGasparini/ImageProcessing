% H5_Gasparini Paola
% 7.10.0 (R2010a)

close all
im1=imread('spermatozoa01.jpg');
im2=imread('spermatozoa02.jpg');
im3=imread('spermatozoa03.jpg');
im4=imread('spermatozoa04.jpg');
im5=imread('spermatozoa05.jpg');
figure;

subplot(2,3,1),imshow(im1)
title('immagine 1')
subplot(2,3,2),imshow(im2)
title('immagine 2')
subplot(2,3,3),imshow(im3)
title('immagine 3')
subplot(2,3,4),imshow(im4)
title('immagine 4')
subplot(2,3,5),imshow(im5)
title('immagine 5')

% 1)
%  color image enhancement stage
im1=im2double(im3);

im1_mod = imadjust(im1,[0.9 0.4 0.4; 1 .6 0.6]);
figure, imshow(im1_mod) ;title('color enhancement')

% 2)

Igray_red=im1_mod(:,:,1);
Igray_green=im1_mod(:,:,2);
Igray_blue=im1_mod(:,:,3);

t_red=graythresh(Igray_red);
t_green=graythresh(Igray_green);
t_blue=graythresh(Igray_blue);
BW_red=im2bw(Igray_red,t_red);

BW_green=im2bw(Igray_green,t_green);
BW_blue=im2bw(Igray_blue,t_blue);
% figure;
% imshow(BW_red);
% 
% figure;
% imshow(BW_green);
% figure;
% imshow(BW_blue);
figure;
imshow(abs(BW_red-BW_green))
title('immagine risultante dalla selezione del contorno della testa dello spermatozoo')

