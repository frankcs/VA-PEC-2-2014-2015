pkg load image
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
BWM1(maxBlob) = I(maxBlob)

figure,imshow(BWM1)
figure,imshow(BWM1)

input('Press any key to continue')

