close all
clear all
% H4_Gasparini Paola
% 7.10.0 (R2010a)

% studiata PCA, più componenti si visualizzano più nel dettaglio è il
% movimento del nostro endocardio (usare poche componenti vuol dire che il
% nostro endocardio è rappresentato grossolanamente).
% A fine esercizio si calcola il valore del volume dell'endocardio
% utilizzando la formula del tetraedro, ossia il volume viene visto come
% somma di tanti tetraedri aventi come vertice il baricentro del volume da
% calcolare. 
load LV
figure;

% 1)
            axis equal
            set(gcf,'Color','w')                % impostato lo sfondo bianco
            axis off
            light
            endocardio=patch('Faces',endo_face,'Vertices',endo_vertices(:,:,1)');  %endocardio originale
            set(endocardio,'FaceColor','b')     % impostate le facce blu all'endocardio originale
            set(endocardio,'EdgeColor','none')  % impostate nessun contorno alle facce blu 

                for i=1:26
                    set(endocardio,'Vertices',endo_vertices(:,:,i)'); 
                 %   visualizzazione dell’evoluzione temporale della superficie endocardica
                    pause(.2)
                    title('ANDAMENTO DELL''ENDOCARDIO ORIGINALE')
                end
                
% 2) applicazione della PCA alle coordinate dei nodi:

            x=zeros(3*758,26);
                for i=1:26
                    f=endo_vertices(:,:,i);
                    x(:,i)=f(:);
                %  ogni colonna di x sono tutti i nodi di ognuna delle 26 matrici di
                %  endo_vertices.
                end

            mx=repmat(mean(x),[size(x,1) 1]);   % media 
            sx=repmat(std(x),[size(x,1) 1]);    % std
            x2=(x-mx)./sx;                      % standardizzazione
              endo_vertices=zeros(3,758,26);
                for i=1:26
                endo_vertices(:,:,i)=reshape(x2(:,i),[3 758]);
                % ricreo le 26 matrici dell'endocardio originale dopo la standardizzazione
                end

            [coeff,score,latent,t2] = princomp(x2); % analisi delle componenti principali di tutti i vertici

% 3a) ricostruisco endocardio usando UNA,DUE E CINQUE componenti

            i1c=score(:,1)*coeff(:,1)';   % ricostruisco con UNA componente
            i2c=score(:,1:2)*coeff(:,1:2)'; % ricostruisco con DUE componenti
            i5c=score(:,1:5)*coeff(:,1:5)'; % ricostruisco con CINQUE componenti

            endo_vertices_1componente=zeros(3,758,26);
            endo_vertices_2componenti=zeros(3,758,26);
            endo_vertices_5componenti=zeros(3,758,26);

            
            
                for i=1:26
                endo_vertices_1componente(:,:,i)=reshape(i1c(:,i),[3 758]);
                endo_vertices_2componenti(:,:,i)=reshape(i2c(:,i),[3 758]);
                endo_vertices_5componenti(:,:,i)=reshape(i5c(:,i),[3 758]);
                % ricreo le 26 matrici per ogni endocardio ricostruito 
                end

            endo_vertices_1componente=single(endo_vertices_1componente);
            endo_vertices_2componenti=single(endo_vertices_2componenti);
            endo_vertices_5componenti=single(endo_vertices_5componenti);

            figure;
            % figura  FRAME TELEDIASTOLICO (FRAME 1) con 1 componente per l'endocardio
            % ricostruito oltre ad endocardio originale
            axis equal
            set(gcf,'Color','w')
            axis off
            light
            endocardio=patch('Faces',endo_face,'Vertices',endo_vertices(:,:,1)');
            endocardio_1componente=patch('Faces',endo_face,'Vertices',endo_vertices_1componente(:,:,1)');
            set(endocardio,'FaceColor','b')     % impostate facce blu per l'endocardio originale
            set(endocardio,'EdgeColor','none')
            set(endocardio,'FaceAlpha',.4)      % impostate trasparenza delle facce blu
            set(endocardio_1componente,'FaceColor','r')  % impostate facce rosse per l'endocardio ricostruito
            set(endocardio_1componente,'EdgeColor','none')
            set(endocardio,'Vertices',endo_vertices(:,:,1)');
            set(endocardio_1componente,'Vertices',endo_vertices_1componente(:,:,1)');
            title('FRAME TELEDIASTOLICO componente 1 di PCA')
            legend('endocardio originale','una componente')
            pause(0.5);

            figure;
            % figura  FRAME TELEDIASTOLICO (FRAME 1) con 2 componenti per l'endocardio ricostruito
            %  oltre ad endocardio originale
            axis equal
            set(gcf,'Color','w')
            axis off
            light
            endocardio=patch('Faces',endo_face,'Vertices',endo_vertices(:,:,1)');
            endocardio_2componenti=patch('Faces',endo_face,'Vertices',endo_vertices_2componenti(:,:,1)');
            set(endocardio,'FaceColor','b')     % impostate facce rosse per l'endocardio originale
            set(endocardio,'EdgeColor','none')
            set(endocardio,'FaceAlpha',.4)      % impostate trasparenza delle facce rosse
            set(endocardio_2componenti,'FaceColor','r')  % impostate facce rosse per l'endocardio ricostruito
            set(endocardio_2componenti,'EdgeColor','none')
            set(endocardio,'Vertices',endo_vertices(:,:,1)');
            set(endocardio_2componenti,'Vertices',endo_vertices_2componenti(:,:,1)');
            title('FRAME TELEDIASTOLICO due componenti di PCA')
            legend('endocardio originale','due componenti')
            pause(0.5);

            figure;
            % figura  FRAME TELEDIASTOLICO (FRAME 1) con 5 componenti per l'endocardio
            % ricostruito oltre ad endocardio originale
            axis equal
            set(gcf,'Color','w')
            axis off
            light
            endocardio=patch('Faces',endo_face,'Vertices',endo_vertices(:,:,1)');
            endocardio_5componenti=patch('Faces',endo_face,'Vertices',endo_vertices_5componenti(:,:,1)');
            set(endocardio,'FaceColor','b')     % impostate facce rosse per l'endocardio originale
            set(endocardio,'EdgeColor','none')
            set(endocardio,'FaceAlpha',.4)      % impostate trasparenza delle facce rosse
            set(endocardio_5componenti,'FaceColor','r')  % impostate facce rosse per l'endocardio ricostruito
            set(endocardio_5componenti,'EdgeColor','none')
            set(endocardio,'Vertices',endo_vertices(:,:,1)');
            set(endocardio_5componenti,'Vertices',endo_vertices_5componenti(:,:,1)');
            title('FRAME TELEDIASTOLICO cinque componenti di PCA')
            legend('endocardio originale','cinque componenti')
            pause(0.5);

            figure;
            % figura  FRAME TELESISTOLICO (FRAME 11) con 1 componente per l'endocardio
            % ricostruito oltre ad endocardio originale
            axis equal
            set(gcf,'Color','w')
            axis off
            light
            endocardio=patch('Faces',endo_face,'Vertices',endo_vertices(:,:,11)');
            endocardio_1componente=patch('Faces',endo_face,'Vertices',endo_vertices_1componente(:,:,11)');
            set(endocardio,'FaceColor','b')     % impostate facce rosse per l'endocardio originale
            set(endocardio,'EdgeColor','none')
            set(endocardio,'FaceAlpha',.4)      % impostate trasparenza delle facce rosse
            set(endocardio_1componente,'FaceColor','r')  % impostate facce rosse per l'endocardio ricostruito
            set(endocardio_1componente,'EdgeColor','none')
            set(endocardio,'Vertices',endo_vertices(:,:,11)');
            set(endocardio_1componente,'Vertices',endo_vertices_1componente(:,:,11)');
            title('FRAME TELESISTOLICO una componente di PCA')
            legend('endocardio originale','una componente')
            pause(0.5);

            figure;
            % figura  FRAME TELESISTOLICO (FRAME 11) con 2 componenti per l'endocardio
            % ricostruito oltre ad endocardio originale
            axis equal
            set(gcf,'Color','w')
            axis off
            light
            endocardio=patch('Faces',endo_face,'Vertices',endo_vertices(:,:,11)');
            endocardio_2componenti=patch('Faces',endo_face,'Vertices',endo_vertices_2componenti(:,:,11)');
            set(endocardio,'FaceColor','b')     % impostate facce rosse per l'endocardio originale
            set(endocardio,'EdgeColor','none')
            set(endocardio,'FaceAlpha',.4)      % impostate trasparenza delle facce rosse
            set(endocardio_2componenti,'FaceColor','r')  % impostate facce rosse per l'endocardio ricostruito
            set(endocardio_2componenti,'EdgeColor','none')
            set(endocardio,'Vertices',endo_vertices(:,:,11)');
            set(endocardio_2componenti,'Vertices',endo_vertices_2componenti(:,:,11)');
            title('FRAME TELESISTOLICO due componenti di PCA')
            legend('endocardio originale','due componenti')
            pause(0.5);

            figure;
            % figura  FRAME TELESISTOLICO (FRAME 11) con 5 componenti per l'endocardio
            % ricostruito oltre ad endocardio originale
            axis equal
            set(gcf,'Color','w')
            axis off
            light
            endocardio=patch('Faces',endo_face,'Vertices',endo_vertices(:,:,11)');
            endocardio_5componenti=patch('Faces',endo_face,'Vertices',endo_vertices_5componenti(:,:,11)');
            set(endocardio,'FaceColor','b')     % impostate facce rosse per l'endocardio originale
            set(endocardio,'EdgeColor','none')
            set(endocardio,'FaceAlpha',.4)      % impostate trasparenza delle facce rosse
            set(endocardio_5componenti,'FaceColor','r')  % impostate facce rosse per l'endocardio ricostruito
            set(endocardio_5componenti,'EdgeColor','none')
            set(endocardio,'Vertices',endo_vertices(:,:,11)');
            set(endocardio_5componenti,'Vertices',endo_vertices_5componenti(:,:,11)');
            title('FRAME TELESISTOLICO cinque componenti di PCA')
            legend('endocardio originale','cinque componenti')
            pause(0.5);

% 5) per ogni valore di n, calcolare e plottare in una stessa figura, l’andamento del volume della
% mesh originale e di quella ricostruita, e in un’altra figura la differenza tra i volumi;

                endo_vertices=zeros(3,758,26);
                for i=1:26
                endo_vertices(:,:,i)=reshape(x(:,i),[3 758]);
                % ricreo le 26 matrici dell'endocardio originale togliendo la standardizzazione
                end
                i1c=(i1c.*sx)+mx; %tolgo le standardizzazioni   
                i2c=(i2c.*sx)+mx; 
                i5c=(i5c.*sx)+mx; 
                        
                for i=1:26
                endo_vertices_1componente(:,:,i)=reshape(i1c(:,i),[3 758]);
                endo_vertices_2componenti(:,:,i)=reshape(i2c(:,i),[3 758]);
                endo_vertices_5componenti(:,:,i)=reshape(i5c(:,i),[3 758]);
                % ricreo le 26 matrici degli endocardi ricostruiti senza standardizzazione
                end
                
            endo_vertices=endo_vertices*100;    %  trasformazioni delle coordinate da m a cm
            endo_vertices_1componente=endo_vertices_1componente*100;
            endo_vertices_2componenti=endo_vertices_2componenti*100;
            endo_vertices_5componenti=endo_vertices_5componenti*100;
            
            volume_Tot=zeros(26,1);
            volume_Tot_1c=zeros(26,1);
            volume_Tot_2c=zeros(26,1);
            volume_Tot_5c=zeros(26,1);
            for j=1:26
           
            xbaricentro=mean(endo_vertices(1,:,j));  %  baricentro endocardio originale
            ybaricentro=mean(endo_vertices(2,:,j));
            zbaricentro=mean(endo_vertices(3,:,j));
            
             xbaricentro_1c=mean(endo_vertices_1componente(1,:,j)); %  baricentro endocardio ricostruito 1 componente
             ybaricentro_1c=mean(endo_vertices_1componente(2,:,j));
             zbaricentro_1c=mean(endo_vertices_1componente(3,:,j));
             
             xbaricentro_2c=mean(endo_vertices_2componenti(1,:,j)); %  baricentro endocardio ricostruito 2 componenti
             ybaricentro_2c=mean(endo_vertices_2componenti(2,:,j));
             zbaricentro_2c=mean(endo_vertices_2componenti(3,:,j));
            
             xbaricentro_5c=mean(endo_vertices_5componenti(1,:,j)); %  baricentro endocardio ricostruito 5 componenti            
             ybaricentro_5c=mean(endo_vertices_5componenti(2,:,j));
             zbaricentro_5c=mean(endo_vertices_5componenti(3,:,j));
             nface=1280;
             volume=zeros(nface,1);
             volume_1c=zeros(nface,1);
             volume_2c=zeros(nface,1);
             volume_5c=zeros(nface,1);
                    for i=1:nface

                    P1xyz=endo_vertices(:,endo_face(i,1),j); % P1,P2,P3 sono i tre vertici di ogni faccia
                    P2xyz=endo_vertices(:,endo_face(i,2),j); 
                    P3xyz=endo_vertices(:,endo_face(i,3),j); 

                    P1xyz_1c=endo_vertices_1componente(:,endo_face(i,1),j); % P1,P2,P3 di ogni faccia di endocardio_1componente
                    P2xyz_1c=endo_vertices_1componente(:,endo_face(i,2),j); 
                    P3xyz_1c=endo_vertices_1componente(:,endo_face(i,3),j); 

                    P1xyz_2c=endo_vertices_2componenti(:,endo_face(i,1),j); 
                    P2xyz_2c=endo_vertices_2componenti(:,endo_face(i,2),j); 
                    P3xyz_2c=endo_vertices_2componenti(:,endo_face(i,3),j); 

                    P1xyz_5c=endo_vertices_5componenti(:,endo_face(i,1),j); 
                    P2xyz_5c=endo_vertices_5componenti(:,endo_face(i,2),j); 
                    P3xyz_5c=endo_vertices_5componenti(:,endo_face(i,3),j);

                    x1=P1xyz(1,1);     % ascissa di P1            
                    y1=P1xyz(2,1);     % ordinata di P1 
                    z1=P1xyz(3,1);     % zeta di P1      
                    x1_1c=P1xyz_1c(1,1);              
                    y1_1c=P1xyz_1c(2,1);    
                    z1_1c=P1xyz_1c(3,1);     
                    x1_2c=P1xyz_2c(1,1);            
                    y1_2c=P1xyz_2c(2,1);    
                    z1_2c=P1xyz_2c(3,1);   
                    x1_5c=P1xyz_5c(1,1);                
                    y1_5c=P1xyz_5c(2,1);    
                    z1_5c=P1xyz_5c(3,1);     

                    x2=P2xyz(1,1);      % ascissa di P2  
                    y2=P2xyz(2,1);      % ordinata di P2 
                    z2=P2xyz(3,1);      % zeta di P2 
                    x2_1c=P2xyz_1c(1,1);
                    y2_1c=P2xyz_1c(2,1);
                    z2_1c=P2xyz_1c(3,1);
                    x2_2c=P2xyz_2c(1,1);
                    y2_2c=P2xyz_2c(2,1);
                    z2_2c=P2xyz_2c(3,1);
                    x2_5c=P2xyz_5c(1,1);
                    y2_5c=P2xyz_5c(2,1);
                    z2_5c=P2xyz_5c(3,1);

                    x3=P3xyz(1,1);         % ascissa di P3 
                    y3=P3xyz(2,1);         % ordinata di P3 
                    z3=P3xyz(3,1);         % zeta di P3 
                    x3_1c=P3xyz_1c(1,1);
                    y3_1c=P3xyz_1c(2,1);
                    z3_1c=P3xyz_1c(3,1);
                    x3_2c=P3xyz_2c(1,1);
                    y3_2c=P3xyz_2c(2,1);
                    z3_2c=P3xyz_2c(3,1);
                    x3_5c=P3xyz_5c(1,1);
                    y3_5c=P3xyz_5c(2,1);
                    z3_5c=P3xyz_5c(3,1);

                    x4=xbaricentro;
                    y4=ybaricentro;
                    z4=zbaricentro;
                    x4_1c=xbaricentro_1c;
                    y4_1c=ybaricentro_1c;
                    z4_1c=zbaricentro_1c;
                    x4_2c=xbaricentro_2c;
                    y4_2c=ybaricentro_2c;
                    z4_2c=zbaricentro_2c;
                    x4_5c=xbaricentro_5c;
                    y4_5c=ybaricentro_5c;
                    z4_5c=zbaricentro_5c;

                    matrice=[x1 y1 z1 1;x2 y2 z2 1;x3 y3 z3 1;x4 y4 z4 1];
                    matrice_1c=[x1_1c y1_1c z1_1c 1;x2_1c y2_1c z2_1c 1;x3_1c y3_1c z3_1c 1;x4_1c y4_1c z4_1c 1];
                    matrice_2c=[x1_2c y1_2c z1_2c 1;x2_2c y2_2c z2_2c 1;x3_2c y3_2c z3_2c 1;x4_2c y4_2c z4_2c 1];
                    matrice_5c=[x1_5c y1_5c z1_5c 1;x2_5c y2_5c z2_5c 1;x3_5c y3_5c z3_5c 1;x4_5c y4_5c z4_5c 1];
                    
                    volume(i,1)=det(matrice)./(3*2*1);
                    volume_1c(i,1)=det(matrice_1c)./(3*2*1);
                    volume_2c(i,1)=det(matrice_2c)./(3*2*1);
                    volume_5c(i,1)=det(matrice_5c)./(3*2*1);
                    end
            volume_Tot(j,1)=sum(volume);
            volume_Tot_1c(j,1)=sum(volume_1c);
            volume_Tot_2c(j,1)=sum(volume_2c);
            volume_Tot_5c(j,1)=sum(volume_5c);
            
            end
            figure;
           
            plot(1:26,volume_Tot,'bo-')
            title('ANDAMENTO VOLUME NEI FRAMES')
            xlabel('frames');
            ylabel('valori volume [ml]')
            hold on
            plot(1:26,volume_Tot_1c,'r*-')
            plot(1:26,volume_Tot_2c,'c*-')
            plot(1:26,volume_Tot_5c,'k*-')
            legend('endocardio originale','endocardio una comp.','endocardio due comp.','endocardio cinque comp.')
            axis tight

