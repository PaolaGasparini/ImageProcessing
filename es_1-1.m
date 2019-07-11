% H1_Gasparini Paola
% 7.10.0 (R2010a)

% a) 
close all
% si carica il file usando l'interfaccia uigetfile
% l'immagine deve essere a colori
[nome,percorso]=uigetfile('*.jpg','seleziona una immagine a colori (ad esempio spect_)');
cd(percorso);
figure;
immagineRGB=imread(nome);

% b)
% si visualizza l'immagine caricata
imshow(immagineRGB);
title('IMMAGINE CARICATA')

% c)
% si converte l'immagine in hsv e si visualizza le figure delle 3 componenti

immagineHSV=rgb2hsv(immagineRGB);
immagineHSV_H=gray2ind(immagineHSV(:,:,1));
immagineHSV_S=gray2ind(immagineHSV(:,:,2));
immagineHSV_V=gray2ind(immagineHSV(:,:,3));
hsvmap=colormap(hsv);

s=[hsvmap(:,1) hsvmap(:,2) hsvmap(:,3)];
figure;
subplot(1,3,1)
subimage(immagineHSV_H,hsvmap)
title('COMPONENTE H di hsv')
subplot(1,3,2)
subimage(immagineHSV_S,s)
title('COMPONENTE S di hsv')
subplot(1,3,3)
subimage(immagineHSV_V,colormap(gray))
title('COMPONENTE V di hsv')

% d)
% si converte in scala di grigio
immaginegray1=rgb2gray(immagineRGB);
immaginegray2=0.2989*immagineRGB(:,:,1)+0.5870*immagineRGB(:,:,2)+0.1140*immagineRGB(:,:,3);
% visualizzazione della conversione manuale e di quella effettuata con il
% comando dedicato:
figure;
subplot(1,2,1) 
subimage(immaginegray1);
title('CONVERSIONE IN SCALA DI GRIGIO CON IL COMANDO DEDICATO')
subplot(1,2,2) 
subimage(immaginegray2);
title('CONVERSIONE IN SCALA DI GRIGIO MANUALE')

% e)
% binarizzazione l'immagine per isolare zone attive (rosse)
% Per evidenziare le
% aree rosse non basta utilizzare la matrice del rosso ma bisogna sottrarre
% ad essa le altre due in modo da assicurarsi di prendere solo i pixel
% completamente rossi e non quelli derivanti dalla composizione dei tre
% colori.
immagine=abs(immagineRGB(:,:,1)-immagineRGB(:,:,2)-immagineRGB(:,:,3));
immagineBW=im2bw(immagine,0.2);
figure;
% visualizzazione zone attive
imshow(immagineBW)
title('ZONE ATTIVE (ROSSE)')
% calcolo area(in pixels)
numeropixels_bianchi=size(find(immagineBW==1),1)