% H4_Gasparini Paola
% 7.10.0 (R2010a)

close all
clear all
immagine=imread('circles.png');
figure;
imshow(immagine);
title('IMMAGINE ORIGINALE')
pause(0.7)
scheletro=bwmorph(immagine,'skel',Inf);
figure;
imshow(scheletro);
title('SCHELETRO DELL''IMMAGINE ORIGINALE')
pause(0.7)
figure;
for i=1:25
pruning_ = bwmorph(scheletro,'spur',i);
imshow(pruning_);
 title('PRUNING FATTO DA MATLAB (attendi, non premere niente)')
pause(0.7)
end

figure;
it=0;
alt=0;
 while (it<100 && alt<1)
  
  [x,y]=find(scheletro==1); 
  scheletro_past=scheletro;

        for i=1:length(x)
%             connettività 8
            N=scheletro(x(i)-1,y(i));
            S=scheletro(x(i)+1,y(i));
            O=scheletro(x(i),y(i)-1);
            E=scheletro(x(i),y(i)+1);
            NO=scheletro(x(i)-1,y(i)-1);
            NE=scheletro(x(i)-1,y(i)+1);
            SO=scheletro(x(i)+1,y(i)-1);
            SE=scheletro(x(i)+1,y(i)+1);
                if sum([N S E O NO NE SE SO])==1
                scheletro(x(i),y(i))=0;
                end  
        end 
       
       if scheletro_past==scheletro
           alt=1;   
       end
       it=it+1;
       imshow(scheletro);
       title('PRUNING CREATO DA ME')
       pause(0.7)
 end
