% H3_Gasparini Paola
% 7.10.0 (R2010a)

clear all
close all
% 1)
immagine=imread('CT_head_corrupted.tif');
figure;
imshow(immagine)
title('IMMAGINE ORIGINALE')

X=fftshift(fft2(immagine));
figure; 
mesh(log(1+abs(X)));
title('RISPOSTA IN FREQUENZA DI IMMAGINE ORIGINALE CORROTTA')

H=ones(512/10,512/10);
% band-reject:

  % Lavoro direttamente in 2d, per eliminare i ripple
  % l'ottimalità si ha con l'utilizzo di una maschera
  % più grande ma questo voleva dire un tempo di calcolo maggiore.
                                            
H(230/10:240/10,250/10:260/10)=0;   %Per eliminare sinusoide orizzontale 
H(270/10:280/10,250/10:260/10)=0; 

H(256/10:258/10,246/10:248/10)=0;   %Per eliminare sinusoide verticale 
H(256/10:258/10,266/10:268/10)=0;

H(200/10:230/10,200/10:230/10)=0;   %Per eliminare sinusoide inclinata 
H(300/10:320/10,300/10:320/10)=0;

% [f1,f2]=freqspace(512/10,'meshgrid');
figure;
h=fsamp2(H);
freqz2(h) 
title('RISPOSTA IN FREQUENZA DEL FILTRO BAND-REJECT')

im_filtrata=imfilter(immagine,h,'conv');
figure;
imshow(im_filtrata,[])
title('IMMAGINE FILTRATA')

figure;  
mesh(log(1+abs(fftshift(fft2(im_filtrata)))));
title('RISPOSTA IN FREQUENZA DI IMMAGINE FILTRATA')
%2)
H=zeros(512/10,512/10);
% band-pass:
                                          
H(230/10:240/10,250/10:260/10)=1;   %Per sinusoide orizzontale 
H(270/10:280/10,250/10:260/10)=1; 

H(256/10:258/10,246/10:248/10)=1;   %Per sinusoide verticale 
H(256/10:258/10,266/10:268/10)=1;

H(200/10:230/10,200/10:230/10)=1;   %Per sinusoide inclinata 
H(300/10:320/10,300/10:320/10)=1;
% [f1,f2]=freqspace(512/10,'meshgrid');
figure;
h=fsamp2(H);
freqz2(h) 
title('RISPOSTA IN FREQUENZA DEL FILTRO BAND-PASS')
im_rumore=imfilter(immagine,h,'conv');
figure;
imshow(im_rumore,[])
title('IMMAGINE RUMORE')