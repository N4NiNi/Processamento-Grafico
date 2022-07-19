%Limpando a área
clear       % Fechar todas as janelas
close all   % Limpar a memória
clc         % Limpa a tela da área de trabalho
pkg load image

A = imread('numero.jpg');
figure, imshow(A);

A_bin = im2bw(A, 0.55);
figure, imshow(A_bin);