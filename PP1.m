%Limpando a área
clear       % Fechar todas as janelas
close all   % Limpar a memória
clc         % Limpa a tela da área de trabalho
pkg load image

function euler(n)
  bweuler(n)
end

function excentricidade(n)
  rprops = regionprops(n, 'MajorAxisLength', 'MinorAxisLength');
  eixoMaior = rprops.MajorAxisLength;
  eixoMenor = rprops.MinorAxisLength;
  E = eixoMaior / eixoMenor
end

A = imread('numero.jpg');
%figure, imshow(A);
A_bin = im2bw(A, 0.5);
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

%Euler - 8
printf('Euler\n');
for i=1:9
  printf('N = %d  ', i);
  euler(~Num{i});
end

%Excentricidade - 0
printf('Excentricidade\n')
for i=1:9
  printf('N = %d ', i);
  excentricidade(~Num{i});
end

%Compacidade - 1

comp = regionprops(~N1, 'Area', 'Perimeter');
max(comp.Perimeter)
max(comp.Area)
per = (max(comp.Perimeter)*max(comp.Perimeter))/max(comp.Area)

%Area - 7
x7 = regionprops(~N7, 'Area');
sete = max(x7.Area)


