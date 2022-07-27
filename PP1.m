%--- PP1
%--- Integrantes: Guilherme Fumagali - 792182
%---              Guilherme Silva    - 792183
%---              Rodrigo Amaral     - 792241
%---              Vinicius Nanini    - 795181

%Limpando a Area
clear       % Fechar todas as janelas
close all   % Limpar a mem�ria
clc         % Limpa a tela da �rea de trabalho
pkg load image
warning('off','all'); %desativar warnings

function Aprox_poligonal4(BW)
    s=size(BW);
    for row = 2:55:s(1)
        for col=1:s(2)
            if BW(row,col), break;
            end
        end
        
contour = bwboundaries (BW,4);
contour = cell2mat (contour);

        if(~isempty(contour))
            hold on; 
            plot(contour(:,2),contour(:,1),'g','LineWidth',4);
            hold on; 
            plot(col, row,'gx','LineWidth',2);
        else
            hold on; 
            plot(col, row,'rx','LineWidth',2);
        end
    end
end

function img = aprox(n)
  BW1 = ~im2bw(n);

  g1 = ones(size(BW1));
  g1(2:2:end,:,:) = 0;
  g1(:,2:2:end,:) = 0;

  figure('Name','Aproximacao Poligonal', 'NumberTitle', 'off'), imshow(BW1), title('Imagem com 4-conectados'); hold on;
  gimage = imshow(g1);
  set(gimage,'AlphaData', 0.8);
  Aprox_poligonal4(BW1);
end


function cadeia(n)
  I = n;

  Edges = edge(I, 'Sobel');

  figure('Name', 'Cadeia', 'NumberTitle', 'off'), imshow(~Edges), title("Cadeia"); hold on;

  b = bwboundaries(I);
  [boundarycount, asdf] = size(b);
  grid = 2;

  for k=1:boundarycount
      j=0;
      array = [];
      [rows, columns] = size(b{k,1});
      for i=1:rows-1
          y = round(b{k,1}(i,1)/grid);
          x = round(b{k,1}(i,2)/grid);
          y2 = round(b{k,1}(i+1,1)/grid);
          x2 = round(b{k,1}(i+1,2)/grid);

          dx = x2 - x;
          dy = y2 - y;
          if not(dx == 0 && dy==0)
              plot(x*grid, y*grid, 'Marker', '.', 'Color', [0 0 1], 'MarkerSize', 5);
              plot([x*grid,x2*grid],[y*grid,y2*grid],'Color','r','LineWidth',2);
              j = j+1;
              if (dx == 1 && dy ==0)
                 array(j) = 0;
              end
              if (dx == 1 && dy ==1)
                 array(j) = 1;
              end
              if (dx == 0 && dy ==1)
                 array(j) = 2;
              end
              if (dx == -1 && dy ==1)
                 array(j) = 3;
              end
              if (dx == -1 && dy ==0)
                 array(j) = 4;
              end
              if (dx == -1 && dy ==-1)
                 array(j) = 5;
              end
              if (dx == 0 && dy ==-1)
                 array(j) = 6; 
              end
              if (dx == 1 && dy ==-1)
                 array(j) = 7; 
              end
              text((x+0.5)*grid, (y+0.5)*grid,num2str(array(j)),'FontSize',9,'Color',[0 .5 0]);
          end
      end;
      for i = 1:j
      end;
  end;
  hold off
end


function bwafin = esqueleto(n)  
  Inf=100;
  bwafin = bwmorph(n, 'thin',Inf);
end

function assinatura(n)
  [B1,L1,N1] = bwboundaries(~n);
  figure('Name', 'Assinatura', 'NumberTitle', 'off');
  subplot(2,1,2), imshow(n), title('Assinatura');
  for cnt = 1:N1
      hold on;
          boundary1 = B1{cnt};
          plot(boundary1(:,2), boundary1(:,1),'r');
      hold on;
          text(mean(boundary1(:,2)), mean(boundary1(:,1)),num2str(cnt), 'Color', 'red');
  end
  subplot(2,1,1);
  if mod(N1,2)==0
      subplotrow = ceil(sqrt(N1));
  else
      subplotrow = ceil(sqrt(N1)+1);
  end
  
  for cnt = 1:N1
      boundary1 = B1{cnt};
      [th, r]=cart2pol(boundary1(:,2)-mean(boundary1(:,2)), ...
      boundary1(:,1)-mean(boundary1(:,1)));
      subplot(subplotrow,round(N1/subplotrow),cnt);
      
      plot(th,r,'.');
      axis([-pi pi 0 50]);
      xlabel('radiano');ylabel('r');
      title(['Grafico da assinatura ']);
  end
end


function compacidade(n)
  comp = regionprops(~n, 'Area', 'Perimeter');
  max(comp.Perimeter);
  max(comp.Area);
  per = (max(comp.Perimeter)*max(comp.Perimeter))/max(comp.Area)
end

function euler(n)
  bweuler(n)
end

function excentricidade(n) 
  rprops = regionprops(n, 'MajorAxisLength', 'MinorAxisLength');
  eixoMaior = rprops.MajorAxisLength;
  eixoMenor = rprops.MinorAxisLength;
  E = eixoMaior / eixoMenor
end

function area(n)
  rprops = regionprops(n, 'Area');
  max(rprops.Area)
end

%------------------------------------------------
%---------------------MAIN-----------------------
%------------------------------------------------

A = imread('numero.jpg');

%--- Separacao dos numeros
N1 = imcrop(A,[4,4,37,37]);
N2 = imcrop(A,[41,4,37,37]);
N3 = imcrop(A,[83,4,37,37]);
N4 = imcrop(A,[121,4,37,37]);
N5 = imcrop(A,[162,4,37,37]);
N6 = imcrop(A,[201,4,37,37]);
N7 = imcrop(A,[241,4,37,37]);
N8 = imcrop(A,[281,4,37,37]);
N9 = imcrop(A,[321,4,37,37]);
N0 = imcrop(A,[360,4,37,37]);
Num = {N0, N1, N2, N3, N4, N5, N6, N7, N8, N9}; %armazenando em um vetor
%---


%--- Visualizacao dos numeros
%figure, imshow(N1);
%figure, imshow(N2);
%figure, imshow(N3);
%figure, imshow(N4);
%figure, imshow(N5);
%figure, imshow(N6);
%figure, imshow(N7);
%figure, imshow(N8);
%figure, imshow(N9);
%figure, imshow(N0);
%---

figure('name', 'Numeros 1, 2, 3 e 4', 'Numbertitle', 'off');

%--- Excentricidade ->  0 (raz�o entre o eixo maior e o eixo menor = 1)
printf('Excentricidade\n');
for i=1:10  
  bin = im2bw(Num{i}, 0.5);
  printf('N = %d ', i - 1);
  excentricidade(bin);
end
subplot(2,2,1), imshow(N0), title('Excentricidade = 1');
%---


%--- Area -> 1 (Menor area de todos os numeros)
printf('Area\n');
for i=1:10 
   bin = im2bw(Num{i}, 0.5);
  printf('N = %d ', i - 1);
  area(~bin)
end
subplot(2,2,2), imshow(N1), title('Menor Area')
%---


%--- Esqueleto -> 2 (Melhor visualiza��o do n�mero)
bin = im2bw(N2, 0.5);
I = esqueleto(~bin);
subplot(2,2,3), imshow(I), title('Esqueleto');
%---


%--- Compacidade -> 3 (Maior compacidade de todos os numeros)
printf('Compacidade\n')
for i=1:10
  bin = im2bw(Num{i}, 0.5);
  printf('N = %d ', i-1);
  compacidade(bin);
end
subplot(2,2,4), imshow(N3), title('Maior compacidade')
%---


%--- Assinatura do esqueleto -> 4 (Assinatura unica para cada numero)
bin = im2bw(N4, 0.5);
assinatura(~esqueleto(~bin));
%---


%--- Assinatura -> 5 (Assinatura unica para cada numero)
bin = im2bw(N5, 0.5);
assinatura(bin);
%---


%--- Aproximacao poligonal do esqueleto -> 6 (Visualizacao unica)
bin = im2bw(N6, 0.5);
aprox(~esqueleto(~bin));
%---


%--- Cadeia -> 7 (Visualizacao unica)
cadeia(N7);
%---


%--- Euler -> 8 (Unico que resulta em -1)
printf('Euler\n');
for i=1:10
  bin = im2bw(Num{i}, 0.5);
  printf('N = %d  ', i - 1);
  euler(~bin);
end
figure, imshow(N8), title('Euler = -1');
%---


%--- Aproximacao poligonal -> 9 (Visualizacao unica)
aprox(N9);
%---