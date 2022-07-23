%Limpando a área
clear       % Fechar todas as janelas
close all   % Limpar a memória
clc         % Limpa a tela da área de trabalho
pkg load image
warning('off','all');
function cadeia(n)
  
  I = n;
  %I = im2bw(I);
  figure, imshow(I);
  %I = ~I;

  Edges = edge(I, 'Sobel');


  figure, imshow(~Edges);
  hold on

  b = bwboundaries(I);
  [boundarycount, asdf] = size(b);
  grid = 2;

  for k=1:boundarycount
      j=0;
      array = [];
      [rows, columns] = size(b{k,1});
      %fprintf('Origem linha %d(x,y): %d %d\n', k, b{k,1}(1,2), b{k,1}(1,1));
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
      %fprintf('C�digo linha %d: ', k);
      for i = 1:j
       %   fprintf('%d', array(i));
      end;
      %fprintf('\n');
  end;
  hold off
end


function bwafin = esqueleto(n)
  Inf=100;
  bwafin = bwmorph(n, 'thin',Inf);
  %figure, imshow(bwafin), title('Afinamento');
end

function assinatura(n)
  [B1,L1,N1] = bwboundaries(~n);
  figure, imshow(n);
  for cnt = 1:N1
      hold on;
          boundary1 = B1{cnt};
          plot(boundary1(:,2), boundary1(:,1),'r');
      hold on;
          text(mean(boundary1(:,2)), mean(boundary1(:,1)),num2str(cnt), 'Color', 'red');
  end

  %plota a funÃ§Ã£o assinatura
  figure;
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
      %subplot(subplotrow,round(N1/subplotrow),cnt);
      
      plot(th,r,'.');
      axis([-pi pi 0 50]);
      xlabel('radiano');ylabel('r');
      title(['Objeto ', num2str(cnt)]);
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

A = imread('numero.jpg');
X = isgray(A);
%figure, imshow(A);

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

Num = {N0, N1, N2, N3, N4, N5, N6, N7, N8, N9};

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

%Excentricidade - 0
printf('Excentricidade\n');
for i=1:10  
  bin = im2bw(Num{i}, 0.5);
  printf('N = %d ', i - 1);
  excentricidade(bin);
end


%Area - 1
printf('Area\n');
for i=1:10 
   bin = im2bw(Num{i}, 0.5);
  printf('N = %d ', i - 1);
  area(~bin)
end


%esqueleto - 2
 bin = im2bw(N2, 0.5);
I = esqueleto(~bin);
figure, imshow(I);


%Compacidade - 3
printf('Compacidade\n')
for i=1:10
   bin = im2bw(Num{i}, 0.5);
  printf('N = %d ', i-1);
  compacidade(bin);
end


%assinatura do esqueleto - 4
 bin = im2bw(N4, 0.5);
assinatura(~esqueleto(~bin));
%assinatura - 5
 bin = im2bw(N5, 0.5);
assinatura(bin);


%Euler - 8
printf('Euler\n');
for i=1:10
   bin = im2bw(Num{i}, 0.5);
  printf('N = %d  ', i - 1);
  euler(~bin);
end

%cadeia - 7
cadeia(N7);

%cadeia do esqueleto
bin = im2bw(N9, 0.5);
I = convhull(bin);

figure, imshow(I);



