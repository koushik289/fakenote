
close all;
Ireal = imread('http://i.stack.imgur.com/SqbnIm.jpg'); % Real
Ifake = imread('http://i.stack.imgur.com/2U3DEm.jpg'); % Fake
Ifake2 = imread('http://i.imgur.com/SVJrwaV.jpg'); % Fake #2
% //Resize so that we have the same dimensions as the other images
Ifake2 = imresize(Ifake2, [160 320], 'bilinear');

%% //Extract the black strips for each image
blackStripReal = Ireal(:,195:215,:);
blackStripFake = Ifake(:,195:215,:);
blackStripFake2 = Ifake2(:,195:215,:);

figure(1);
subplot(1,3,1);
imshow(blackStripReal);
title('Real');
subplot(1,3,2);
imshow(blackStripFake);
title('Fake');
subplot(1,3,3);
imshow(blackStripFake2);
title('Fake #2');

%% //Convert into grayscale then threshold
blackStripReal = rgb2gray(blackStripReal);
blackStripFake = rgb2gray(blackStripFake);
blackStripFake2 = rgb2gray(blackStripFake2);

figure(2);
subplot(1,3,1);
imshow(blackStripReal);
title('Real');
subplot(1,3,2);
imshow(blackStripFake);
title('Fake');
subplot(1,3,3);
imshow(blackStripFake2);
title('Fake #2');

%% //Threshold using about intensity 30
blackStripRealBW = ~im2bw(blackStripReal, 30/255);
blackStripFakeBW = ~im2bw(blackStripFake, 30/255);
blackStripFake2BW = ~im2bw(blackStripFake2, 30/255);

figure(3);
subplot(1,3,1);
imshow(blackStripRealBW);
title('Real');
subplot(1,3,2);
imshow(blackStripFakeBW);
title('Fake');
subplot(1,3,3);
imshow(blackStripFake2BW);
title('Fake #2');

%% //Area open the image
figure(4);
areaopenReal = bwareaopen(blackStripRealBW, 100);
subplot(1,3,1);
imshow(areaopenReal);
title('Real');
subplot(1,3,2);
areaopenFake = bwareaopen(blackStripFakeBW, 100);
imshow(areaopenFake);
title('Fake');
subplot(1,3,3);
areaopenFake2 = bwareaopen(blackStripFake2BW, 100);
imshow(areaopenFake2);
title('Fake #2');

%% //Post-process
se = strel('square', 5);
BWImageCloseReal = imclose(areaopenReal, se);
BWImageCloseFake = imclose(areaopenFake, se);
BWImageCloseFake2 = imclose(areaopenFake2, se);
figure(5);
subplot(1,3,1);
imshow(BWImageCloseReal);
title('Real');
subplot(1,3,2);
imshow(BWImageCloseFake);
title('Fake');
subplot(1,3,3);
imshow(BWImageCloseFake2);
title('Fake #2');

%% //Count the total number of objects in this strip
[~,countReal] = bwlabel(BWImageCloseReal);
[~,countFake] = bwlabel(BWImageCloseFake);
[~,countFake2] = bwlabel(BWImageCloseFake2);
disp(['The total number of black lines for the real note is: ' num2str(countReal)]);
disp(['The total number of black lines for the fake note is: ' num2str(countFake)]);
disp(['The total number of black lines for the second fake note is: ' num2str(countFake2)]);