pkg load image

function [binImg, gray, indexes] = filterFromRGB(image,R,G,B)
	RED = find(image(:,:,1)==R);
	GREEN = find(image(:,:,2)==G);
	BLUE = find(image(:,:,3)==B);
	INDEXES= intersect(intersect(RED,GREEN),BLUE);
	tmp = zeros(size(image));
	tmp(INDEXES) = image(INDEXES);

	indexes = INDEXES;
	gray = mat2gray(tmp);
	binImg = im2bw(gray,graythresh(gray));	
endfunction

function extremeDistances = calcExtremeDistances(bin1, bin2, min)
	boundariesbin1 = bwboundaries(bin1);
	boundariesbin2 = bwboundaries(bin2);

	size(boundariesbin1)
	size(boundariesbin2)
	
	extremeDistances=0;
endfunction



%% Ej 2-1
image1 = imread("I3T_200_WM_orig.png");
image1 = image1(:,:,1);

BW = im2bw(image1, graythresh(image1));

[L,NL]=	bwlabel(BW);
labels = unique(L);
maxBlob = [];
maxSize = 0;
for it=1:length(labels)
	region = find(L==it);
	innerSize = size(region)(1);
	if innerSize > maxSize
		maxSize = innerSize;
		maxBlob = region;
	endif
endfor

BWM1 = zeros(size(image1));
BWM1(maxBlob) = BW(maxBlob);
BWM1 = im2bw(BWM1, graythresh(BWM1));


%% Mostrando el blob mayor
figure,imshow(BWM1);
#{

%% Ej 2-2
%% Mostrando el esqueleto
BW3 = bwmorph(BWM1,'skel', Inf);
figure,imshow(BW3);

%% Mostrando contornos
BW4 = bwmorph(BWM1,'remove');
figure,imshow(BW4);
figure,imshow(BW4);


#}

%% Ej 2-3


image2 = imread("I3T_200_WMconObjetos.png");
image2 = image2(:,:,1:3);

%% Filtrando las areas coloreadas
[pinkbin, pinkgray, pinkdexes] = filterFromRGB(image2, 255,0,228);
[yellowbin, yellowgray, yellowxes]= filterFromRGB(image2, 255,255,0);
%% Mostrando areas coloreadas
figure,imshow(pinkbin)
figure,imshow(yellowbin)

%% Ej 2-4
%% Invirtiendo la imagen binaria original
CBW = imcomplement(BW);
%% Mostrando la invertida
figure,imshow(CBW);

%% Calculando sus blobs
[CBWL,CBWNL]=	bwlabel(CBW);
cbwlabels = unique(CBWL);

%% Determinando que blob coincide con el area de amarilla
yellowMarked = [];
for it=1:length(cbwlabels)
	region = find(CBWL==it);
	if !isempty(intersect(region, yellowxes))
		yellowMarked = region;
	endif
endfor

%% Crear y mostrar la imagen de la zona ventricular.
ventril = zeros(size(CBW));
ventril(yellowMarked) = CBW(yellowMarked);
figure,imshow(ventril);

%% Ej 2-5
[pinkLabels, pinkLabelsN] = bwlabel(pinkbin);
props = regionprops(pinkLabels,"Area","Perimeter", "Centroid", "BoundingBox", "MaxIntensity", "MeanIntensity", "MinIntensity")
printf("Mostrando Areas\n");
props.Area
printf("Mostrando Perimetros\n");
props.Perimeter
printf("Mostrando Centroides\n");
props.Centroid
printf("Mostrando BoundingBox\n");
props.BoundingBox
printf("Mostrando MaxIntensity\n");
props.MaxIntensity
printf("Mostrando MeanIntensity\n");
props.MeanIntensity
printf("Mostrando MinIntensity\n");
props.MinIntensity

%% Ej 2-6
dist = calcExtremeDistances(pinkbin, BWM1, true);






input('Press any key to continue')
