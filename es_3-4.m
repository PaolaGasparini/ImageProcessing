% H3_Gasparini Paola
% 7.10.0 (R2010a)

clear all
close all
A = imread('Fig1008(a).tif');
figure;
imshow(A)
title('IMMAGINE ORIGINALE')

% Maschere di Robinson:
h_N_1 = [-1 0 1;                        %     orientazione nord
         -2 0 2;
         -1 0 1];
   
h_NO_2 = [0 1 2;                        %     orientazione nord-ovest
         -1 0 1;
        -2 -1 0];
   
h_O_3 = [1 2 1;                         %     orientazione ovest
         0 0 0;
       -1 -2 -1];
   
h_SO_4 = [2 1 0;                        %     orientazione sud-ovest
          1 0 -1;
          0 -1 -2];
   
h_S_5= [1 0 -1;                         %     orientazione sud
        2 0 -2;
        1 0 -1];
   
h_SE_6 = [0 -1 -2;                      %     orientazione sud-est
          1 0 -1;
          2 1 0];
    
h_E_7 = [-1 -2 -1;                      %     orientazione est
          0 0 0;
          1 2 1];
    
h_NE_8 = [-2 -1 0;                      %     orientazione nord-est
           -1 0 1;
            0 1 2];
        
% convoluzione di ogni maschera con l'immagine.

A_N_1 = imfilter(A, h_N_1,'conv', 'same');
A_NO_2 = imfilter(A, h_NO_2, 'conv', 'same');
A_O_3 = imfilter(A, h_O_3, 'conv', 'same');
A_SO_4 = imfilter(A, h_SO_4, 'conv', 'same');
A_S_5 = imfilter(A, h_S_5, 'conv', 'same');
A_SE_6 = imfilter(A, h_SE_6, 'conv', 'same');
A_E_7 = imfilter(A, h_E_7,'conv', 'same');
A_NE_8 = imfilter(A, h_NE_8, 'conv', 'same');


Massimo=zeros(size(A,1),size(A,2));     % matrice edge magnitude
Direzione=zeros(size(A,1),size(A,2));   % matrice edge direction

for i=1:size(A,1)
    for j=1:size(A,2)
        array_magnitude=[ A_SE_6(i,j) A_O_3(i,j) A_NO_2(i,j) A_SO_4(i,j) A_N_1(i,j) A_S_5(i,j) A_E_7(i,j) A_NE_8(i,j)];
        Massimo(i,j)=max(array_magnitude);   %  scelta magnitudine massima       
        [~,y]=find(array_magnitude==max(array_magnitude));     %  y è la posizione della magnitudine massima
        Direzione(i,j)=y(2);                    % direzione in cui si ha la massima magnitudine, 
                                                %nel caso di valori uguali dati da maschere diverse viene scelta la prima        
    end
end

figure;

imshow(Massimo); 
title('EDGE MAGNITUDE');

colormap_direzioni=[1 0 0;0 0 0; 0 1 0;0 0 1; 0 1 1; 1 1 0; 1 0 1;1 1 1]; 
% creata colormap delle direzioni.
figure;
imshow(Direzione,colormap_direzioni); 
title('EDGE ORIENTATION');