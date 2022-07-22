%Limpando a área
clear       % Fechar todas as janelas
close all   % Limpar a memória
clc         % Limpa a tela da área de trabalho
pkg load image
function cadeia(n)
%I = imread('Cosmo.bmp');
  I = uint8(255 * n);
%I = im2bw(I);
figure, imshow(I);
%I = ~I;

Edges = edge(I);


figure, imshow(~Edges);
hold on

b = bwboundaries(I);
[boundarycount, asdf] = size(b);
grid = 10;

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
%figure, imshow(A);
A_bin = A;
N1 = imcrop(A_bin,[4,4,37,37]);
N2 = imcrop(A_bin,[41,4,37,37]);
N3 = imcrop(A_bin,[83,4,37,37]);
N4 = imcrop(A_bin,[121,4,37,37]);
N5 = imcrop(A_bin,[162,4,37,37]);
N6 = imcrop(A_bin,[201,4,37,37]);
N7 = imcrop(A_bin,[241,4,37,37]);
N8 = imcrop(A_bin,[281,4,37,37]);
N9 = imcrop(A_bin,[321,4,37,37]);
N0 = imcrop(A_bin,[360,4,37,37]);

%cadeia
cadeia(N0);

