% H1_Gasparini Paola
% 7.10.0 (R2010a)

% a) visualizzo l’immagine e lo spettro
im=imread('mri_4ch.tif');
im=im2double(im);
figure;
imshow(im)
title('IMMAGINE ORIGINALE')
figure;
modulo=abs(fft2(im));
modshifted=fftshift(modulo);
colormap(jet(64))
mesh(log(1+modshifted))
title('SPETTRO DI IMMAGINE ORIGINALE')



% 1) creo due filtri medi di ampiezza 5 e 15
masch5=fspecial('average',5);
P5=size(im,1)+size(masch5,1)-1;
Q5=size(im,2)+size(masch5,2)-1;
F=fft2(im,P5,Q5);
H5=fft2(masch5,P5,Q5);
G5=F.*H5;
G5_pad=real(ifft2(G5));

masch15=fspecial('average',15);
P15=size(im,1)+size(masch15,1)-1;
Q15=size(im,2)+size(masch15,2)-1;
F=fft2(im,P15,Q15);
H15=fft2(masch15,P15,Q15);
G15=F.*H15;
G15_pad=real(ifft2(G15));

% creo filtro gaussiano con deviazione standard pari a 2

masch_Gaus=fspecial('gaussian',5,2);
P_Gaus=size(im,1)+size(masch_Gaus,1)-1;
Q_Gaus=size(im,2)+size(masch_Gaus,2)-1;
H_Gaus=fft2(masch_Gaus,P_Gaus,Q_Gaus);
F=fft2(im,P_Gaus,Q_Gaus);
G_Gaus=F.*H_Gaus;
G_Gaus_pad=real(ifft2(G_Gaus));

% creo filtro unsharp
masch_Unsharp=fspecial('unsharp');
P_Unsharp=size(im,1)+size(masch_Unsharp,1)-1;
Q_Unsharp=size(im,2)+size(masch_Unsharp,2)-1;
H_Unsharp=fft2(masch_Unsharp,P_Unsharp,Q_Unsharp);
F=fft2(im,P_Unsharp,Q_Unsharp);
G_Unsharp=F.*H_Unsharp;
G_Unsharp_pad=real(ifft2(G_Unsharp));

%  visualizzo lo spettro di frequenza di tutti i filtri
figure;
subplot(2,2,1)
freqz2(masch5)
title('FILTRO MEDIO MASCHERA 5')
subplot(2,2,2)
freqz2(masch15)
title('FILTRO MEDIO MASCHERA 15')
subplot(2,2,3)
freqz2(masch_Gaus)
title('FILTRO GAUSSIANO')
subplot(2,2,4)
freqz2(masch_Unsharp)
title('FILTRO UNSHARP')

% 2) visualizzo lo spettro di tutte le immagini filtrate con i vari filtri
figure;
subplot(2,2,1)
mesh(log(1+fftshift(abs(G5))))
title('Spettro immagine con filtro medio 5')
axis tight
subplot(2,2,2)
mesh(log(1+fftshift(abs(G15))))
title('spettro immagine con filtro medio 15')
axis tight
subplot(2,2,3)
mesh(log(1+fftshift(abs(G_Gaus))))
title('spettro immagine con filtro gaussiano')
axis tight
subplot(2,2,4)
mesh(log(1+fftshift(abs(G_Unsharp))))
title('spettro immagine con unsharp')
axis tight

% visualizzo le immagini risultanti dal filtraggio
figure;
subplot(2,2,1)
subimage(G5_pad)
title('Immagine con filtro medio 5')
subplot(2,2,2)
subimage(G15_pad)
title('immagine con filtro medio 15')
subplot(2,2,3)
subimage(G_Gaus_pad)
title('immagine con filtro gaussiano')
subplot(2,2,4)
subimage(G_Unsharp_pad)
title('immagine con unsharp')
% COMMENTO:
% I filtri medi sono filtri passabasso adatti ad eliminare il rumore
% gaussiano. Aumentando la maschera (ad esempio come abbiamo fatto noi da 5
% a 15) l'effetto passabasso viene accentuato causando un effetto di
% offuscamento dell'immagine crescente all'aumentare delle
% dimensioni della maschera.
% Il passabasso maggiore del filtro con maschera 15 rispetto a
% quello con maschera 5 si può ben vedere nello spettro dei filtri.
% Il picco risulta infatti più stretto poichè il filtro va a zero prima.
% Il filtro gaussiano è anch'esso un filtro passabasso ma ha simmetria
% circolare, nel nostro caso non risulta ben visibile la simmetria
% circolare in quanto si è posta un'alta deviazione standard, pari a 2.
% Il filtro unsharp infine funge da filtro passa alto (lo spettro è
% infatti a campana rovesciata rispetto agli altri). Il suo funzionamento
% si basa sulla sottrazione all'immagine originale di una sua versione passabasso.


