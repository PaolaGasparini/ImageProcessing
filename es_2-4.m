% H2_Gasparini Paola
% 7.10.0 (R2010a)

close all

% a) Scrivere  il  codice  che  consenta  all’utente  di  caricare  un’immagine in bianco e nero (ad esempio spalla) a  scelta  e  di  corromperla  con 
% rumore salt&pepper, di entità da specificarsi tramite inputdlg.  
dir=pwd;
[nome,percorso]=uigetfile('*.jpg','seleziona immagine');
cd(percorso);
im_originale=imread(nome);
imshow(im_originale)
title('immagine di partenza')
prompt={'Inserisci la densità in percentuale del rumore sale e pepe (da 0 a 1)'};
cd(dir);
densita=inputdlg(prompt);
densita=str2double(densita{1,1});       % convertita densità da stringa a numero
im_originale=im2double(im_originale);
im_sporca=imnoise(im_originale,'salt & pepper',densita); % sporcata l'immagine con rumore sale e pepe
imshow(im_sporca)
title('immagine sporcata con rumore sale e pepe')

% b) Implementare il filtro pseudomediano visto a lezione e applicarlo con L = 5, 15 e 25 all’immagine 
% corrotta  (effettuare  il  padding  opportuno).  Visualizzare  in  finestre  separate  l’immagine  originale, 
% quella corrotta e le tre immagini filtrate. 
uiwait(msgbox('consigliabile scegliere una porzione dell''immagine da pulire per velocizzare il calcolo'))
im_sporca2=imcrop(im_sporca);
N=2;    % come da consegna (es4 aggiornato) la maschera è stata posta uguale a 5=2*N+1.
im_sporca2=padarray(im_sporca2,[N N]);          % effettuato zero padding, in questo caso 
                                                % con due corone di pixels neri attorno all'immagine.
                                                
im_pulita=filtropseudomediano(im_sporca2,2);    % funzione da me implementata per pulir immagine
figure;
imshow(im_originale)
title('IMMAGINE ORIGINALE')
figure;
imshow(im_sporca2)
title('DETTAGLIO SELEZIONATO DI IMMAGINE SPORCATA')
figure;
imshow(im_pulita)
title('DETTAGLIO SELEZIONATO DI IMMAGINE PULITA')
  
        