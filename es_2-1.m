% H2_Gasparini Paola
% 7.10.0 (R2010a)

clear all
close all

f=imread('test_pattern.tif');
g=imread('mri_4ch.tif');
f=im2double(f);
g=im2double(g);

% 1) calcolo spettro e fase di immagine f e li visualizzo
f_Modulo=abs(fft2(f));
f_ModuloShifted=fftshift(f_Modulo);
f_Fase=angle(fft2(f));
figure;
colormap(jet(64));
mesh(log(1+f_ModuloShifted));
title('SPETTRO DI IMMAGINE F')
figure;
mesh(f_Fase)
title('FASE DI IMMAGINE F')

% 2) calcolo l'antitrasformata usando solo termine di fase e visualizzo
% immagine 
fModulo=1;
fFase=angle(fft2(f));
Eulero_solofase=fModulo.*exp(1i*fFase);
figure;
imshow(real(ifft2(Eulero_solofase)),[])
title('ANTITRASFORMATA USANDO SOLO TERMINE DI FASE F')

% 3) calcolo l'antitrasformata usando solo termine di ampiezza e visualizzo
% immagine
fModulo=abs(fft2(f));
fFase=0;
Eulero_solomodulo=fModulo.*exp(1i*fFase);
figure;
imshow(ifft2(Eulero_solomodulo))
title('ANTITRASFORMATA USANDO SOLO TERMINE DI AMPIEZZA F')
% 
% 4) ripeto punti 1-2-3 per immagine g
g_Modulo=abs(fft2(g));
g_ModuloShifted=fftshift(g_Modulo);
g_Fase=angle(fft2(g));
figure;
colormap(jet(64));
mesh(log(1+g_ModuloShifted));
title('SPETTRO DI IMMAGINE G')

figure;
mesh(g_Fase)
title('FASE DI IMMAGINE G')

gModulo=1;
gFase=angle(fft2(g));
Eulero_solofaseg=gModulo.*exp(1i*gFase);
figure;
imshow(real(ifft2(Eulero_solofaseg)),[])
title('ANTITRASFORMATA SOLO FASE G')

gModulo=abs(fft2(g));
gFase=0;
Eulero_solomodulog=gModulo.*exp(1i*gFase);
figure;
imshow(ifft2(Eulero_solomodulog))
title('ANTITRASFORMATA SOLO AMPIEZZA G')

% 5) calcolo l’antitraformata utilizzando il modulo della fft di g e la fase della fft di f
% e viceversa, visualizzando le 2 immagini ottenute. 
figure;
subplot(1,2,1)
subimage(real(ifft2(abs(fft2(g)).*exp(1i*angle(fft2(f))))))
title('Spettro G, Fase F ')
subplot(1,2,2)
subimage(real(ifft2(abs(fft2(f)).*exp(1i*angle(fft2(g))))))
title('Spettro F, Fase G')
% COMMENTO:
% Il termine di fase contiene l'informazione riguardante
% la localizzazione delle features
% dell'immagine, è per questo motivo che le immagini antitrasformate usando
% solo questo termine ci consentono di visualizzare il contenuto
% dell'immagine.
% Le immagini antitrasformate usando solo il termine di ampiezza invece non
% consentono la visualizzazione dell'immagine in quanto 
% lo spettro non contiene il contenuto informativo riguardante 
% la localizzazione delle features e la loro posizione ma solo l'informazione 
% riguardo l'intensità ed il contrasto dell'immagine.
 
