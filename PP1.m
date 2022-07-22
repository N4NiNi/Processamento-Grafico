%Limpando a área
clear       % Fechar todas as janelas
close all   % Limpar a memória
clc         % Limpa a tela da área de trabalho
pkg load image
function bwafin = esqueleto(n)
  Inf=100;
  bwafin = bwmorph(n, 'thin',Inf);
  %figure, imshow(bwafin), title('Afinamento');
end

function assinatura(n)
  [B1,L1,N1] = bwboundaries(n);

  if mod(N1,2)==0
    subplotrow = ceil(sqrt(N1));
  else
    subplotrow = ceil(sqrt(N1)+1);
  end
  boundary1 = B1{10};
  [th, r]=cart2pol(boundary1(:,2)-mean(boundary1(:,2)), ...
  boundary1(:,1)-mean(boundary1(:,1)));
  figure;
  plot(th,r,'.');
  axis([-pi pi 0 100]);
  xlabel('radiano');ylabel('r');
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

%Excentricidade - 0
printf('Excentricidade\n');
for i=1:10  
  printf('N = %d ', i - 1);
  excentricidade(Num{i});
end


%Area - 1
printf('Area\n');
for i=1:10 
  printf('N = %d ', i - 1);
  area(~Num{i})
end


%esqueleto - 2
I = esqueleto(~N2);
figure, imshow(I);


%Compacidade - 3
printf('Compacidade\n')
for i=1:10
  printf('N = %d ', i-1);
  compacidade(Num{i});
end


%assinatura - 4
%assinatura(~esqueleto(~N4));
%assinatura - 5
assinatura(N5);


%Euler - 8
printf('Euler\n');
for i=1:10
  printf('N = %d  ', i - 1);
  euler(~Num{i});
end











comp
