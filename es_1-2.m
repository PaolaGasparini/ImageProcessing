% H1_Gasparini Paola
% 7.10.0 (R2010a)

% a) 
% si seleziona la directory contenente le immagini DICOM (si deve
% selezionare la cartella MRI_LAX!!)
close all
clear all
directoryname=uigetdir;
cd(directoryname);
% si caricano tutti i frames operando sulle stringhe 
 for i=1:55
     num=num2str(i);
     val='000';
     if i>9 
     val(2:3)=num; 
     else
     val(3)=num;
     end     
     nome=strrep('radiale-010-xxx-.dcm','xxx',val);   
     
     M(:,:,i)=dicomread(nome);  
     
    C1(:,:,i)=mat2gray(M(:,:,i)); 
     
    [C(:,:,i),map]=gray2ind(C1(:,:,i));
    ce{i}=C(:,:,i); 
  %le immagini convertite in scala di grigio a 256 livelli sono state messe in un cell array.   
 
 end
 sol=cat(4,ce{:});
 % b)
 %  si visualizzando i frame della sequenza
 montage(sol,map);
 title('55 FRAMES')
 uiwait(msgbox('in questa figura sono presentati tutti i 55 frames, successivamente verrà mostrato il video con i frames in sequenza'))
 close;
 mov=immovie(sol,map);
% c)
% filmato visualizzato tre volte e poi salvato con le specifiche richieste.
 movie(mov,3,30);
%  movie2avi(mov,'mri_lax.avi','fps',30,'compression','Cinepak','quality',75)

 
 
 


   