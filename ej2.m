pkg load image

%% Ej 2-1
I = imread("I3T_200_WM_orig.png")
BW = im2bw(I, graythresh(I));
[L,NL]=	bwlabel(BW)
labels = unique(L)
maxBlob = []
maxSize = 0
for it=1:length(labels)
	region = find(L==it)
	innerSize = size(region)(1)
	if innerSize > maxSize
		maxSize = innerSize
		maxBlob = region
	endif
endfor

BWM1 = zeros(size(I))
BWM1(maxBlob) = BW(maxBlob)
BWM1 = im2bw(BWM1, graythresh(BWM1))
figure,imshow(BWM1)

%% Ej 2-2
BW3 = bwmorph(BWM1,'skel', Inf)
figure,imshow(BW3)

BW4 = bwmorph(BWM1,'remove')
figure,imshow(BW4)
figure,imshow(BW3)


input('Press any key to continue')

