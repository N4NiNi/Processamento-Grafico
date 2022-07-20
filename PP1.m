%Limpando a área
clear       % Fechar todas as janelas
close all   % Limpar a memória
clc         % Limpa a tela da área de trabalho
pkg load image

A = imread('numero.jpg');
figure, imshow(A);
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



%figure, imshow(N1);
%figure, imshow(N2);
%figure, imshow(N3);
%figure, imshow(N4);
%figure, imshow(N5);
%figure, imshow(N6);
%figure, imshow(N7);
figure, imshow(N8);
%figure, imshow(N9);
%figure, imshow(N0);
C = bweuler(~N8);
figure, imshow(N8);
