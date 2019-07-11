% H3_Gasparini Paola
% 7.10.0 (R2010a)

clear all
close all
im=imread('PET_image.tif');

figure;
im=im2double(im);
imshow(im)
title('IMMAGINE ORIGINALE')

[M,N]=size(im);    
u0=M/2; 
v0=N/2;                                 % le coordinate della continua 
                                        % nello spettro (u0 e v0) dopo aver
                                        % effettuato fftshift corrispondono
                                        % al centro dell'immagine. 
D0=min(M,N)./8;
D=zeros(M,N);

for u=1:M
    for v=1:N
        D(u,v)=sqrt(((u-u0).^2+(v-v0).^2));   % distanza euclidea        
        H(u,v)=0.25+(2./(1+(D0./(D(u,v))).^2));
    end
end

log_im=log(im+1);    
                                    % ho effettuato il logaritmo dell'immagine
                                    % ho aggiunto 1 per
                                    %risolvere il problema di avere ln0. 

TF_log_im=fft2(log_im);             % TF del logaritmo dell'immagine
figure;
mesh(H);
colormap;
title('FILTRO H')
h = fftshift(H);  
Y=TF_log_im.*h;                     % filtraggio

Y_exp=exp(real(ifft2(Y)));          % esponenziale della IFFT2(Y)
figure;
imshow(Y_exp,[])
title('IMMAGINE FILTRATA')