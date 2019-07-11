% H3_Gasparini Paola
% 7.10.0 (R2010a)
close all
clear all

frames=load('cmr_lv_sax.mat');

 for i=1:30
    
    I(:,:,i)=frames.cmr(:,:,i);
   
    
  %le immagini sono state messe in un cell array.   
    I=I(:,:,i);
    I=im2double(I);
    I=mat2gray(I);
    S = qtdecomp(I,70/255);
        blocks = repmat(uint8(0),size(S));
        for dim = [64 32 16 8 4 2];    %    for da dimensione minima a massima dei blocchi
          numblocks = length(find(S==dim));    
          if (numblocks > 0)        
            values = repmat(uint8(1),[dim dim numblocks]);
            values(2:dim,2:dim,:) = 0;
            blocks = qtsetblk(blocks,S,dim,values);  % split     
          end
        end
        blocks(end,1:end) =1;
        blocks(1:end,end) = 1;
        I(blocks==1)=0;
        if(i==1)
        figure;
        imshow(I,[])
        title('FRAME 1 DIVISO IN BLOCCHI ')
        uiwait(msgbox('Frame 1 con divisione in blocchi ( PAUSE inserita, premere invio dopo per sbloccare)'))
        pause;
                        A=zeros(size(I,1),size(I,2));
                        B=zeros(size(I,1),size(I,2));
                        S1=full(S);               %  dato che S è matrice sparsa                       
                        f=find(S1~=0);            % f è vettore di dimensioni dei blocchi                        
                        [x,y]=find(S~=0);         %x e y sono le posizioni di ogni inizio blocco                         
                        for k=1:length(f)
                        valore=S1(f(k));
                        A(x(k):x(k)-1+valore,y(k):y(k)-1+valore)=mean2(I((x(k)):(x(k)-1+valore),(y(k)):(y(k)-1+valore)));
                        B(x(k):x(k)-1+valore,y(k):y(k)-1+valore)=i;
                        end

                        % B=messo ad ogni blocco un numero (creata matrice
                        % puntatori)
                        % A=matrice di blocchi dove ogni blocco è la media
                        % dei pixels del blocco dell'immagine;
                        figure;
                        imshow(A,[])
                        title('FRAME 1, ogni blocco è media dei pixels ')
                        uiwait(msgbox('Frame 1 con divisione in blocchi ed ogni blocco media dei valori immagine (PAUSE inserita, premere invio per sbloccare)'))
                        pause;
        end
    
    T(:,:,i)=I;
    J(:,:,i)=mat2gray(T(:,:,i)); 
    [C(:,:,i),map]=gray2ind(J(:,:,i));
    ce{i}=C(:,:,i);
 end
 sol=cat(4,ce{:});

 %  si visualizzando i frame della sequenza
 figure;
 montage(sol,map);
 title('30 FRAMES')
 uiwait(msgbox('I 30 frames divisi in blocchi (split), successivamente verrà mostrato il video con i frames in sequenza'))
%  qui bisognava anche fare diventare il blocco del ventricolo di colore
%  rosso e creare il video che mostrasse come esso si muoveva, bisognava
%  lavorare sul concetto split and merge
 close;
 figure;
 mov=immovie(sol,map);

% filmato visualizzato tre volte
 movie(mov,3,30);
 
 

